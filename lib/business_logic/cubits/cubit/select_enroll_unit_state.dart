part of 'select_enroll_unit_cubit.dart';

class SelectEnrollUnitState {
  final List<String> selectedUnits;

  SelectEnrollUnitState(this.selectedUnits);

  SelectEnrollUnitState copyWith({
    List<String>? selectedUnits,
  }) {
    return SelectEnrollUnitState(
      selectedUnits ?? this.selectedUnits,
    );
  }
}
