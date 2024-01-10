// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocation_flutter/business_logic/blocs/exam_units/exam_unit_bloc.dart';
import 'package:geolocation_flutter/constants/colors.dart';

class SearchBox extends StatelessWidget {
  SearchBox({super.key});
  TextEditingController unitsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: TextField(
            controller: unitsController,
            onSubmitted: (value) => context
                .read<ExamsUnitsBloc>()
                .add(ExamLoadUnits(courses: value.toUpperCase())),
            decoration: InputDecoration(
              hintText: "Search for your units (acs113, bil111A, ...)",
              hintStyle: const TextStyle(fontSize: 15),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.primary)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.textGrey)),
              contentPadding: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 0, top: 10),
            ),
          ),
        ),
        Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              onPressed: () {
                unitsController.value.text.toString().isNotEmpty
                    ? context.read<ExamsUnitsBloc>().add(ExamLoadUnits(
                        courses: unitsController.value.text
                            .toString()
                            .toUpperCase()))
                    : Fluttertoast.showToast(
                        msg: "Kindly add an unit in the search box");
                FocusManager.instance.primaryFocus?.unfocus();
              },
              icon: const Icon(Icons.search, color: Colors.white, size: 30),
            ))
      ],
    );
  }
}
