class AllAnswerMidtermModel {
  int code;
  String status;
  AllAnswerMidterm allAnswerMidterm;

  AllAnswerMidtermModel({
    this.code = 0,
    this.status = "no-status",
    required this.allAnswerMidterm,
  });

  factory AllAnswerMidtermModel.fromJson(Map<String, dynamic> json) => AllAnswerMidtermModel(
        code: json["code"],
        status: json["status"],
        allAnswerMidterm: AllAnswerMidterm.fromJson(json["data"]),
      );
}

class AllAnswerMidterm {
  int id;
  String question;
  List<AllAnswer> allAnswer;

  AllAnswerMidterm({
    this.id = 0,
    this.question = "no-question",
    this.allAnswer = const [],
  });

  factory AllAnswerMidterm.fromJson(Map<String, dynamic> json) => AllAnswerMidterm(
        id: json["id"],
        question: json["question"],
        allAnswer: List<AllAnswer>.from(json["all_answer"].map((x) => AllAnswer.fromJson(x))),
      );
}

class AllAnswer {
  int id;
  int subjectId;
  int midtermId;
  String title;
  String? image;
  String? score;
  int userId;

  AllAnswer({
    this.id = 0,
    this.subjectId = 0,
    this.midtermId = 0,
    this.score,
    this.title = "no-title",
    this.image,
    this.userId = 0,
  });

  factory AllAnswer.fromJson(Map<String, dynamic> json) => AllAnswer(
        id: json["id"],
        subjectId: json["subject_id"],
        midtermId: json["midterm_id"],
        title: json["title"],
        image: json["image"],
        userId: json["user_id"],
        score: json["score"],
      );
}
