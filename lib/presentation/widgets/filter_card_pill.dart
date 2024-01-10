import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubits/history_page/history_cubit.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';

class FilterTabPill extends StatelessWidget {
  final HistoryType type;
  final String text;
  const FilterTabPill({super.key, required this.type, required this.text});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<HistoryCubit>();
    final state = cubit.state;
    final Color color =
        state.type == type ? AppColors.secondary : Colors.transparent;
    final Color textColor =
        state.type == type ? AppColors.primary : AppColors.secondary;
    return GestureDetector(
      onTap: () => cubit.switchOrdersView(type: type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        height: 30,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        child: Text(text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
