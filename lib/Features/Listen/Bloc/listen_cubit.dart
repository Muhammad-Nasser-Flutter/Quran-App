import 'package:Quran/Features/Listen/Bloc/listen_states.dart';
import 'package:Quran/Features/Quran/models/surah_model.dart';
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
  List<AudioSource> surahsToPlay = [];
  void initHandler(
      // Ayahs currentAyah,
      {
    required SurahModel surahModel,
    required int ayahIndex,
  }) async {
    // to make the chosen track the first item played
    SurahModel test = SurahModel.fromJson(surahModel.toJson());
    // we're making a playlist of surahs from the chosen one to the end
    surahsToPlay = List.generate(
      // as quran has 114 surahs
      115 - surahModel.number!,
      (index) => AudioSource.uri(
        Uri.parse(
          getAudioURLBySurah(index + surahModel.number!),
        ),
        tag: MediaItem(
          title: getSurahNameArabic(index + surahModel.number!),
          artist: "Mushary Al Afasy",
          // artUri: Uri.parse(element.image.toString()),
          album: getSurahNameEnglish(index + surahModel.number!),
          id: (index + surahModel.number!).toString(),
        ),
      ),
    );
    if(audioPlayer!=null){
      await audioPlayer!.dispose();
    }
    audioPlayer = AudioPlayer()
      ..setAudioSource(
        ConcatenatingAudioSource(children: surahsToPlay),
      )
      ..play()
      ..setLoopMode(LoopMode.off);
    // audioPlayer = AudioPlayer()..setUrl(currentAyah.audio!);
    emit(InitAudioHandlerSuccessState());
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
    print(surahIndex);
    currentSurah = SurahModel(
      name: getSurahNameArabic(surahIndex + 1),
      number: surahIndex + 1,
      numberOfAyahs: getVerseCount(surahIndex + 1),
      englishName: getSurahNameEnglish(surahIndex + 1),
      revelationType: getPlaceOfRevelation(surahIndex + 1),
    );
    initHandler(ayahIndex: 0, surahModel: currentSurah!);
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
}
