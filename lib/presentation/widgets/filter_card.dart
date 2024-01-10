import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import 'filter_card_pill.dart';

class FilterCard extends StatelessWidget {
  const FilterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterTabPill(
              type: HistoryType.All,
              text: 'All',
            ),
            FilterTabPill(
              type: HistoryType.Daily,
              text: 'Today',
            ),
            FilterTabPill(
              type: HistoryType.Weekly,
              text: 'Weekly',
            ),
            FilterTabPill(
              type: HistoryType.Monthly,
              text: 'Monthly',
            ),
          ],
        ),
      ),
    );
  }
}
