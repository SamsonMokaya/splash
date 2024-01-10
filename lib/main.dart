import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocation_flutter/business_logic/blocs/History/history_bloc.dart';
import 'package:geolocation_flutter/business_logic/blocs/attendance/attendance_bloc.dart';
import 'package:geolocation_flutter/business_logic/cubits/history_page/history_cubit.dart';
import 'package:geolocation_flutter/business_logic/cubits/togglePassword/toggle_password_cubit.dart';
import 'package:geolocation_flutter/constants/colors.dart';
import 'package:geolocation_flutter/constants/constants.dart';
import 'package:geolocation_flutter/repositories/attendance/attendance_repository.dart';
import 'package:geolocation_flutter/repositories/authentication/auth_repository.dart';
import 'package:geolocation_flutter/repositories/geolocation/geolocation_repository.dart';
import 'package:geolocation_flutter/repositories/history/history_repository.dart';
import 'package:geolocation_flutter/repositories/saved_units/saved_units_repository.dart';

import 'package:geolocation_flutter/routes.dart' as route;

import 'business_logic/blocs/allcourses/all_course_bloc.dart';
import 'business_logic/blocs/enroll_units/enroll_units_bloc.dart';
import 'business_logic/blocs/exam_units/exam_unit_bloc.dart';
import 'business_logic/blocs/my_courses/my_courses_bloc.dart';
import 'business_logic/blocs/saved_units/saved_units_bloc.dart';
import 'business_logic/blocs/auth_status/auth_status_bloc.dart';
import 'business_logic/blocs/authentication/authentication_bloc.dart';
import 'business_logic/blocs/search_course/search_bloc.dart';
import 'business_logic/cubits/cubit/select_enroll_unit_cubit.dart';
import 'repositories/course/course_repository.dart';
import 'repositories/exam/exam_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AttendanceRepository>(
          create: (context) => AttendanceRepository(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<HistoryRepository>(
          create: (context) => HistoryRepository(),
        ),
        RepositoryProvider<GeolocationRepository>(
          create: (context) => GeolocationRepository(),
        ),
        //course repository
        RepositoryProvider<CourseRepository>(
          create: (context) => CourseRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AttendanceBloc>(
            create: (context) => AttendanceBloc(
              attendanceRepository: AttendanceRepository(),
            ),
          ),
          BlocProvider<ExamsUnitsBloc>(
              create: (context) =>
                  ExamsUnitsBloc(unitRepository: ExamRepository())),
          BlocProvider<SavedUnitsBloc>(
              create: (context) => SavedUnitsBloc(
                  savedUnitsRepository: SavedUnitsRepository(),
                  unitRepository: ExamRepository())),
          BlocProvider<HistoryBloc>(
            create: (context) =>
                HistoryBloc(historyRepository: HistoryRepository()),
          ),
          BlocProvider<AuthStatusBloc>(
            create: (context) =>
                AuthStatusBloc(authRepository: AuthRepository())
                  ..add(CheckUserStatus()),
          ),
          //authbloc
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authRepository: AuthRepository()),
          ),
          //search course bloc
          BlocProvider<SearchCourseBloc>(
            create: (context) =>
                SearchCourseBloc(unitRepository: CourseRepository()),
          ),
          //all course bloc
          BlocProvider<AllCoursesBloc>(
            create: (context) =>
                AllCoursesBloc(unitRepository: CourseRepository()),
          ),
          //my course bloc
          BlocProvider<MyCoursesBloc>(
            create: (context) =>
                MyCoursesBloc(unitRepository: CourseRepository())
                  ..add(LoadMyCourses(studentId: currentUser.id)),
          ),
          //bloc for enroll units
          BlocProvider(
              create: (context) =>
                  EnrollUnitsBloc(repository: CourseRepository())),
          //Cubits
          BlocProvider<TogglePasswordCubit>(
              create: (context) => TogglePasswordCubit()),
          BlocProvider<HistoryCubit>(create: (context) => HistoryCubit()),
          //selectEnrollUnitCubit
          BlocProvider<SelectEnrollUnitCubit>(
              create: (context) => SelectEnrollUnitCubit()),
        ],
        child: BlocBuilder<AuthStatusBloc, AuthStatusState>(
          builder: (context, state) {
            if (state is UserAuthenticated) {
              return MaterialApp(
                title: 'Geospur',
                debugShowCheckedModeBanner: false,
                onGenerateRoute: route.controller,
                initialRoute: route.dashboard,
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: AppColors.primary),
                  textTheme: const TextTheme(
                      bodyLarge: TextStyle(color: Colors.black)),
                  iconTheme: const IconThemeData(color: AppColors.primary),
                  appBarTheme: const AppBarTheme(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      centerTitle: true),
                  useMaterial3: true,
                ),
              );
            } else {
              return Builder(builder: (context) {
                return MaterialApp(
                  title: 'Geospur',
                  debugShowCheckedModeBanner: false,
                  onGenerateRoute: route.controller,
                  initialRoute: route.splash,
                  theme: ThemeData(
                      colorScheme:
                          ColorScheme.fromSeed(seedColor: AppColors.primary),
                      textTheme: const TextTheme(
                          bodyLarge: TextStyle(color: Colors.black)),
                      iconTheme: const IconThemeData(color: AppColors.primary),
                      appBarTheme: const AppBarTheme(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          centerTitle: true),
                      useMaterial3: true),
                );
              });
            }
          },
        ),
      ),
    );
  }
}
