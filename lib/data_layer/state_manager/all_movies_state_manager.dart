import 'package:coolmovies/data_layer/cubit_state/all_movies_state.dart';
import 'package:coolmovies/repository/movies_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MoviesCubit extends Cubit<AllMoviesState> {
  final MoviesRepository _moviesRepository;
  MoviesCubit({MoviesRepository? moviesRepository})
      : _moviesRepository = moviesRepository!,
        super(const AllMoviesState());

  getAllMovies(GraphQLClient client) async {
    try {
      emit(state.copyWith(busy: true));
      await Future.delayed(const Duration(seconds: 4));
      var data = await _moviesRepository.getAllMovies();
      print(data.allMovies?.nodes?.first.toJson());
      if (data.allMovies != null) {
        emit(state.copyWith(busy: false, moviesModelData: data));
      }
    } catch (e) {
      emit(state.copyWith(
          busy: true, moviesErrorStatus: MoviesErrorStatus.generic));
    }
  }
}
