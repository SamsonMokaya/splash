import 'package:flutter/material.dart';
import 'package:geolocation_flutter/repositories/models/attendance.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/constants.dart';
import '../../../../../repositories/models/unit.dart';
import 'pin_dialogue.dart';

class UpcomingClassCard extends StatelessWidget {
  const UpcomingClassCard({
    Key? key,
    required this.unit,
  }) : super(key: key);
  final CourseModel unit;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: AppColors.primary.withOpacity(.2)),
      ),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.23,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: AppColors.secondary.withOpacity(0.4),
                    offset: const Offset(0, 3),
                    blurRadius: 6),
              ],
            ),
            child: Column(
              children: [
                Container(
                  height: 30,
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: AppColors.primary),
                  child: Text(
                    'Upcoming Class',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.white,
                          fontSize: 17,
                          wordSpacing: 5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              unit.courseCode.toString(),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      fontSize: 25),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                print(unit.toJson());
                                enterPinDialogue(
                                  attendance: Attendance(
                                      sessionId: unit.sessionId,
                                      unitCode: unit.courseCode.toString(),
                                      userId: currentUser.id.toString(),
                                      venueId: unit.venueId.toString()),
                                  context: context,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: const Text(
                                'Sign Attendance',
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontSize: 12),
                              ))
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tues, 12-10-2023',
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: AppColors.blackColor,
                                      letterSpacing: 1,
                                    ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.calendar_month_sharp,
                                      color: AppColors.secondary, size: 35),
                                  const SizedBox(width: 10),
                                  Text(
                                    unit.time.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: AppColors.blackColor,
                                          letterSpacing: 1,
                                        ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(Icons.location_on_rounded,
                                  color: AppColors.secondary, size: 35),
                              const SizedBox(width: 10),
                              Text(
                                unit.venueName.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: AppColors.blackColor,
                                        letterSpacing: 0),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
