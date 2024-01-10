import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation_flutter/business_logic/blocs/enroll_units/enroll_units_bloc.dart';
import 'package:geolocation_flutter/business_logic/blocs/my_courses/my_courses_bloc.dart';
import 'package:geolocation_flutter/business_logic/cubits/cubit/select_enroll_unit_cubit.dart';
import 'package:geolocation_flutter/constants/colors.dart';
import 'package:geolocation_flutter/constants/constants.dart';
import 'package:geolocation_flutter/presentation/views/home/enroll/widget/enroll_unit_card.dart';

import '../../../../business_logic/blocs/search_course/search_bloc.dart';
import '../../../widgets/search_courses_widget.dart';
import 'widget/custom_empty_card.dart';

class EnrollCoursesScreen extends StatelessWidget {
  const EnrollCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Enrol Classes')),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const SearchCourseWidget(),
                  const SizedBox(height: 20),
                  BlocBuilder<SelectEnrollUnitCubit, SelectEnrollUnitState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          Text(
                            'Selected Units: ${state.selectedUnits.length}',
                            style: const TextStyle(color: AppColors.primary),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    //  height: size.height,
                    child: BlocBuilder<SearchCourseBloc, SearchCourseState>(
                      builder: (context, state) {
                        if (state is SearchLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                                color: AppColors.primary),
                          );
                        } else if (state is SearchError) {
                          return Center(
                            child: Text(state.message),
                          );
                        } else if (state is SearchLoaded) {
                          return state.units.isNotEmpty
                              ? SizedBox(
                                  height: size.height * .8,
                                  child: ListView.builder(
                                    //physics: NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.only(bottom: 50),
                                    itemBuilder: (context, index) {
                                      return EnrollUnitCard(
                                        unit: state.units[index],
                                      );
                                    },
                                    itemCount: state.units.length,
                                  ),
                                )
                              : const EmptyEnrollList(
                                  message: 'No units found ...try again');
                        } else {
                          return const EmptyEnrollList();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 60)
                ],
              ),
            ),
          ),
          BlocBuilder<SearchCourseBloc, SearchCourseState>(
            builder: (context, state) {
              if (state is SearchLoaded) {
                return BlocBuilder<SelectEnrollUnitCubit,
                    SelectEnrollUnitState>(
                  builder: (context, selected) {
                    if (selected.selectedUnits.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<EnrollUnitsBloc>().add(EnrollUnits(
                                studentId: currentUser.id.toString(),
                                unitcodes: jsonEncode(selected.selectedUnits)));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child:
                              BlocConsumer<EnrollUnitsBloc, EnrollUnitsState>(
                            listener: (context, state) {
                              if (state is EnrollUnitsLoaded) {
                                Fluttertoast.showToast(
                                    msg: 'Units enrolled successfully');
                                context
                                    .read<SelectEnrollUnitCubit>()
                                    .clearUnits();
                                context.read<MyCoursesBloc>().add(
                                    LoadMyCourses(studentId: currentUser.id));
                                Navigator.pop(context);
                              } else if (state is EnrollUnitsError) {
                                Fluttertoast.showToast(msg: state.message);
                              }
                            },
                            builder: (context, state) {
                              if (state is EnrollUnitsLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.white,
                                  ),
                                );
                              } else {
                                return const Text(
                                  'Enroll units',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                );
                              }
                            },
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}
