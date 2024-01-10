part of 'attendance_bloc.dart';

class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<Attendance> attendance;
  final bool fetch;
  const AttendanceLoaded({required this.attendance, required this.fetch});
  @override
  List<Object> get props => [attendance, fetch];
}

class AttendanceError extends AttendanceState {
  final String message;
  const AttendanceError({required this.message});
  @override
  List<Object> get props => [message];
}
