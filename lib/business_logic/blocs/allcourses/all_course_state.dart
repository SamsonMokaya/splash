part of 'all_course_bloc.dart';

@immutable
sealed class AllCoursesState {}

final class UnitsInitial extends AllCoursesState {}

final class CourseLoading extends AllCoursesState {}

final class CourseLoaded extends AllCoursesState {
  final List<CourseModel> units;
  CourseLoaded({required this.units});
  List<Object> get props => [units];
}

final class CourseError extends AllCoursesState {
  final String message;
  CourseError(this.message);
  List<Object> get props => [message];
}
