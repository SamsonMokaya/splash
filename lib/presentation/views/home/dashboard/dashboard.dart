// ignore_for_file: void_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocation_flutter/business_logic/blocs/attendance/attendance_bloc.dart';
import 'package:geolocation_flutter/business_logic/blocs/my_courses/my_courses_bloc.dart';
import 'package:geolocation_flutter/constants/constants.dart';
import 'package:geolocation_flutter/presentation/widgets/custom_drawer.dart';
import 'package:mac_address/mac_address.dart';

import '../../../../constants/colors.dart';
import '../../../exam_timetable/Widgets/custom_empty_classes_card.dart';
import '../../../exam_timetable/Widgets/scroll_behavior.dart';
import '../enroll/widget/custom_empty_card.dart';
import '../my_classes/widgets/course_card.dart';
import 'widgets/pass_activities_session.dart';
import 'widgets/upcoming_class_card.dart';
import '../../../../routes.dart' as route;

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  Future<void> initMacAddress() async {
    String macAddress;
    try {
      GetMac.macAddress.then((value) {
        macAddress = value;
        print(macAddress);
      });
    } on PlatformException {
      macAddress = 'Error getting the MAC address.';
      print(macAddress);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    context.read<AttendanceBloc>().add(
          FetchAttendance(),
        );
    context.read<MyCoursesBloc>().add(
          LoadMyCourses(studentId: currentUser.id),
        );
    initMacAddress();

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title:
            Text(currentUser.id, style: const TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            onPressed: () {
              context.read<MyCoursesBloc>().add(
                    LoadMyCourses(studentId: currentUser.id),
                  );
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(children: [
            //say hi to the user
            Text('Hi, ${currentUser.name}',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 20,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: size.height * 0.01),
            BlocBuilder<MyCoursesBloc, MyCoursesState>(
              builder: (context, state) {
                if (state is MyCoursesLoading) {
                  return SizedBox(
                    height: size.height * .8,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CupertinoActivityIndicator(),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            'Fetching your classes...',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  );
                } else if (state is MyCoursesLoaded) {
                  print("********* ${state.units.length} *********");
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state.units.isNotEmpty
                          ? UpcomingClassCard(unit: state.units[0])
                          : const EmptyCourseList(),
                      const SizedBox(height: 10),
                      const Divider(height: 1, indent: 10, endIndent: 10),
                      Row(
                        children: [
                          Text(
                            'Other Classes',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    color: AppColors.blackColor,
                                    fontSize: 17,
                                    wordSpacing: 5,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(route.classes);
                            },
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      //! Your other classes here in a grid view
                      if (state.units.isNotEmpty)
                        ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: RefreshIndicator(
                            onRefresh: () async {
                              context.read<MyCoursesBloc>().add(
                                  LoadMyCourses(studentId: currentUser.id));
                            },
                            child: SizedBox(
                              height: 200,
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.units.length,
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5,
                                        childAspectRatio: .95),
                                itemBuilder: (context, index) =>
                                    UnitCard(unit: state.units.removeAt(0)),
                              ),
                            ),
                            // end grid view
                          ),
                        ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        children: [
                          Text(
                            'Past Activities',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    color: AppColors.blackColor,
                                    fontSize: 17,
                                    wordSpacing: 5,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, route.passActivities);
                            },
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 1, indent: 10, endIndent: 10),
                      //! Pass activities session here
                      const PastActivitiesSession(),
                    ],
                  );
                } else if (state is MyCoursesError) {
                  if (state.message.contains('Data not found')) {
                    return const EmptyEnrollList();
                  } else {
                    return Center(
                      child: EmptyCourseList(
                        message: state.message,
                      ),
                    );
                  }
                } else {
                  return const Center(child: EmptyCourseList());
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
