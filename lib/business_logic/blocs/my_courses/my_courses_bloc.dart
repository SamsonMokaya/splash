import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import '../../../repositories/course/course_repository.dart';
import '../../../repositories/models/unit.dart';

part 'my_courses_event.dart';
part 'my_courses_state.dart';

class MyCoursesBloc extends Bloc<MyCoursesEvent, MyCoursesState> {
  final CourseRepository repository;
  MyCoursesBloc({required CourseRepository unitRepository})
      : repository = unitRepository,
        super(MyCoursesInitial()) {
    on<LoadMyCourses>(_onLoadMyCourses);
  }
  void _onLoadMyCourses(
    LoadMyCourses event,
    Emitter<MyCoursesState> emit,
  ) async {
    emit(MyCoursesLoading());
    try {
      final units = await repository.fetchMyCourses(studentId: event.studentId);
      emit(MyCoursesLoaded(units: units));
    } catch (e) {
      //remove exception from the error message
      String errorMessage = e.toString().replaceAll('Exception:', '');
      emit(MyCoursesError(errorMessage));
    }
  }
}
