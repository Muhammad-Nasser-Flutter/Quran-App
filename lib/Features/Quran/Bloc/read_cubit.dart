import 'package:Quran/Features/Listen/Bloc/listen_cubit.dart';
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
import '../../../core/cache_helper/cache_helper.dart';
import '../../../core/cache_helper/cache_values.dart';
import '../../Listen/models/position_data.dart';
import '../models/ayah_model.dart';
import '../models/quran_model.dart';
import '../models/surah_model.dart';
import 'package:rxdart/rxdart.dart';

class ReadCubit extends Cubit<ReadStates> {
  ReadCubit() : super(QuranInitialState());
  static ReadCubit get(context) => BlocProvider.of(context);

  AudioPlayer audioPlayer = AudioPlayer();
  List<AudioSource> surahAyahs = [];

  void setLastReadSurahAndAyah(int surahNumber, int ayahNumber) {
    CacheHelper.saveData(key: CacheKeys.lastReadSurah, value: surahNumber);
    CacheHelper.saveData(key: CacheKeys.lastReadAyah, value: ayahNumber);
    emit(SetLastReadState());
  }
  void initializeAllAyahsFromSurah(int surahNumber) {
    surahAyahs = List.generate(
      getVerseCount(surahNumber),
      (index) {
        // int surahNumber = index ;
        return AudioSource.uri(
          Uri.parse(getAudioURLByVerse(surahNumber, index + 1)),
          tag: MediaItem(
            title: getVerse(surahNumber, index + 1),
            artist: "Mishary Al-Afasy",
            album: surahNumber.toString(),
            id: (index + 1).toString(),
          ),
        );
      },
    );
  }

  void initializeAllAyahsFromJuz(Map<String, dynamic> data) {
    surahAyahs = List.generate(
      data["numberOfAyahs"],
      (index) {
        // int surahNumber = index ;
        return AudioSource.uri(
          Uri.parse(getAudioURLByVerse(
              data["surahNumber"], data["startingAyah"] + index)),
          tag: MediaItem(
            title: getVerse(data["surahNumber"], data["startingAyah"] + index),
            artist: "Mishary Al-Afasy",
            album: data["surahNumber"].toString(),
            id: (data["startingAyah"] + index).toString(),
          ),
        );
      },
    );
  }

  void initializeAllAyahsFromPage(Map<String, dynamic> data) {
    surahAyahs = List.generate(
      data["numberOfAyahs"],
      (index) {
        // int surahNumber = index ;
        return AudioSource.uri(
          Uri.parse(getAudioURLByVerse(
              data["surahNumber"], data["startingAyah"] + index)),
          tag: MediaItem(
            title: getVerse(data["surahNumber"], data["startingAyah"] + index),
            artist: "Mishary Al-Afasy",
            album: data["surahNumber"].toString(),
            id: (data["startingAyah"] + index).toString(),
          ),
        );
      },
    );
  }

  Future<void> playAyah(int ayahNumber,
      {required int startingAyah,
      int? currentSurahNumber,
      required int surahNumber}) async {
    print("xx");
    currentAyah = AyahModel(
        numberInSurah: ayahNumber,
        name: getVerse(surahNumber, ayahNumber),
        translationInEnglish: getVerseTranslation(surahNumber, ayahNumber),
        revelationType: getPlaceOfRevelation(surahNumber),
        surahNumber: surahNumber);
    print("yy");
    try {
      audioPlayer.sequence?.clear();
      print("zz");
      // 2. Create AudioSource for the selected ayah
      final ayahAudioSource = AudioSource.uri(
        Uri.parse(getAudioURLByVerse(surahNumber, ayahNumber)),
        tag: MediaItem(
          title: getVerse(surahNumber, ayahNumber),
          artist: "Mishary Al-Afasy",
          album: surahNumber.toString(),
          id: ayahNumber.toString(),
        ),
      );

      // 3. Set the new AudioSource and play
      await audioPlayer.setAudioSource(ayahAudioSource);
      audioPlayer.play();
      print("aaa");
      hideLoading();
      print("Hide loading");
      emit(SetAyahSuccessStates());
    } catch (e) {
      print(e.toString());
      hideLoading();
      emit(SetAyahErrorStates());
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

  AyahModel? currentAyah;
  void setCurrentAyah(
      {required int ayahNumber,
      required int surahNumber,
      required context,
      required int startingAyahNumber}) {
    showLoading();
    print("Showed loading");

    if (ListenCubit.get(context).audioPlayer.sequence != null) {
      ListenCubit.get(context).audioPlayer.stop();
      print("audio player disposed");
    }
    if(audioPlayer.playing) {
      removePlayer();
    }
    print("xx");
    print(ayahNumber);
    currentAyah = AyahModel(
      name: getVerse(surahNumber, ayahNumber),
      numberInSurah: ayahNumber,
      translationInEnglish: getVerseTranslation(surahNumber, ayahNumber),
      revelationType: getPlaceOfRevelation(surahNumber),
      surahNumber: surahNumber,
    );
    print(currentAyah?.toJson().toString());
    playAyah(ayahNumber,
        startingAyah: startingAyahNumber, surahNumber: surahNumber);
  }

  void removeCurrentAyah() {
    currentAyah = null;
    audioPlayer.stop();
  }

  void removePlayer() {
    currentAyah = null;
    audioPlayer.stop();
  }
}
