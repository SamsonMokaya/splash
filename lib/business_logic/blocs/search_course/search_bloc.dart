import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import '../../../repositories/course/course_repository.dart';
import '../../../repositories/models/unit.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchCourseBloc extends Bloc<SearchCourseEvent, SearchCourseState> {
  final CourseRepository repository;
  SearchCourseBloc({required CourseRepository unitRepository})
      : repository = unitRepository,
        super(SearchInitial()) {
    on<SearchCourse>(_onSearchCourse);
  }
  void _onSearchCourse(
    SearchCourse event,
    Emitter<SearchCourseState> emit,
  ) async {
    emit(SearchLoading());
    try {
      final units = await repository.searchCourses(units: event.query);
      emit(SearchLoaded(units: units));
    } catch (e) {
      //remove exception from the error message
      String errorMessage = e.toString().replaceAll('Exception:', '');
      emit(SearchError(errorMessage));
    }
  }
}
