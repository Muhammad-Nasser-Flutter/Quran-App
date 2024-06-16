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

  AudioPlayer? audioPlayer;
  List<AudioSource> allSurahs = [];
  // void initHandler(
  //     // Ayahs currentAyah,
  //     {
  //   required SurahModel surahModel,
  //   required int ayahIndex,
  // }) async {
  //   // we're making a playlist of surahs from the chosen one to the end
  //   surahsToPlay = List.generate(
  //     // as quran has 114 surahs
  //     115 - surahModel.number!,
  //     (index) => AudioSource.uri(
  //       Uri.parse(
  //         getAudioURLBySurah(index + surahModel.number!),
  //       ),
  //       tag: MediaItem(
  //         title: getSurahNameArabic(index + surahModel.number!),
  //         artist: "Mushary Al Afasy",
  //         // artUri: Uri.parse(element.image.toString()),
  //         album: getSurahNameEnglish(index + surahModel.number!),
  //         id: (index + surahModel.number!).toString(),
  //       ),
  //     ),
  //   );
  //
  //   if(audioPlayer!=null){
  //     await audioPlayer!.dispose();
  //   }
  //   audioPlayer = AudioPlayer()
  //     ..setAudioSource(
  //       ConcatenatingAudioSource(children: surahsToPlay),
  //     )
  //     ..play()
  //     ..setLoopMode(LoopMode.off);
  //   // audioPlayer = AudioPlayer()..setUrl(currentAyah.audio!);
  //   emit(InitAudioHandlerSuccessState());
  // }
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
      if (audioPlayer == null) {
        // Initialize the player if it doesn't exist
        audioPlayer = AudioPlayer();
        await audioPlayer!
            .setAudioSource(ConcatenatingAudioSource(children: allSurahs));
      }

      int currentPlayingIndex = audioPlayer!.currentIndex ?? 0;

      if (surahNumber - 1 != currentPlayingIndex) {
        // Seek only if the selected surah is different from the currently playing one
        await audioPlayer!.seek(Duration.zero, index: surahNumber - 1);
      }

      // Start or resume playback
      if (audioPlayer!.playing) {
        audioPlayer!.pause(); // Pause if already playing the same surah
      } else {
        audioPlayer!.play();
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
        audioPlayer!.positionStream,
        audioPlayer!.bufferedPositionStream,
        audioPlayer!.durationStream,
        audioPlayer!.playerStateStream,
        audioPlayer!.sequenceStateStream,
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
    audioPlayer!.stop();
  }

  void seekToNextSurah() {
    audioPlayer?.seekToNext();
    emit(SeekToNextState());
  }

  void seekToPrevSurah() {
    audioPlayer?.seekToPrevious();
    emit(SeekToPrevState());
  }

  int playingSurahNumber() {
    if (audioPlayer == null) {
      return 0;
    }
    return int.parse(audioPlayer?.sequenceState?.currentSource?.tag?.id) ?? 0;
  }
}
