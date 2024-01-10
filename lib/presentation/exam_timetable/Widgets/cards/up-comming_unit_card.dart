// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocation_flutter/business_logic/blocs/saved_units/saved_units_bloc.dart';

import '../../../../repositories/models/exam_model.dart';
import '../scroll_behavior.dart';
import '/constants/colors.dart';

class UpcomingUnitCard extends StatelessWidget {
  const UpcomingUnitCard({Key? key, required this.unit}) : super(key: key);
  final ExamModel unit;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: AppColors.topGradientColor),
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
                  color: AppColors.primary.withOpacity(0.4),
                  offset: const Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView(
                children: [
                  Container(
                    height: 30,
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration:
                        const BoxDecoration(color: AppColors.bottomGradientColor),
                    child: Text(
                      'Upcoming Exam',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: AppColors.textGrey,
                            fontSize: 17,
                            wordSpacing: 5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          unit.courseCode.toString(),
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  fontSize: 25),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  unit.date.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.textGrey,
                                        letterSpacing: 1,
                                      ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.calendar_month_sharp,
                                        color: AppColors.bottomGradientColor,
                                        size: 35),
                                    const SizedBox(width: 10),
                                    Text(
                                      unit.time.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: AppColors.textGrey,
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
                                    color: AppColors.bottomGradientColor,
                                    size: 35),
                                const SizedBox(width: 10),
                                Text(
                                  unit.venue.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: AppColors.textGrey,
                                        letterSpacing: 1,
                                      ),
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
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            width: 50,
            height: 30,
            decoration: const BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(15),
                )),
            child: IconButton(
              icon: const Icon(Icons.delete_forever,
                  color: Colors.white, size: 18),
              onPressed: () {
                context.read<SavedUnitsBloc>().add(DeleteUnit(unit: unit));
                context.read<SavedUnitsBloc>().add(LoadSavedUnits());
              },
            ),
          )
        ],
      ),
    );
  }
}
