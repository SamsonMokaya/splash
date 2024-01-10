import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocation_flutter/repositories/models/attendance.dart';

import '../../../../../constants/colors.dart';

class PastActivityCard extends StatelessWidget {
  final Attendance attendance;
  const PastActivityCard({super.key, required this.attendance});

  @override
  Widget build(BuildContext context) {
    final message =
        "${(attendance.unitCode ?? 'Unit Code Not Found')} - ${attendance.description}";
    return Card(
      elevation: 0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Text(
            attendance.unitCode.toString().substring(0, 3).toUpperCase(),
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          '${message.substring(0, min(20, message.length))}...',
        ),
        subtitle: Text('Sign in at ${attendance.createdAt}'),
        trailing: Text(attendance.venue ?? 'Venue Not Found'),
      ),
    );
  }
}
