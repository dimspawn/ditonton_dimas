part of 'now_playing_bloc.dart';

abstract class NowPlayingMoviesEvent {
  const NowPlayingMoviesEvent();
}

class InitiateNowPlayingMoviesEvent extends NowPlayingMoviesEvent {
  const InitiateNowPlayingMoviesEvent();
}
