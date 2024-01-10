import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocation_flutter/repositories/models/attendance.dart';

import '../../../../../business_logic/blocs/attendance/attendance_bloc.dart';
import '../../../../../constants/colors.dart';
import '../../pass_activities/widget/past_activity_card.dart';

class PastActivitiesSession extends StatelessWidget {
  const PastActivitiesSession({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        if (state is AttendanceLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CupertinoActivityIndicator(
                radius: 16,
                color: AppColors.primary,
              ),
            ),
          );
        } else if (state is AttendanceLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount:state.attendance.length.clamp(0, 4),
            itemBuilder: (context, index) {
              final Attendance attendance = state.attendance[index];
              return PastActivityCard(attendance: attendance);
            },
          );
        } else if (state is AttendanceError) {
          return Center(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    context.read<AttendanceBloc>().add(
                          FetchAttendance(),
                        );
                  },
                  child: const Text('Refresh'),
                ),
                Text(state.message),
              ],
            ),
          );
        } else {
          // add also a button to refresh the data
          return Column(
            children: [
              TextButton(
                onPressed: () {
                  context.read<AttendanceBloc>().add(
                        FetchAttendance(),
                      );
                },
                child: const Text('Refresh'),
              ),
              const Text('No data found'),
            ],
          );
        }
      },
    );
  }
}
