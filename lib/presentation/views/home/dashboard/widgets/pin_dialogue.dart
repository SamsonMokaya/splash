// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation_flutter/presentation/widgets/text_widget.dart';

import '../../../../../business_logic/blocs/attendance/attendance_bloc.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/constants.dart';
import '../../../../../repositories/models/attendance.dart';

Future<dynamic> enterPinDialogue(
    {required BuildContext context, required Attendance attendance}) {
  final TextEditingController pinController = TextEditingController();

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // geospur
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: BlocListener<AttendanceBloc, AttendanceState>(
            listener: (context, state) {
              if (state is AttendanceLoaded && state.fetch == false) {
                Fluttertoast.showToast(
                  msg: 'Attendance added successfully',
                );
                Navigator.pop(context);
              } else if (state is AttendanceError) {
                Fluttertoast.showToast(
                  msg: state.message,
                );
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Enter Pin to register attendance',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center),
                CustomTextField(
                  placeholder: '123456',
                  controller: pinController,
                )
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding:
              const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.topGradientColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                // fixedSize: Size(size.width, 60),
              ),
              child: const Text('Cancel',
                  style: TextStyle(color: AppColors.blackColor, fontSize: 15)),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                if (pinController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "Please fill all fields",
                  );
                } else {
                  context.read<AttendanceBloc>().add(
                        AddAttendance(
                          attendance: attendance,
                          userid: currentUser.id.toString(),
                          session_id: int.parse(
                            attendance.sessionId ?? '1',
                          ),
                          token: pinController.text,
                          venueId: attendance.venueId,
                        ),
                      );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: AppColors.primary,
              ),
              child: BlocBuilder<AttendanceBloc, AttendanceState>(
                  builder: (context, state) {
                if (state is AttendanceLoading) {
                  return const CupertinoActivityIndicator(
                    color: Colors.white,
                    radius: 14,
                  );
                }
                return const Text('Add attendance',
                    style: TextStyle(color: Colors.white, fontSize: 15));
              }),
            ),
          ],
        );
      });
}
