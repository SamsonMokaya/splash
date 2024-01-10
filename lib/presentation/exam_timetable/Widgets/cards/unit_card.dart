import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocation_flutter/business_logic/blocs/saved_units/saved_units_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../repositories/models/exam_model.dart';
import '/constants/colors.dart';

class UnitCard extends StatelessWidget {
  const UnitCard({super.key, required this.unit, this.isSaved = false});
  final bool isSaved;
  final ExamModel unit;

  @override
  Widget build(BuildContext context) {
    // Convert string to DateTime object
    final date = (unit.date.toString().trim()).split(' ');
    String datePart = date[1]; // "17/04/23"

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppColors.topGradientColor)),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      unit.courseCode.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textGrey,
                          fontSize: 17),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        const Text('Date: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textGrey)),
                        Text(
                          DateFormat('EEE dd/MM/yy')
                              .format(DateFormat('dd/MM/yy').parse(datePart)),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    const SizedBox(height: 15),
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
                  ],
                ),
              ],
            ),
          ),
          isSaved
              ? IconButton(
                  onPressed: () {
                    context.read<SavedUnitsBloc>().add(DeleteUnit(unit: unit));
                    context.read<SavedUnitsBloc>().add(LoadSavedUnits());
                  },
                  icon: const Icon(
                    Icons.delete_forever,
                    color: AppColors.red,
                  ),
                )
              : InkWell(
                  onTap: () {
                    context.read<SavedUnitsBloc>().add(SaveUnit(unit: unit));
                    context.read<SavedUnitsBloc>().add(LoadSavedUnits());
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 5, top: 5),
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.bottomGradientColor,
                    ),
                    child: const Icon(
                      Icons.arrow_upward_rounded,
                      color: Colors.white,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
