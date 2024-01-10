part of 'exam_unit_bloc.dart';

abstract class ExamUnitsEvent extends Equatable {
  const ExamUnitsEvent();
  @override
  List<Object> get props => [];
}

class ExamLoadUnits extends ExamUnitsEvent {
  final String courses;
  final String campusId;

  const ExamLoadUnits({required this.courses, this.campusId = '0'});
  @override
  List<Object> get props => [courses, campusId];
}
