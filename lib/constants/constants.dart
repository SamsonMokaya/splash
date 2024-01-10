// UserModel currentUser = UserModel();

// ignore_for_file: constant_identifier_names

import '../repositories/models/user.dart';

List<String> monthList = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'June',
  'July',
  'Aug',
  'Sept',
  'Oct',
  'Nov',
  'Dec'
];

enum HistoryType { Daily, Weekly, Monthly, UnSelected, All }

UserModel currentUser = UserModel.empty;
