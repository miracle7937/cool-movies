import 'package:flutter/material.dart';

// Colos that use in our app
const kSecondaryColor = Color(0xFFFE6D8E);
const kTextColor = Color(0xFF12153D);
const kTextLightColor = Color(0xFF9A9BB2);
const kFillStarColor = Color(0xFFFCC419);

const kDefaultPadding = 20.0;

const kDefaultShadow = BoxShadow(
  offset: Offset(0, 4),
  blurRadius: 4,
  color: Colors.black26,
);

const bgImage = "assets/bg_image.jpg";

var queryGetAllMovies = r"""
          query AllMovies {
            allMovies {
              nodes {
                id
                imgUrl
                movieDirectorId
                userCreatorId
                title
                releaseDate
                nodeId
                userByUserCreatorId {
                  id
                  name
                  nodeId
                }
              }
            }
          }
        """;

var allReviewQuery = r"""
           query  {
  allMovieReviews {
    edges {
      node {
        id
        body
        title
        rating
      }
    }
  }
}
   """;

var updateReview = """
mutation {
  
  createMovieReview(
    input: { movieReview: {  title: \$title, movieId: \$movieId, userReviewerId: \$userReviewerId,rating:\$rating, body: \$body}, clientMutationId: \$clientMutationId, }
  ) {
    clientMutationId
  }
}

""";
