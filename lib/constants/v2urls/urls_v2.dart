class Environment {
  static String baseUrl = 'https://15m13kl3-3000.uks1.devtunnels.ms/api';

  static String loginUrl = '$baseUrl/users/login';
  static String registerUrl = '$baseUrl/users/register';

  static String attendanceHistoryUrl = '$baseUrl/users/attendance';
  static String addAttendanceUrl = '$baseUrl/users/attendance/add';
  

  static String fetchAllCoursesUrl = '$baseUrl/users/units/fetchAllUnits';
  static String fetchAllMyCoursesUrl = '$baseUrl/users/units/getMyUnits';
  static String searchCourseUrl = '$baseUrl/users/units';
  static String enrollCourseUrl = '$baseUrl/users/units/enrollUnits';
}
