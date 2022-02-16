import 'package:coolmovies/data_layer/models/movie.dart';
import 'package:coolmovies/data_layer/models/movies_response.dart';
import 'package:coolmovies/screens/details/components/review_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'backdrop_rating.dart';
import 'cast_and_crew.dart';
import 'title_duration_and_fav_btn.dart';

class Body extends StatelessWidget {
  final Nodes? movie;

  const Body({Key? key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // it will provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BackdropAndRating(size: size, movie: movie!),
          const SizedBox(height: kDefaultPadding / 2),
          TitleDurationAndFabBtn(movie: movie!),
          // Genres(movie: movie!),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding / 2,
              horizontal: kDefaultPadding,
            ),
            child: Text(
              "Plot Summary",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text(
              movie!.title!,
              style: const TextStyle(
                color: Color(0xFF737599),
              ),
            ),
          ),
          CastAndCrew(casts: movies.first.cast!),
          ReviewWidget(
            movie: movie,
          ),
        ],
      ),
    );
  }
}