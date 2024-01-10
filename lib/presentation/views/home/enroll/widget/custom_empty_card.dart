import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constants/assets_urls.dart';

class EmptyEnrollList extends StatelessWidget {
  const EmptyEnrollList({super.key, this.message = 'Search for your units'});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(height: MediaQuery.of(context).size.height * 0.15),
      Text(
        'Search for your units',
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 20),
      SvgPicture.asset(Assets.course, height: 200)
    ]);
  }
}
