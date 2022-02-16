import 'package:coolmovies/constants.dart';
import 'package:coolmovies/data_layer/models/movies_response.dart';
import 'package:coolmovies/data_layer/models/review_model.dart';
import 'package:coolmovies/screens/details/components/flutter_acton_bottom_sheet.dart';
import 'package:coolmovies/screens/details/components/rating_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ReviewWidget extends StatelessWidget {
  final Nodes? movie;
  const ReviewWidget({Key? key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
          document: gql(allReviewQuery),
          pollInterval: const Duration(minutes: 1),
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
          var data = ReviewData.fromJson(result.data!);
          List<Edges>? edge = data.allMovieReviews?.edges;

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: edge!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                Node? node = edge[i].node;
                String title = node!.title!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              var data = await bottomSheetRating(context,
                                      node: node, movie: movie) ??
                                  false;
                              if (data == true) {
                                Scaffold.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Action is successful"),
                                        duration: Duration(seconds: 2)));
                              }
                            },
                            child: const Text(
                              "Edit",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 15),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(child: Text(node.title!)),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: StarRating(
                            rating: double.tryParse(node.rating!.toString())!,
                          )),
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(node.body!),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
