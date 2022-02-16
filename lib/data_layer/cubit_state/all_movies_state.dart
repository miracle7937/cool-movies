import 'package:coolmovies/data_layer/models/movies_response.dart';
import 'package:equatable/equatable.dart';

class AllMoviesState extends Equatable {
  /// True if the cubit is processing something.
  final bool busy;
  final MoviesModelData? moviesModelData;
  final MoviesErrorStatus moviesErrorStatus;
  const AllMoviesState({
    this.busy = false,
    this.moviesModelData,
    this.moviesErrorStatus = MoviesErrorStatus.none,
  });
  AllMoviesState copyWith({
    bool busy = false,
    MoviesModelData? moviesModelData,
    MoviesErrorStatus moviesErrorStatus = MoviesErrorStatus.none,
  }) {
    return AllMoviesState(
        busy: busy,
        moviesModelData: moviesModelData,
        moviesErrorStatus: moviesErrorStatus);
  }

  @override
  List<Object> get props => [busy];
}

enum MoviesErrorStatus {
  ///  No errors
  none,

  ///  Generic error
  generic,
}
