import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constants/v2urls/urls_v2.dart';
import '../models/unit.dart';
import 'base_course_repository.dart';

class CourseRepository extends BaseCourseRepository {
  @override
  Future<List<CourseModel>> searchCourses({required String units}) async {
    final response = await http.post(Uri.parse(Environment.searchCourseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"unitCodes": units}));
    List<CourseModel> unitsList = List.empty();
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'] as List;
      unitsList = jsonData.map((unit) => CourseModel.fromJson(unit)).toList();
      return unitsList;
    } else if (response.statusCode == 404) {
      throw Exception('Not Unit found');
    } else {
      throw Exception('Failed to load units');
    }
  }

  @override
  Future<List<CourseModel>> fetchAllCourses() async {
    final response = await http.post(Uri.parse(Environment.fetchAllCoursesUrl));
    print(response.body);
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final jsonData = responseData['data'] as List;
      List<CourseModel> unitsList =
          jsonData.map((unit) => CourseModel.fromJson(unit)).toList();
      return unitsList;
    } else if (responseData.containsKey('message')) {
      throw Exception(responseData['message']);
    } else {
      throw Exception('Failed to load units');
    }
  }

  @override
  Future<List<CourseModel>> fetchMyCourses({required String studentId}) async {
    final response = await http.post(
        Uri.parse(Environment.fetchAllMyCoursesUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"adm_num": studentId}));
    print(response.body);
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final jsonData = responseData['data'] as List;
      List<CourseModel> unitsList =
          jsonData.map((unit) => CourseModel.fromJson(unit)).toList();
      return unitsList;
    } else if (responseData.containsKey('message')) {
      throw Exception(responseData['message']);
    } else {
      throw Exception('Failed to load unit');
    }
  }

  @override
  Future<String> enrollUnits(
      {required String studentId, required String unitcodes}) async {
    final response = await http.post(Uri.parse(Environment.enrollCourseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"adm_num": studentId, "unitCodes": unitcodes}));
    print("............................");
    print(response.body);
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      String jsonData = responseData['message'];
      return jsonData;
    } else if (responseData.containsKey('message')) {
      throw Exception(responseData['message']);
    } else {
      throw Exception('Failed to load unit');
    }
  }
}
