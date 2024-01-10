import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/course/course_repository.dart';

part 'enroll_units_event.dart';
part 'enroll_units_state.dart';

class EnrollUnitsBloc extends Bloc<EnrollUnitsEvent, EnrollUnitsState> {
  final CourseRepository _repository;
  EnrollUnitsBloc({required CourseRepository repository})
      : _repository = repository,
        super(EnrollUnitsInitial()) {
    on<EnrollUnits>(_onEnrollUnits);
  }
  void _onEnrollUnits(
    EnrollUnits event,
    Emitter<EnrollUnitsState> emit,
  ) async {
    emit(EnrollUnitsLoading());
    try {
      final units = await _repository.enrollUnits(
          studentId: event.studentId, unitcodes: event.unitcodes);
      emit(EnrollUnitsLoaded(message: units));
    } catch (e) {
      final message = e.toString().replaceAll('Exception: ', '');
      emit(EnrollUnitsError(message: message));
    }
  }
}
