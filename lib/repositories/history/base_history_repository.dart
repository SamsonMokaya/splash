import '../models/history.dart';

abstract class BaseHistoryRepository {
  Future<List<History>?> findAll() async {
    return null;
  }

  Future<History?> findById(int id) async {
    return null;
  }
}
