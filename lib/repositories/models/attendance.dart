// attendance model
class Attendance {
  final String? sessionId;
  final String? attendanceId;
  final String? userId;
  final String? venue;
  final String? description;
  final String? unitCode;
  final String? createdAt;
  final String? venueId;
  final String? status;
  Attendance({
    this.sessionId,
    this.attendanceId,
    this.userId,
    this.unitCode,
    this.createdAt,
    this.venueId,
    this.status,
    this.venue,
    this.description,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      sessionId: json['session_id'].toString(),
      attendanceId: json['id'],
      userId: json['user_id'],
      unitCode: json['unit_code'],
      createdAt: json['created_at'],
      venueId: json['venue_id'].toString(),
      status: json['status'],
      venue: json['venue'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': attendanceId,
        'session_id': sessionId,
        'user_id': userId,
        'unit_code': unitCode,
        'created_at': createdAt,
        'venue': venue,
        'venue_id': venueId,
        'description': description,
        'status': status,
      };
}
