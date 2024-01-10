import 'dart:convert';

import 'package:geolocation_flutter/repositories/models/exam_model.dart';
import 'package:geolocation_flutter/repositories/exam/base_exam_repository.dart';
import 'package:http/http.dart' as http;

class ExamRepository extends BaseExamRepository {
  @override
  //method to load courses as a list.
  Future<List<ExamModel>> fetchExamUnits(
      {required String units, required String campusId}) async {
    final response = await http.get(Uri.parse(
        "https://timetable.kimworks.buzz/api/courses?courses=$units&campus_choice=$campusId"));
    List<ExamModel> unitsList = List.empty();

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'] as List;
      unitsList = jsonData.map((unit) => ExamModel.fromJson(unit)).toList();
      return unitsList;
    } else if (response.statusCode == 404) {
      throw Exception('Not Subcategory found');
    } else {
      throw Exception('Failed to load subcategories');
    }
  }
}
