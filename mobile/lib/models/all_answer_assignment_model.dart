class AllAnswerAssignmentModel {
  int code;
  String status;
  AllAnswerAssignment allAnswerAssignment;

  AllAnswerAssignmentModel({
     this.code = 0,
     this.status = "no-status",
    required this.allAnswerAssignment,
  });

  factory AllAnswerAssignmentModel.fromJson(Map<String, dynamic> json) => AllAnswerAssignmentModel(
        code: json["code"],
        status: json["status"],
        allAnswerAssignment: AllAnswerAssignment.fromJson(json["data"]),
      );
}

class AllAnswerAssignment {
  int id;
  String question;
  List<AllAnswer> allAnswer;

  AllAnswerAssignment({
    this.id = 0,
    this.question = "no-question",
    this.allAnswer = const [],
  });

  factory AllAnswerAssignment.fromJson(Map<String, dynamic> json) => AllAnswerAssignment(
        id: json["id"],
        question: json["question"],
        allAnswer: List<AllAnswer>.from(json["all_answer"].map((x) => AllAnswer.fromJson(x))),
      );
}

class AllAnswer {
  int id;
  int subjectId;
  int assignmentId;
  String? score;
  String title;
  String? image;
  int userId;

  AllAnswer({
    this.id = 0,
    this.subjectId = 0,
    this.assignmentId = 0,
    this.score,
    this.title = "no-title",
    this.image,
    this.userId = 0,
  });

  factory AllAnswer.fromJson(Map<String, dynamic> json) => AllAnswer(
        id: json["id"],
        subjectId: json["subject_id"],
        assignmentId: json["assignment_id"],
        score: json["score"],
        title: json["title"],
        image: json["image"],
        userId: json["user_id"],
      );
}
