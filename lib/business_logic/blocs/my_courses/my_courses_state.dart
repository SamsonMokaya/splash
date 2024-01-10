part of 'my_courses_bloc.dart';

@immutable
sealed class MyCoursesState {}

final class MyCoursesInitial extends MyCoursesState {}

final class MyCoursesLoading extends MyCoursesState {}

final class MyCoursesLoaded extends MyCoursesState {
  final List<CourseModel> units;
  MyCoursesLoaded({required this.units});
  List<Object> get props => [units];
}

final class MyCoursesError extends MyCoursesState {
  final String message;
  MyCoursesError(this.message);
  List<Object> get props => [message];
}
