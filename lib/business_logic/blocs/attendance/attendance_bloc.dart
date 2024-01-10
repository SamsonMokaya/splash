import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocation_flutter/repositories/attendance/attendance_repository.dart';
import 'package:geolocation_flutter/repositories/geolocation/geolocation_repository.dart';
import 'package:geolocator/geolocator.dart';

import '../../../repositories/models/attendance.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository _attendancerepository;
  final GeolocationRepository _geolocationRepository = GeolocationRepository();
  AttendanceBloc({required AttendanceRepository attendanceRepository})
      : _attendancerepository = attendanceRepository,
        super(AttendanceInitial()) {
    on<FetchAttendance>(_onFetchAttendance);
    on<AddAttendance>(_onAddAttendance);
  }
  void _onFetchAttendance(
      FetchAttendance event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());
    try {
      final List<Attendance> attendances =
          await _attendancerepository.getAllAttendances();
      emit(AttendanceLoaded(attendance: attendances, fetch: true));
    } catch (e) {
      String errorMessage = e.toString().replaceAll('Exception:', '');
      emit(AttendanceError(message: errorMessage));
    }
  }

  void _onAddAttendance(
      AddAttendance event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());
    try {
      final Position position =
          await _geolocationRepository.getCurrentLocation();
      // print(position);
      final List<Attendance> attendances =
          await _attendancerepository.addAttendance(
              latitude: position.latitude,
              longitude: position.longitude,
              token: event.token ?? '1',
              venueId: event.venueId ?? '1',
              accuracy: position.accuracy,
              session_id: event.session_id);
      emit(AttendanceLoaded(attendance: attendances, fetch: false));
    } catch (e) {
      String errorMessage = e.toString().replaceAll('Exception:', '');
      emit(AttendanceError(message: errorMessage));
    }
  }
}
