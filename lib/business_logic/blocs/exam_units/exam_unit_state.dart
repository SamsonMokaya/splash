part of 'exam_unit_bloc.dart';

abstract class ExamUnitsState extends Equatable {
  const ExamUnitsState();
  @override
  List<Object> get props => [];
}

class ExamUnitsInitial extends ExamUnitsState {}

class ExamUnitsLoading extends ExamUnitsState {}

class ExamUnitsLoaded extends ExamUnitsState {
  final List<ExamModel> unitsList;
  const ExamUnitsLoaded({required this.unitsList});
  @override
  List<Object> get props => [unitsList];
}

class ExamUnitsLoadLoadingError extends ExamUnitsState {
  final String errorMessage;
  const ExamUnitsLoadLoadingError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
