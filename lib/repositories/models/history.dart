class History {
  final String? id;
  final String? unitCode;
  final String? createdAt;
  final String? venue;
  final String? status;
  History({this.id, this.unitCode, this.createdAt, this.venue, this.status});

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['id'],
      unitCode: json['unit_code'],
      createdAt: json['created_at'],
      venue: json['venue'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'unit_code': unitCode,
        'created_at': createdAt,
        'venue': venue,
        'status': status,
      };
}
