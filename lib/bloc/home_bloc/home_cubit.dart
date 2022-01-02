import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:majootestcase/models/movie_model.dart';
import 'package:majootestcase/services/api.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.repository) : super(HomeState());

  final RestDataSource repository;
  

  void loadMovies({key = 'game of thor'}) async {
    if (state.status == HomeStatus.initial) {
      if (state.movies.isNotEmpty) {
        state.movies.clear();
      }
    }

  
      repository.getMovie(key: key).then((List<MovieModel> newMovies) {
        List<MovieModel> dataMovies = newMovies;
        emit(state.copyWith(
            movies: List.of(state.movies)..addAll(dataMovies),
            status: HomeStatus.success,
            networkStatus: true));
      });
    
  }

  void changeStatus() {
    emit(state.copyWith(status: HomeStatus.initial));
  }
}
