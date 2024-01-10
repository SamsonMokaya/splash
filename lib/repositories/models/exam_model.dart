class ExamModel {
  String? courseCode;
  String? date;
  String? time;
  String? venue;

  ExamModel(
      {required this.courseCode,
      required this.date,
      required this.time,
      required this.venue});

  ExamModel.fromJson(Map<String, dynamic> json) {
    courseCode = json['course_code'];
    date = json['day'];
    time = json['time'];
    venue = json['room'];
  }
  Map<String, dynamic> toJson() =>
      {'course_code': courseCode, 'day': date, 'time': time, 'room': venue};
}
