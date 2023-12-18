class CommentAssignmentModel {
  int code;
  String status;
  Assignment assignment;

  CommentAssignmentModel({
    this.code = 9,
    this.status = "no-status",
    required this.assignment,
  });

  factory CommentAssignmentModel.fromJson(Map<String, dynamic> json) =>
      CommentAssignmentModel(
        code: json["code"],
        status: json["status"],
        assignment: Assignment.fromJson(json["data"]),
      );
}

class Assignment {
  int id;
  String title;
  String? image;
  List<Cmt> cmt;

  Assignment({
    this.id = 0,
    this.title = "no-title",
    this.image,
    this.cmt = const [],
  });

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
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
