part of 'enroll_units_bloc.dart';

sealed class EnrollUnitsState extends Equatable {
  const EnrollUnitsState();

  @override
  List<Object> get props => [];
}

final class EnrollUnitsInitial extends EnrollUnitsState {}

final class EnrollUnitsLoading extends EnrollUnitsState {}

final class EnrollUnitsLoaded extends EnrollUnitsState {
  final String message;

  const EnrollUnitsLoaded({required this.message});

  @override
  List<Object> get props => [message];
}

final class EnrollUnitsError extends EnrollUnitsState {
  final String message;

  const EnrollUnitsError({required this.message});

  @override
  List<Object> get props => [message];
}
