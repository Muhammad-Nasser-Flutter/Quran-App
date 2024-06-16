abstract class ListenStates {}

class ListenInitialState extends ListenStates{}
class SeekToNextState extends ListenStates{}
class SeekToPrevState extends ListenStates{}
class SetSurahStates extends ListenStates{}
class InitAudioHandlerSuccessState extends ListenStates{}
class GetPlayingSurahNumberState extends ListenStates{}