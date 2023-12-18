class ExamModel {
    int code;
    String status;
    Data data;

    ExamModel({
         this.code = 0,
         this.status = "no-status",
         required this.data,
    });

    factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );
}

class Data {
    int id;
    String className;
    AllExam allExam;

    Data({
         this.id = 0,
         this.className = "n-classname",
         required this.allExam,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        className: json["class_name"],
        allExam: AllExam.fromJson(json["all_exam"]),
    );
}

class AllExam {
    List<Assignment> finalExam;
    List<Assignment> midtermExam;
    List<Assignment> quiz;
    List<Assignment> assignment;

    AllExam({
         this.finalExam = const [],
         this.midtermExam = const [],
         this.quiz = const [],
         this.assignment = const [],
    });

    factory AllExam.fromJson(Map<String, dynamic> json) => AllExam(
        finalExam: List<Assignment>.from(json["final_exam"].map((x) => Assignment.fromJson(x))),
        midtermExam: List<Assignment>.from(json["midterm_exam"].map((x) => Assignment.fromJson(x))),
        quiz: List<Assignment>.from(json["quiz"].map((x) => Assignment.fromJson(x))),
        assignment: List<Assignment>.from(json["assignment"].map((x) => Assignment.fromJson(x))),
    );
}

class Assignment {
    int id;
    String title;
    String? image;

    Assignment({
         this.id = 0,
         this.title = "no-title",
         this.image = "no-image",
    });

    factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
        id: json["id"],
        title: json["title"],
        image: json["image"],
    );
}
