import '../models/history.dart';
import 'base_history_repository.dart';

class HistoryRepository extends BaseHistoryRepository {
  @override
  Future<List<History>> findAll() {
    return Future.delayed(const Duration(seconds: 2), () {
      return <History>[];
    });
  }
}
