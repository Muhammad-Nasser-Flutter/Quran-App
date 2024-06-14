abstract class ReadStates{}

class QuranInitialState extends ReadStates{}

class GetQuranSuccessState extends ReadStates{}
class GetQuranErrorState extends ReadStates{}



class GetQuranSurahsSuccessState extends ReadStates{}
class GetQuranSurahsErrorState extends ReadStates{}


class InitAudioHandlerSuccessFromReadState extends ReadStates{}
class SetAyahStates extends ReadStates{}
