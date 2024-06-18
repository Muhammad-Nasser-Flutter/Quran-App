abstract class ReadStates{}

class QuranInitialState extends ReadStates{}

class GetQuranSuccessState extends ReadStates{}
class GetQuranErrorState extends ReadStates{}



class GetQuranSurahsSuccessState extends ReadStates{}
class GetQuranSurahsErrorState extends ReadStates{}


class InitAudioHandlerSuccessFromReadState extends ReadStates{}
class SetAyahSuccessStates extends ReadStates{}
class SetAyahErrorStates extends ReadStates{}

class SetLastReadState extends ReadStates{}
class PausePlayerState extends ReadStates{}
class ResumePlayerState extends ReadStates{}
