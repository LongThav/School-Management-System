class AllAnswerQuizModel {
  int code;
  String status;
  AllAnswerQuiz answerQuiz;

  AllAnswerQuizModel({
    this.code = 0,
    this.status = "no-status",
    required this.answerQuiz,
  });

  factory AllAnswerQuizModel.fromJson(Map<String, dynamic> json) => AllAnswerQuizModel(
        code: json["code"],
        status: json["status"],
        answerQuiz: AllAnswerQuiz.fromJson(json["data"]),
      );
}

class AllAnswerQuiz {
  int id;
  String question;
  List<AllAnswer> allAnswer;

  AllAnswerQuiz({
    this.id = 0,
    this.question = "no-question",
    this.allAnswer = const [],
  });

  factory AllAnswerQuiz.fromJson(Map<String, dynamic> json) => AllAnswerQuiz(
        id: json["id"],
        question: json["question"],
        allAnswer: List<AllAnswer>.from(json["all_answer"].map((x) => AllAnswer.fromJson(x))),
      );
}

class AllAnswer {
  int id;
  int subjectId;
  int quizId;
  String title;
  String? image;
  String? score;
  int userId;

  AllAnswer({
    this.id = 0,
    this.subjectId = 0,
    this.quizId = 0,
    this.title = "no-title",
    this.image,
    this.score,
    this.userId = 0,
  });

  factory AllAnswer.fromJson(Map<String, dynamic> json) => AllAnswer(
        id: json["id"],
        subjectId: json["subject_id"],
        quizId: json["quiz_id"],
        title: json["title"],
        score: json["score"],
        image: json["image"],
        userId: json["user_id"],
      );
}
