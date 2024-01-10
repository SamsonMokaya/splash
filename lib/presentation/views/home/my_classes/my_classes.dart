// ignore_for_file: void_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocation_flutter/presentation/widgets/custom_drawer.dart';

import '../../../../business_logic/blocs/my_courses/my_courses_bloc.dart';
import '../../../../constants/constants.dart';
import '../../../exam_timetable/Widgets/custom_empty_classes_card.dart';
import '../../../exam_timetable/Widgets/scroll_behavior.dart';
import 'widgets/course_card.dart';

import '../../../../routes.dart' as route;

class MyClassesScreen extends StatelessWidget {
  const MyClassesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('My Classes', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, route.enrollScreen);
              },
              icon: const Icon(Icons.add, color: Colors.black)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: BlocBuilder<MyCoursesBloc, MyCoursesState>(
          builder: (context, state) {
            if (state is MyCoursesLoading) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoActivityIndicator(),
                  SizedBox(height: 20),
                  Text('Updating to the latest Time Table',
                      style: TextStyle(fontSize: 16))
                ],
              );
            } else if (state is MyCoursesLoaded) {
              if (state.units.isNotEmpty) {
                return ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<MyCoursesBloc>()
                          .add(LoadMyCourses(studentId: currentUser.id));
                    },
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: .9),
                      itemBuilder: (context, index) =>
                          UnitCard(unit: state.units.removeAt(0)),
                    ),
                    // end grid view
                  ),
                );
              } else {
                return const EmptyCourseList();
              }
            } else if (state is MyCoursesError) {
              if (state.message.contains('Data not found')) {
                return const EmptyCourseList();
              } else {
                return Center(child: Text(state.message));
              }
            } else {
              return const Center(child: EmptyCourseList());
            }
          },
        ),
      ),
    );
  }
}
