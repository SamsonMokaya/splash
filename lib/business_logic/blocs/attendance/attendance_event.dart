// ignore_for_file: non_constant_identifier_names

part of 'attendance_bloc.dart';

class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

class FetchAttendance extends AttendanceEvent {}

class AddAttendance extends AttendanceEvent {
  final String userid;
  final Attendance attendance;
  final String? venueId;
  final int session_id;

  final String? token;
  const AddAttendance({
    required this.attendance,
    required this.userid,
    this.venueId,
    this.token,
    required this.session_id,
  });
  @override
  List<Object> get props => [
        attendance,
        userid,
        venueId ?? '',
        token ?? '',
        session_id,
      ];
}
