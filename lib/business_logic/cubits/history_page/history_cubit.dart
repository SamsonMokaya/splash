import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';
import '../../../repositories/models/history.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryCubitState> {
  HistoryCubit()
      : super(HistoryCubitState(type: HistoryType.All, history: History()));

  void switchOrdersView({required HistoryType type}) {
    emit(state.copyWith(type: type));
  }

  void switchCurrentOrder({required History history}) {
    emit(state.copyWith(history: history));
  }
}
