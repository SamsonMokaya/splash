import 'package:geolocation_flutter/repositories/models/unit.dart';

abstract class BaseCourseRepository {
  Future<List<CourseModel>?> fetchAllCourses() async => null;

  Future<List<CourseModel>?> fetchMyCourses(
          {required String studentId}) async =>
      null;

  Future<List<CourseModel>?> searchCourses({required String units}) async =>
      null;
  Future<String?> enrollUnits(
      {required String studentId, required String unitcodes}) async {
        return null;
      }
}
