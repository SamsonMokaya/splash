// ignore_for_file: non_constant_identifier_names

import '../models/attendance.dart';

abstract class BaseAttendanceRepository {
  Future<List<Attendance>?> addAttendance(
      {required int session_id,
      required double latitude,
      required String token,
      required String venueId,
      required double longitude,
      required double accuracy}) async {
    return null;
  }

  Future<List<Attendance>> getAllAttendances() async {
    return [];
  }

  Future<Attendance?> findById(int id) async {
    return null;
  }
}
