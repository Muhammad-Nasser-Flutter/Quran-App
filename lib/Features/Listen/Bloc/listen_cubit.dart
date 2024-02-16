import 'package:Quran/Features/Listen/Bloc/listen_states.dart';
import 'package:Quran/Features/Quran/models/surah_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';
import '../models/position_data.dart';

class ListenCubit extends Cubit<ListenStates> {
  ListenCubit() : super(ListenInitialState());

  static ListenCubit get(context) => BlocProvider.of(context);

  AudioPlayer? audioPlayer;
  List<AudioSource> list = [];

  void initHandler(
    // Ayahs currentAyah,
          {
    required SurahModel surahModel,
    required int ayahIndex,
  }) async {
    list = [];
    // to make the chosen track the first item played
    SurahModel test = SurahModel.fromJson(surahModel.toJson());
    if (ayahIndex != 0) {
      test.ayahs?.removeRange(0, ayahIndex);
    }
    // Ayahs item = test.ayahs!.removeAt(index);
    // test.ayahs!.insert(0, item);
    // adding them to the playlist
    for (var element in test.ayahs!) {
      list.add(
        AudioSource.uri(
          Uri.parse(element.audio ?? element.audioSecondary![0]),
          tag: MediaItem(
            title: element.text.toString(),
            artist: "Mushary Al Afasy",
            // artUri: Uri.parse(element.image.toString()),
            album: surahModel.name,
            id: element.numberInSurah.toString(),
          ),
        ),
      );
    }
    audioPlayer = AudioPlayer()
      ..setAudioSource(
        ConcatenatingAudioSource(children: list),
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
    // required String trackImgUrl,
    // required String trackUrl,
    // required String title,
    // required String author,
    required SurahModel surahModel,
    required int surahIndex,
  }) {
    // if (currentAyah?.audio != trackUrl) {
      if (currentSurah != null) {
        removeCurrentSurah();
      }
      print(surahIndex);
      currentSurah = SurahModel(
        name: surahModel.name,
        number: surahModel.number,
        ayahs: surahModel.ayahs,
        englishName: surahModel.englishName,
        englishNameTranslation: surahModel.englishNameTranslation,
        revelationType: surahModel.revelationType,
      );
      initHandler(ayahIndex: 0,surahModel: surahModel);
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
