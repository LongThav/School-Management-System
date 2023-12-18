class CommentQuizModel {
  int code;
  String status;
  Quize quize;

  CommentQuizModel({
    this.code = 9,
    this.status = "no-status",
    required this.quize,
  });

  factory CommentQuizModel.fromJson(Map<String, dynamic> json) =>
      CommentQuizModel(
        code: json["code"],
        status: json["status"],
        quize: Quize.fromJson(json["data"]),
      );
}

class Quize {
  int id;
  String title;
  String? image;
  List<Cmt> cmt;

  Quize({
    this.id = 0,
    this.title = "no-title",
    this.image,
    this.cmt = const [],
  });

  factory Quize.fromJson(Map<String, dynamic> json) => Quize(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        cmt: List<Cmt>.from(json["cmt"].map((x) => Cmt.fromJson(x))),
      );
}

class Cmt {
  int id;
  String title;
  String? image;
  Cmt({
    this.id = 0,
    this.title = "no-title",
    this.image,
  });

  factory Cmt.fromJson(Map<String, dynamic> json) => Cmt(
        id: json["id"],
        title: json["title"],
        image: json["image"],
      );
}
