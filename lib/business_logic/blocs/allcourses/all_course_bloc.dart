import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import '../../../repositories/course/course_repository.dart';
import '../../../repositories/models/unit.dart';

part 'all_course_event.dart';
part 'all_course_state.dart';

class AllCoursesBloc extends Bloc<AllCoursesEvent, AllCoursesState> {
  final CourseRepository repository;
  AllCoursesBloc({required CourseRepository unitRepository})
      : repository = unitRepository,
        super(UnitsInitial()) {
    on<FetchUnits>(_onFetchUnits);
  }
  void _onFetchUnits(
    FetchUnits event,
    Emitter<AllCoursesState> emit,
  ) async {
    emit(CourseLoading());
    try {
      final units = await repository.fetchAllCourses();
      emit(CourseLoaded(units: units));
    } catch (e) {
      //remove exception from the error message
      String errorMessage = e.toString().replaceAll('Exception:', '');
      emit(CourseError(errorMessage));
    }
  }
}
