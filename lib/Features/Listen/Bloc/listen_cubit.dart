import 'package:Quran/Features/Listen/Bloc/listen_states.dart';
import 'package:Quran/Features/Quran/models/surah_model.dart';
import 'package:Quran/core/utilies/easy_loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quran/quran.dart';
import 'package:rxdart/rxdart.dart';

import '../models/position_data.dart';

class ListenCubit extends Cubit<ListenStates> {
  ListenCubit() : super(ListenInitialState());

  static ListenCubit get(context) => BlocProvider.of(context);

  AudioPlayer audioPlayer = AudioPlayer();
  List<AudioSource> allSurahs = [];
  void initializeAllSurahs() {
    allSurahs = List.generate(
      114,
      (index) {
        int surahNumber = index + 1;
        return AudioSource.uri(
          Uri.parse(getAudioURLBySurah(surahNumber)),
          tag: MediaItem(
            title: getSurahNameArabic(surahNumber),
            artist: "Mishary Al-Afasy",
            album: getSurahName(surahNumber),
            id: surahNumber.toString(),
          ),
        );
      },
    );
  }

// Function to handle surah selection
  Future<void> playSurah(int surahNumber) async {

    try {
      await audioPlayer
          .setAudioSource(ConcatenatingAudioSource(children: allSurahs));
      int currentPlayingIndex = audioPlayer.currentIndex ?? 0;

      if (surahNumber - 1 != currentPlayingIndex) {
        // Seek only if the selected surah is different from the currently playing one
        await audioPlayer.seek(Duration.zero, index: surahNumber - 1);
      }

      // Start or resume playback
      if (audioPlayer.playing) {
        audioPlayer.pause(); // Pause if already playing the same surah
      } else {
        audioPlayer.play();
      }
      hideLoading();
      print("Hide loading");
    } catch (e) {
      hideLoading();
      print("Hide loading");
    }
  }

  Stream<PositionData> get positionDataStream => Rx.combineLatest5<Duration,
          Duration, Duration?, PlayerState, SequenceState?, PositionData>(
        audioPlayer.positionStream,
        audioPlayer.bufferedPositionStream,
        audioPlayer.durationStream,
        audioPlayer.playerStateStream,
        audioPlayer.sequenceStateStream,
        (position, bufferedPosition, duration, playerState, sequenceState) =>
            PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
          playerState,
          sequenceState,
        ),
      );

  SurahModel? currentSurah;
  void setCurrentSurah({
    required int surahIndex,
  }) {
    // if (currentAyah?.audio != trackUrl) {
    if (currentSurah != null) {
      removeCurrentSurah();
    }
    currentSurah = SurahModel(
      name: getSurahNameArabic(surahIndex + 1),
      number: surahIndex + 1,
      numberOfAyahs: getVerseCount(surahIndex + 1),
      englishName: getSurahNameEnglish(surahIndex + 1),
      revelationType: getPlaceOfRevelation(surahIndex + 1),
    );
    playSurah(surahIndex + 1);
    // }
    emit(SetSurahStates());
  }

  void removeCurrentSurah() {
    currentSurah = null;
    audioPlayer.stop();
  }

  void seekToNextSurah() {
    audioPlayer.seekToNext();
    emit(SeekToNextState());
  }

  void seekToPrevSurah() {
    audioPlayer.seekToPrevious();
    emit(SeekToPrevState());
  }

  int playingSurahNumber() {
    if (audioPlayer.sequence==null) {
      return 0;
    }
    return int.parse(audioPlayer.sequenceState?.currentSource?.tag?.id);
  }
}
