import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../repositories/models/history.dart';
import '../../../repositories/history/history_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository repository;
  HistoryBloc({required HistoryRepository historyRepository})
      : repository = historyRepository,
        super(HistoryInitial()) {
    on<FetchHistory>(_onFetchHistory);
  }
  void _onFetchHistory(FetchHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      final history = await repository.findAll();
      emit(HistoryLoaded(history));
    } catch (e) {
      String errorMessage = e.toString().replaceAll('Exception:', '');
      emit(HistoryError(errorMessage));
    }
  }
}
