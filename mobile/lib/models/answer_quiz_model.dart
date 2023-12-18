class AnswerQuizModel {
  int code;
  String status;
  AnswerQuiz quiz;

  AnswerQuizModel({
    this.code = 0,
    this.status = "no-status",
    required this.quiz,
  });

  factory AnswerQuizModel.fromJson(Map<String, dynamic> json) => AnswerQuizModel(
        code: json["code"],
        status: json["status"],
        quiz: AnswerQuiz.fromJson(json["data"]),
      );
}

class AnswerQuiz {
  int id;
  String title;
  String? image;
  GetAnswer? getAnswer;
  List<GetAnswer> getCmt;

  AnswerQuiz({
    this.id = 0,
    this.title = "no-title",
    this.image,
    this.getAnswer,
    this.getCmt = const [],
  });

  factory AnswerQuiz.fromJson(Map<String, dynamic> json) => AnswerQuiz(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        getAnswer: json["get_answer"] == null? null : GetAnswer.fromJson(json["get_answer"]),
        getCmt: List<GetAnswer>.from(json["get_cmt"].map((x) => GetAnswer.fromJson(x))),
      );
}

class GetAnswer {
  int id;
  int subjectId;
  int? quizId;
  String title;
  String? image;
  int? userId;
  int? quizeId;
  String? score;

  GetAnswer({
    this.id = 0,
    this.subjectId = 0,
    this.quizId,
    this.title = "no-title",
    this.image,
    this.score,
    this.userId,
    this.quizeId,
  });

  factory GetAnswer.fromJson(Map<String, dynamic> json) => GetAnswer(
        id: json["id"],
        subjectId: json["subject_id"],
        quizId: json["quiz_id"],
        title: json["title"],
        image: json["image"],
        score: json["score"],
        userId: json["user_id"],
        quizeId: json["quize_id"],
      );
}
