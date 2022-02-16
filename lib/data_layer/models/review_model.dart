class ReviewModel {
  ReviewData? data;

  ReviewModel({this.data});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? ReviewData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ReviewData {
  AllMovieReviews? allMovieReviews;

  ReviewData({this.allMovieReviews});

  ReviewData.fromJson(Map<String, dynamic> json) {
    allMovieReviews = json['allMovieReviews'] != null
        ? AllMovieReviews.fromJson(json['allMovieReviews'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allMovieReviews != null) {
      data['allMovieReviews'] = this.allMovieReviews!.toJson();
    }
    return data;
  }
}

class AllMovieReviews {
  List<Edges>? edges;

  AllMovieReviews({this.edges});

  AllMovieReviews.fromJson(Map<String, dynamic> json) {
    if (json['edges'] != null) {
      edges = <Edges>[];
      json['edges'].forEach((v) {
        edges!.add(Edges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.edges != null) {
      data['edges'] = this.edges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Edges {
  Node? node;

  Edges({this.node});

  Edges.fromJson(Map<String, dynamic> json) {
    node = json['node'] != null ? new Node.fromJson(json['node']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.node != null) {
      data['node'] = this.node!.toJson();
    }
    return data;
  }
}

class Node {
  String? id;
  String? body;
  String? title;
  int? rating;

  Node({this.id, this.body, this.title, this.rating});

  Node.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    title = json['title'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['title'] = this.title;
    data['rating'] = this.rating;
    return data;
  }
}
