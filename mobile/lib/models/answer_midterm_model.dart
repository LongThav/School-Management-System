class AnswerMidtermModel {
  int code;
  String status;
  Midterms midterm;

  AnswerMidtermModel({
    this.code = 0,
    this.status = "no-status",
    required this.midterm,
  });

  factory AnswerMidtermModel.fromJson(Map<String, dynamic> json) => AnswerMidtermModel(
        code: json["code"],
        status: json["status"],
        midterm: Midterms.fromJson(json["data"]),
      );
}

class Midterms {
  int id;
  String title;
  String? image;
  MidtermQuiz? getAnswer;
  List<MidtermQuiz> getCmt;

  Midterms({
    this.id = 0,
    this.title = "no-title",
    this.image,
    required this.getAnswer,
    this.getCmt = const [],
  });

  factory Midterms.fromJson(Map<String, dynamic> json) => Midterms(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        getAnswer: json["get_answer"] == null? null : MidtermQuiz.fromJson(json["get_answer"]),
        getCmt: List<MidtermQuiz>.from(json["get_cmt"].map((x) => MidtermQuiz.fromJson(x))),
      );
}

class MidtermQuiz {
  int id;
  int subjectId;
  int midtermId;
  String title;
  String? image;
  String? score;

  MidtermQuiz({
    this.id = 0,
    this.subjectId = 0,
    this.midtermId = 0,
    this.title = "no-title",
    this.image,
    this.score,
  });

  factory MidtermQuiz.fromJson(Map<String, dynamic> json) => MidtermQuiz(
        id: json["id"],
        subjectId: json["subject_id"],
        midtermId: json["midterm_id"],
        title: json["title"],
        image: json["image"],
        score: json["score"],
      );
}
