import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/assets_urls.dart';

class EmptyUnitsList extends StatelessWidget {
  final String message;
  const EmptyUnitsList(
      {super.key, this.message = 'You haven\'t saved any units yet'});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Text(
        message,
        style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 20),
      ),
      const SizedBox(height: 20),
      SvgPicture.asset(Assets.emptyData, height: 150)
    ]);
  }
}
