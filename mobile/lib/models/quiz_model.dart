class QuizModel {
    int code;
    String status;
    Quiz quiz;

    QuizModel({
         this.code = 0,
         this.status = "no-status",
         required this.quiz,
    });

    factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        code: json["code"],
        status: json["status"],
        quiz: Quiz.fromJson(json["data"]),
    );

}

class Quiz {
    int id;
    String name;
    String? image;
    List<Quizes> quiz;

    Quiz({
         this.id = 0,
         this.name = "no-name",
         this.image,
         this.quiz = const [],
    });

    factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        quiz: List<Quizes>.from(json["quize"].map((x) => Quizes.fromJson(x))),
    );
}

class Quizes {
    int id;
    int classId;
    String title;
    String? image;
    String? dateTime;

    Quizes({
         this.id = 0,
         this.classId = 0,
         this.dateTime,
         this.title = "no-title",
         this.image,
    });

    factory Quizes.fromJson(Map<String, dynamic> json) => Quizes(
        id: json["id"],
        classId: json["class_id"],
        title: json["title"],
        dateTime: json["date_time"],
        image: json["image"],
    );
}
