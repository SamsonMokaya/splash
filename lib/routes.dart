import 'package:flutter/material.dart';
import 'package:geolocation_flutter/presentation/views/auth/login_screen.dart';
import 'package:geolocation_flutter/presentation/views/auth/splash_screen.dart';
import 'package:geolocation_flutter/presentation/views/home/enroll/enroll_courses.dart';
import 'package:geolocation_flutter/presentation/views/home/pass_activities/past_activity.dart';

import 'presentation/exam_timetable/exam_timetable_screen.dart';
import 'presentation/views/auth/otp.dart';
import 'presentation/views/auth/reset_password.dart';
import 'presentation/views/auth/sign_up_screen.dart';
import 'presentation/views/home/dashboard/dashboard.dart';
import 'presentation/views/home/my_classes/my_classes.dart';

const String splash = 'splash';
const String login = 'login';
const String dashboard = 'dashboard';
const String transactionScreen = 'transaction';
const String payment = 'payment';
const String signUp = 'sign_up';
const String otp = 'otp';
const String settings = 'settings';
const String timetable = 'timetable';
const String account = 'account';

const String resetPassword = 'reset';
const String classes = 'classes';
const String enrollScreen = 'enrollScreen';
const String passActivities = 'passActivities';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case login:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case splash:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case dashboard:
      return MaterialPageRoute(builder: (context) => const Dashboard());
    case otp:
      return MaterialPageRoute(builder: (context) => const Otp());
    case resetPassword:
      return MaterialPageRoute(builder: (context) => ResetPasswordScreen());
    case classes:
      return MaterialPageRoute(builder: (context) => const MyClassesScreen());
    case timetable:
      return MaterialPageRoute(
          builder: (context) => const ExamTimetableScreen());
    case enrollScreen:
      return MaterialPageRoute(
          builder: (context) => const EnrollCoursesScreen());
    case account:
      return MaterialPageRoute(builder: (context) => const MyClassesScreen());

    case passActivities:
      return MaterialPageRoute(
          builder: (context) => const PastActivitiesScreen());
    // case payment:
    //   return MaterialPageRoute(
    //     builder: (context) => PaymentScreen(
    //       arguments: settings.arguments as Map<String, dynamic>,
    //     ),
    //   );
    case signUp:
      return MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      );
    default:
      throw ('Unimplemented route');
  }
}
