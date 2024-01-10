part of 'enroll_units_bloc.dart';

sealed class EnrollUnitsEvent extends Equatable {
  const EnrollUnitsEvent();

  @override
  List<Object> get props => [];
}

final class EnrollUnits extends EnrollUnitsEvent {
  final String studentId;
  final String unitcodes;
  const EnrollUnits({required this.studentId, required this.unitcodes});
  @override
  List<Object> get props => [studentId, unitcodes];
}
