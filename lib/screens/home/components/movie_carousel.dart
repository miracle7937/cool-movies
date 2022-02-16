import 'dart:math' as math;

import 'package:coolmovies/data_layer/models/movies_response.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../constants.dart';
import 'movie_card.dart';

class MovieCarousel extends StatefulWidget {
  @override
  _MovieCarouselState createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  late PageController _pageController;
  int initialPage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      // so that we can have small portion shown on left and right side
      viewportFraction: 0.8,
      // by default our movie poster
      initialPage: initialPage,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(queryGetAllMovies),
        pollInterval: const Duration(seconds: 10),
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var data = MoviesModelData.fromJson(result.data!);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
          child: AspectRatio(
            aspectRatio: 0.85,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  initialPage = value;
                });
              },
              controller: _pageController,
              physics: const ClampingScrollPhysics(),
              itemCount:
                  data.allMovies?.nodes?.length ?? 0, // we have 3 demo movies
              itemBuilder: (context, index) =>
                  buildMovieSlider(index, data.allMovies!.nodes![index]),
            ),
          ),
        );
      },
    );
  }

  Widget buildMovieSlider(int index, Nodes nodes) => AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          double value = 0;
          if (_pageController.position.haveDimensions) {
            value = index - _pageController.page!.toDouble();
            // We use 0.038 because 180*0.038 = 7 almost and we need to rotate our poster 7 degree
            // we use clamp so that our value vary from -1 to 1
            value = (value * 0.038).clamp(-1, 1);
          }
          return AnimatedOpacity(
            duration: Duration(milliseconds: 350),
            opacity: initialPage == index ? 1 : 0.4,
            child: Transform.rotate(
              angle: math.pi * value,
              child: MovieCard(
                movie: nodes,
              ),
            ),
          );
        },
      );
}
