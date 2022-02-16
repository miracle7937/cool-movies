import 'package:coolmovies/data_layer/models/movies_response.dart';
import 'package:coolmovies/data_layer/models/review_model.dart';
import 'package:coolmovies/screens/details/components/rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../constants.dart';

Future bottomSheetRating(BuildContext context,
    {bool isEdit = true, Node? node, Nodes? movie}) {
  return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              UpdateRatingBody(
                isEdit: isEdit,
                node: node,
                movie: movie,
              ),
            ],
          ),
        );
      });
}

class UpdateRatingBody extends StatefulWidget {
  final bool isEdit;
  final Node? node;
  final Nodes? movie;
  const UpdateRatingBody({
    Key? key,
    this.isEdit = true,
    this.node,
    this.movie,
  }) : super(key: key);

  @override
  State<UpdateRatingBody> createState() => _UpdateRatingBodyState();
}

class _UpdateRatingBodyState extends State<UpdateRatingBody> {
  late TextEditingController titleController;
  late TextEditingController bodyController;
  double rating = 0;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.node?.title);
    bodyController = TextEditingController(text: widget.node?.body);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
            widget.isEdit == true ? "EDIT" : "Create",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffbfc9da))),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              hintText: 'Title',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: bodyController,
            maxLines: 6,
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.greenAccent, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green, width: 1),
              ),
              hintText: 'body',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: StarRating(
              rating: rating,
              onRatingChanged: (i) {
                setState(() {
                  rating = i;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Mutation(
              options: MutationOptions(
                document: gql(updateReview),
                update: (GraphQLDataProxy? cache, QueryResult? result) {
                  return cache;
                },
                onCompleted: (dynamic resultData) {
                  Navigator.pop(context, true);
                },
              ),
              builder: (
                RunMutation? runMutation,
                QueryResult? result,
              ) {
                return ElevatedButton(
                  onPressed: () => runMutation!({
                    'title': titleController.text,
                    "movieId": widget.movie!.id,
                    "userReviewerId": widget.movie!.userCreatorId,
                    "rating": rating,
                    "body": bodyController,
                    "clientMutationId": widget.movie!.userCreatorId
                  }),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 17, horizontal: 100),
                    child: Text("Summit"),
                  ),
                );
              })
        ],
      ),
    );
  }
}
