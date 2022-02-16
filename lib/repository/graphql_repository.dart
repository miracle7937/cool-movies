import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLRepo {
  GraphQLRepo._privateConstructor();

  static final GraphQLRepo _instance = GraphQLRepo._privateConstructor();

  static GraphQLRepo get instance => _instance;
  HttpLink httpLink = HttpLink(
    'https://api.github.com/graphql',
  );
  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  );

  GraphQLClient getClient() {
    final Link link = authLink.concat(authLink);
    return GraphQLClient(
      link: link,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(store: HiveStore()),
    );
  }
}
