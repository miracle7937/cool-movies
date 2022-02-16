import 'package:coolmovies/data_layer/models/movies_response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'graphql_repository.dart';

class MoviesRepository {
  late final GraphQLClient client;
  MoviesRepository(this.client);
  Future<MoviesModelData> getAllMovies() async {
    final QueryResult result = await client.query(QueryOptions(
      document: gql(r"""
          query MyQuery {
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
          
        """),
    ));

    var data = MoviesModelData.fromJson(result.data!);
    print(result);
    return data;
  }

  getAllReview() async {
    print("heat");
    final QueryResult result = await GraphQLRepo.instance.getClient().query(
          QueryOptions(
            document: gql(r"""
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
   """),
          ),
        );
    print(result);
  }
}
