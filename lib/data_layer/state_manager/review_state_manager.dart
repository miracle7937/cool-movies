import 'package:coolmovies/data_layer/cubit_state/review_state.dart';
import 'package:coolmovies/repository/movies_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final MoviesRepository _moviesRepository;
  ReviewCubit({MoviesRepository? moviesRepository})
      : _moviesRepository = moviesRepository!,
        super(ReviewState());

  // fetchRating() {
  //   moviesRepository.
  // }
}
