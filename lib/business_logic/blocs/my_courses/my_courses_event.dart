part of 'my_courses_bloc.dart';

@immutable
sealed class MyCoursesEvent {}

final class LoadMyCourses extends MyCoursesEvent {
  final String studentId;
  LoadMyCourses({required this.studentId});
  List<Object> get props => [studentId];
}
