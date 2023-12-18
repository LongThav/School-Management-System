class ResultModel {
    int code;
    String status;
    List<Result> result;

    ResultModel({
         this.code = 0,
         this.status = "no-status",
         this.result = const [],
    });

    factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        code: json["code"],
        status: json["status"],
        result: List<Result>.from(json["data"].map((x) => Result.fromJson(x))),
    );
}

class Result {
    int id;
    String title;
    String file;

    Result({
         this.id = 0,
         this.title = "no-title",
         this.file = "no-file",
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        file: json["file"],
    );

}
