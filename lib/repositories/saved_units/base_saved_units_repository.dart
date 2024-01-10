// ignore_for_file: body_might_complete_normally_nullable

import '../models/exam_model.dart';

abstract class BaseSavedUnitsRepository {
  Future<void> saveUnit({required ExamModel unit}) async {}
  Future<void> updateUnit({required ExamModel unit}) async {}
  Future<void> deleteUnit({required ExamModel unit}) async {}
  Future<List<ExamModel>?> loadSavedUnits() async {}
}
