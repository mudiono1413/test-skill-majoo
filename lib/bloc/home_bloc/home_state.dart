part of 'home_cubit.dart';

class HomeState extends Equatable {
  final HomeStatus status;
  final List<MovieModel> movies;
  final int isFirstFetch;
  final bool networkStatus;
  const HomeState(
      {this.status = HomeStatus.initial,
      this.movies = const <MovieModel>[],
      this.isFirstFetch = 1,
      this.networkStatus = false});

  HomeState copyWith(
      {HomeStatus? status, List<MovieModel>? movies, int? isFirstFetch, bool? networkStatus}) {
    return HomeState(
        status: status ?? this.status,
        movies: movies ?? this.movies,
        isFirstFetch: isFirstFetch ?? this.isFirstFetch,
        networkStatus: networkStatus ?? this.networkStatus);
  }

  @override
  List<Object?> get props => [status, movies, isFirstFetch];
}

enum HomeStatus { initial, success, failure }
