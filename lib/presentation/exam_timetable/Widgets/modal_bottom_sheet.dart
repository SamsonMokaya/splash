import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocation_flutter/business_logic/blocs/exam_units/exam_unit_bloc.dart';
import '../../../constants/assets_urls.dart';
import './search_box.dart';
import '/constants/colors.dart';
import 'cards/unit_card.dart';
import 'custom_loading.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: Scaffold(
        resizeToAvoidBottomInset: true, //
        backgroundColor: const Color(0xfffbfbfb),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SearchBox(),
                const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .40,
                  child: Center(
                    child: BlocBuilder<ExamsUnitsBloc, ExamUnitsState>(
                      builder: (context, state) {
                        if (state is ExamUnitsLoading) {
                          return Builder(builder: (context) {
                            return const CustomLoading();
                          });
                        } else if (state is ExamUnitsInitial) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: Center(
                              child: Container(
                                height: 90,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.textGrey.withOpacity(.4),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Please enter your course codes separated by commas to receive a simplified timetable of your exams.',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color: AppColors.blackColor,
                                          fontSize: 15),
                                ),
                              ),
                            ),
                          );
                        } else if (state is ExamUnitsLoaded) {
                          final units = state.unitsList;

                          return units.isEmpty
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'No results found',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'We couldn\'t find what you searched for.\nTry searching again.\n',
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 10),
                                    SvgPicture.asset(Assets.emptyData,
                                        height: 130),
                                  ],
                                )
                              : ListView.builder(
                                  itemCount: units.length,
                                  itemBuilder: (context, index) =>
                                      UnitCard(unit: units[index]),
                                );
                        } else if (state is ExamUnitsLoadLoadingError) {
                          if (state.errorMessage.split(':').first ==
                              'Failed host lookup') {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * .2,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 200,
                                child: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Check your Network, \nLooks like your offline",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Icon(Icons.wifi_off,
                                          size: 60, color: Colors.grey)
                                    ]),
                              ),
                            );
                          }
                          return Center(
                              child: Text(state.errorMessage.split(':').first));
                        } else {
                          return const Center(
                              child: Text('Something went wrong'));
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
