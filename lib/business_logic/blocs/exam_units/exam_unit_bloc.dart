import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/exam/exam_repository.dart';
import '../../../repositories/models/exam_model.dart';

part 'exam_unit_event.dart';
part 'exam_unit_state.dart';

class ExamsUnitsBloc extends Bloc<ExamUnitsEvent, ExamUnitsState> {
  final ExamRepository _unitRepository;
  ExamsUnitsBloc({required ExamRepository unitRepository})
      : _unitRepository = unitRepository,
        super(ExamUnitsInitial()) {
    on<ExamLoadUnits>(_onExamLoadUnits);
  }
  void _onExamLoadUnits(ExamLoadUnits event, Emitter emit) async {
    emit(ExamUnitsLoading());
    try {
      final List<ExamModel> units = await _unitRepository.fetchExamUnits(
          units: event.courses, campusId: event.campusId);
      emit(ExamUnitsLoaded(unitsList: units));
    } catch (error) {
      emit(ExamUnitsLoadLoadingError(errorMessage: '$error'));
    }
  }
}
