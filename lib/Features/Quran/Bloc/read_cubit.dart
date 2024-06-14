import 'package:Quran/Features/Quran/Bloc/read_states.dart';
import 'package:Quran/core/utilies/easy_loading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quran/quran.dart';

import '../../../core/Api/endPoints.dart';
import '../../../core/Api/my_dio.dart';
import '../../Listen/models/position_data.dart';
import '../models/ayah_model.dart';
import '../models/quran_model.dart';
import '../models/surah_model.dart';
import 'package:rxdart/rxdart.dart';

class ReadCubit extends Cubit<ReadStates> {
  ReadCubit() : super(QuranInitialState());
  static ReadCubit get(context) => BlocProvider.of(context);

  AudioPlayer? audioPlayer;
  List<AudioSource> ayahsToPlay = [];
  void initHandler(
      // Ayahs currentAyah,
      {
    required int numberOfAyahsInSurah,
    required AyahModel ayahModel,
  }) async {
    // to make the chose n track the first item played
    SurahModel test = SurahModel.fromJson(ayahModel.toJson());
    print("$numberOfAyahsInSurah : ${ayahModel.numberInSurah!} ");
    // we're making a playlist of ayahs from the chosen one to the end
    print(ayahModel.surahNumber);
    ayahsToPlay = List.generate(
      (numberOfAyahsInSurah - ayahModel.numberInSurah!)+1,
      (index) => AudioSource.uri(
        Uri.parse(
          getAudioURLByVerse(
            ayahModel.surahNumber!,
            index + ayahModel.numberInSurah!,
          ),
        ),
        tag: MediaItem(
          title: ayahModel.name!,
          artist: "Mushary Al Afasy",
          album: ayahModel.translationInEnglish,
          id: ayahModel.numberInSurah!.toString(),
        ),
      ),
    );
    print(ayahsToPlay.length);
    if (audioPlayer != null) {
      await audioPlayer!.dispose();
    }
    audioPlayer = AudioPlayer()
      ..setAudioSource(
        ConcatenatingAudioSource(children: ayahsToPlay),
      )
      ..play()
      ..setLoopMode(LoopMode.off);
    // audioPlayer = AudioPlayer()..setUrl(currentAyah.audio!);
    emit(InitAudioHandlerSuccessFromReadState());
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

  AyahModel? currentAyah;
  void setCurrentAyah({required int ayahNumber, required int surahNumber}) {
    if (currentAyah != null) {
      removeCurrentAyah();
    }
    print(ayahNumber);
    currentAyah = AyahModel(
      name: getVerse(surahNumber, ayahNumber),
      numberInSurah: ayahNumber,
      translationInEnglish: getVerseTranslation(surahNumber, ayahNumber),
      revelationType: getPlaceOfRevelation(ayahNumber),
      surahNumber: surahNumber,
    );
    initHandler(
      ayahModel: currentAyah!,
      numberOfAyahsInSurah: getVerseCount(surahNumber),
    );
    emit(SetAyahStates());
  }

  void removeCurrentAyah() {
    currentAyah = null;
    audioPlayer!.stop();
  }
  void removePlayer() {
    currentAyah = null;
    audioPlayer!.stop();
    audioPlayer!.dispose();
  }
}
