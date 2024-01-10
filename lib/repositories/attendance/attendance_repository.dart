import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';
import '../../constants/v2urls/urls_v2.dart';
import '../models/attendance.dart';
import 'base_attendance_repository.dart';
import 'package:http/http.dart' as http;

Future<String> getToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final user = preferences.getString('user');

  String token;
  if (user != null) {
    token = jsonDecode(user)['token'];
  } else {
    token = '';
  }
  return token;
}

class AttendanceRepository extends BaseAttendanceRepository {
  @override
  Future<List<Attendance>> getAllAttendances() async {
    final token = await getToken();
    final response = await http.get(
        Uri.parse('${Environment.attendanceHistoryUrl}?id=${currentUser.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    print(jsonDecode(response.body));
    final jsonBody = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      List<Attendance> attendances = jsonBody['data']
          .map<Attendance>((data) => Attendance.fromJson(data))
          .toList();
      if (attendances.isEmpty) {
        throw Exception('You have no attendances yet');
      }
      return attendances;
    } else if (jsonBody.containsKey('message')) {
      throw Exception(jsonBody['message']);
    } else if (jsonBody.containsKey('error')) {
      throw Exception(jsonBody['error']);
    } else {
      throw Exception('Failed to fetch attendances');
    }
  }

  @override
  Future<List<Attendance>> addAttendance(
      {required int session_id,
      required double latitude,
      required String token,
      required String venueId,
      required double longitude,
      required double accuracy}) async {
    final bearer_token = await getToken();

    final response = await http.post(Uri.parse(Environment.addAttendanceUrl),
        body: jsonEncode({
          'adm_num': currentUser.id,
          'session_id': session_id,
          'determinant': 'IN',
          'venue_id': venueId,
          'token': token,
          'data': {
            'latitude': latitude,
            'longitude': longitude,
            'accuracy': accuracy,
          }
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearer_token'
        });
    final jsonBody = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      List<Attendance> attendances = jsonBody['data']
          .map<Attendance>((data) => Attendance.fromJson(data))
          .toList();
      if (attendances.isEmpty) {
        throw Exception('You have no attendances yet');
      }
      return attendances;
    } else if (jsonBody.containsKey('message')) {
      throw Exception(jsonBody['message']);
    } else if (jsonBody.containsKey('error')) {
      throw Exception(jsonBody['error']);
    } else {
      throw Exception('Failed to record attendance');
    }
  }
}
