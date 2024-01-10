import '../models/exam_model.dart';

abstract class BaseExamRepository {
  Future<List<ExamModel>?> fetchExamUnits(
      {required String units, required String campusId}) async {
    return null;
  }
}
