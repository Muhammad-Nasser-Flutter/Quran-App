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
import '../../Listen/models/position_data.dart';
import '../models/ayah_model.dart';
import '../models/quran_model.dart';
import '../models/surah_model.dart';
import 'package:rxdart/rxdart.dart';

class ReadCubit extends Cubit<ReadStates> {
  ReadCubit() : super(QuranInitialState());
  static ReadCubit get(context) => BlocProvider.of(context);

  AudioPlayer? audioPlayer;
  List<AudioSource> surahAyahs = [];
  // List<AudioSource> ayahsToPlay = [];
  // void initHandler(
  //     // Ayahs currentAyah,
  //     {
  //   required int numberOfAyahsInSurah,
  //   required AyahModel ayahModel,
  // }) async {
  //   // to make the chose n track the first item played
  //   print("$numberOfAyahsInSurah : ${ayahModel.numberInSurah!} ");
  //   // we're making a playlist of ayahs from the chosen one to the end
  //   print(ayahModel.surahNumber);
  //   ayahsToPlay = List.generate(
  //     (numberOfAyahsInSurah - ayahModel.numberInSurah!)+1,
  //     (index) => AudioSource.uri(
  //       Uri.parse(
  //         getAudioURLByVerse(
  //           ayahModel.surahNumber!,
  //           index + ayahModel.numberInSurah!,
  //         ),
  //       ),
  //       tag: MediaItem(
  //         title: ayahModel.name!,
  //         artist: "Mushary Al Afasy",
  //         album: ayahModel.translationInEnglish,
  //         id: ayahModel.numberInSurah!.toString(),
  //       ),
  //     ),
  //   );
  //   print(ayahsToPlay.length);
  //   if (audioPlayer != null) {
  //     await audioPlayer!.dispose();
  //   }
  //   audioPlayer = AudioPlayer()
  //     ..setAudioSource(
  //       ConcatenatingAudioSource(children: ayahsToPlay),
  //     )
  //     ..play()
  //     ..setLoopMode(LoopMode.off);
  //   // audioPlayer = AudioPlayer()..setUrl(currentAyah.audio!);
  //   emit(InitAudioHandlerSuccessFromReadState());
  // }
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
            album: getVerseTranslation(surahNumber, index + 1),
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
          Uri.parse(getAudioURLByVerse(data["surahNumber"], data["startingAyah"] + index )),
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
          Uri.parse(getAudioURLByVerse(data["surahNumber"], data["startingAyah"] + index )),
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
  Future<void> playAyah(int ayahNumber,{required int startingAyah,required int surahNumber}) async {
    try{
      if (audioPlayer == null) {
        // Initialize the player if it doesn't exist
        print("here");
        audioPlayer = AudioPlayer();
        audioPlayer!.setAudioSource(ConcatenatingAudioSource(children: surahAyahs));
      }

      int currentPlayingIndex = audioPlayer?.currentIndex ?? 0;
      if (ayahNumber - startingAyah != currentPlayingIndex) {
        // Seek only if the selected surah is different from the currently playing one
        await audioPlayer!.seek(Duration.zero, index: ayahNumber - startingAyah);
      }

      // Start or resume playback
      if (audioPlayer!.playing) {
        audioPlayer!.pause(); // Pause if already playing the same surah
      } else {
        audioPlayer!.play();
      }
      hideLoading();
      print("Hide loading");
    }catch(e){
      hideLoading();
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

  AyahModel? currentAyah;
  void setCurrentAyah({required int ayahNumber, required int surahNumber,required context,required int startingAyahNumber}) {
    showLoading();
    print("Showed loading");
    if(ListenCubit.get(context).audioPlayer!=null){
      ListenCubit.get(context).audioPlayer!.stop();
      print("audio player disposed");
    }
      removePlayer();
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
    playAyah(ayahNumber,startingAyah: startingAyahNumber,surahNumber: surahNumber);
    emit(SetAyahStates());
  }

  void removeCurrentAyah() {
    currentAyah = null;
    audioPlayer!.stop();

  }
  void removePlayer() {
    currentAyah = null;
    audioPlayer?.stop();
    audioPlayer = null;
  }
}
