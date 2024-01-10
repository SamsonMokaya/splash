import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../business_logic/cubits/cubit/select_enroll_unit_cubit.dart';
import '../../../../../repositories/models/unit.dart';
import '/constants/colors.dart';

class EnrollUnitCard extends StatelessWidget {
  const EnrollUnitCard({super.key, required this.unit});

  final CourseModel unit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectEnrollUnitCubit, SelectEnrollUnitState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => state.selectedUnits.contains(unit.courseCode)
              ? context
                  .read<SelectEnrollUnitCubit>()
                  .removeUnit(unit.courseCode.toString())
              : context
                  .read<SelectEnrollUnitCubit>()
                  .addUnit(unit.courseCode.toString()),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                    color: AppColors.secondary,
                    width:
                        state.selectedUnits.contains(unit.courseCode) ? 2 : 1)),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            unit.courseCode.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                fontSize: 17),
                          ),
                          //const SizedBox(height: 15),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Venue: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textGrey),
                              ),
                              Text(
                                unit.venue.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Time: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textGrey),
                              ),
                              Text(
                                unit.time.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'By: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textGrey),
                              ),
                              Text(
                                unit.coordinatorId.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: state.selectedUnits.contains(unit.courseCode)
                            ? GestureDetector(
                                onTap: () => context
                                    .read<SelectEnrollUnitCubit>()
                                    .removeUnit(unit.courseCode.toString()),
                                child: const Icon(
                                  Icons.check_circle,
                                  color: AppColors.secondary,
                                ),
                              )
                            : GestureDetector(
                                child: const Icon(Icons.check_circle_outline,
                                    color: AppColors.primary),
                                onTap: () => context
                                    .read<SelectEnrollUnitCubit>()
                                    .addUnit(unit.courseCode.toString()),
                              ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
