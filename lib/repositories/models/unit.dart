class CourseModel {
  final String? sessionId;
  final String? venueName;
  final String? venue;
  final int? venueId;
  final String? courseCode;
  final String? description;
  final int? coordinatorId;
  final String? coordinator;
  final String? imageUrl;
  final String? time;
  final String? date;

  const CourseModel({
    required this.sessionId,
    required this.venueId,
    required this.venueName,
    required this.courseCode,
    required this.coordinator,
    this.venue,
    required this.time,
    required this.date,
    this.description,
    required this.coordinatorId,
    this.imageUrl,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      sessionId: json['id'].toString(),
      venueId: json['venue_id'],
      courseCode: json['session_name'],
      time: json['time'],
      date: json['date'],
      venue: json['venue'],
      venueName: json['venue_name'],
      imageUrl: json['image_url'],
      description: json['description'],
      coordinatorId: json['coordinator_id'],
      coordinator: json['coodinator'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': sessionId,
      'venue_id': venueId,
      'venue_name': venueName,
      'time': time,
      'venue': venue,
      'date': date,
      'courseCode': courseCode,
      'imageUrl': imageUrl,
      'description': description,
      'coordinator': coordinatorId,
    };
  }
}
