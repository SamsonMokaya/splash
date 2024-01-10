import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/assets_urls.dart';
import '../../../constants/colors.dart';
import '../../../routes.dart' as route;

class EmptyCourseList extends StatelessWidget {
  final String message;
  const EmptyCourseList(
      {super.key, this.message = 'You haven\'t enrolled in any class yet'});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: size.height * 0.1),
          ),
          Text(
            message,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontSize: 20,
                color: AppColors.primary,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          SvgPicture.asset(Assets.noClass, height: 150),
          const SizedBox(height: 30),
          Container(
            margin: EdgeInsets.all(size.width * 0.1),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, route.enrollScreen);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Enroll Now',
                    style: TextStyle(color: Colors.white))),
          ),
        ]);
  }
}
