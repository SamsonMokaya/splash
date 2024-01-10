part of 'history_cubit.dart';

class HistoryCubitState extends Equatable {
  final HistoryType type;
  final History history;

  const HistoryCubitState({
    required this.type,
    required this.history,
  });

  // Copy constructor
  HistoryCubitState copyWith({
    HistoryType? type,
    History? history,
  }) {
    return HistoryCubitState(
      type: type ?? this.type,
      history: history ?? this.history,
    );
  }

  @override
  List<Object> get props => [type, history];
}
