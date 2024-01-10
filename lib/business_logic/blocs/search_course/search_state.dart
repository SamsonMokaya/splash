part of 'search_bloc.dart';

@immutable
sealed class SearchCourseState {}

final class SearchInitial extends SearchCourseState {}

final class SearchLoading extends SearchCourseState {}

final class SearchLoaded extends SearchCourseState {
  final List<CourseModel> units;
  SearchLoaded({required this.units});
  List<Object> get props => [units];
}

final class SearchError extends SearchCourseState {
  final String message;
  SearchError(this.message);
  List<Object> get props => [message];
}
