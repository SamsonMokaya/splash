part of 'search_bloc.dart';

@immutable
sealed class SearchCourseEvent {}

final class SearchCourse extends SearchCourseEvent {
  final String query;
  SearchCourse({required this.query});
  List<Object> get props => [query];
}
