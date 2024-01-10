import 'package:flutter_bloc/flutter_bloc.dart';

part 'select_enroll_unit_state.dart';

class SelectEnrollUnitCubit extends Cubit<SelectEnrollUnitState> {
  SelectEnrollUnitCubit() : super(SelectEnrollUnitState([]));

  void addUnit(String courseCode) {
    List<String> updatedList = List.from(state.selectedUnits);
    updatedList.add(courseCode);
    emit(state.copyWith(selectedUnits: updatedList));
  }

  void removeUnit(String courseCode) {
    List<String> updatedList = List.from(state.selectedUnits);
    updatedList.remove(courseCode);
    emit(state.copyWith(selectedUnits: updatedList));
  }

  //a method to clear the selected units
  void clearUnits() {
    emit(state.copyWith(selectedUnits: []));
  }
}
