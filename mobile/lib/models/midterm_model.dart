class MidtermModel {
    int code;
    String status;
    Term data;

    MidtermModel({
         this.code = 0,
         this.status = "no-status",
         required this.data,
    });

    factory MidtermModel.fromJson(Map<String, dynamic> json) => MidtermModel(
        code: json["code"],
        status: json["status"],
        data: Term.fromJson(json["data"]),
    );

}

class Term {
    int id;
    String name;
    String? image;
    List<Midterm> midterm;

    Term({
         this.id = 0,
         this.name = "no-name",
         this.image,
         this.midterm = const [],
    });

    factory Term.fromJson(Map<String, dynamic> json) => Term(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        midterm: List<Midterm>.from(json["midterm"].map((x) => Midterm.fromJson(x))),
    );
}

class Midterm {
    int id;
    int classId;
    String title;
    String? image;
    String? dateTime;

    Midterm({
         this.id = 0,
         this.classId = 0,
         this.title = "no-title",
         this.dateTime,
         this.image,
    });

    factory Midterm.fromJson(Map<String, dynamic> json) => Midterm(
        id: json["id"],
        classId: json["class_id"],
        title: json["title"],
        image: json["image"],
        dateTime: json["date_time"],
    );
}
