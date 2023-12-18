class AnswerAssignmentModel {
  int code;
  String status;
  Assignments assignmentQuiz;

  AnswerAssignmentModel({
    this.code = 0,
    this.status = "no-status",
    required this.assignmentQuiz,
  });

  factory AnswerAssignmentModel.fromJson(Map<String, dynamic> json) => AnswerAssignmentModel(
        code: json["code"],
        status: json["status"],
        assignmentQuiz: Assignments.fromJson(json["data"]),
      );
}

class Assignments {
  int id;
  String title;
  String? image;
  AssignmentQuiz? getAnswer;
  List<AssignmentQuiz> getCmt;

  Assignments({
    this.id = 0,
    this.title = "no-title",
    this.image,
    this.getAnswer,
    this.getCmt = const [],
  });

  factory Assignments.fromJson(Map<String, dynamic> json) => Assignments(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        getAnswer: json["get_answer"] == null? null : AssignmentQuiz.fromJson(json["get_answer"]),
        getCmt: List<AssignmentQuiz>.from(json["get_cmt"].map((x) => AssignmentQuiz.fromJson(x))),
      );
}

class AssignmentQuiz {
  int id;
  String title;
  String? image;
  String? score;

  AssignmentQuiz({
    this.id = 0,
    this.title = "no-title",
    this.image,
    this.score,
  });

  factory AssignmentQuiz.fromJson(Map<String, dynamic> json) => AssignmentQuiz(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        score: json["score"],
      );
}
