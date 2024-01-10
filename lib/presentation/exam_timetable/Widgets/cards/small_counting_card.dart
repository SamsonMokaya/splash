import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class SmallCountingCard extends StatelessWidget {
  const SmallCountingCard(
      {super.key, required this.a, required this.b, required this.lable});
  final String a, b, lable;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 31,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(2),
                          bottomRight: Radius.circular(2),
                        ),
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      height: 31,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2),
                          topRight: Radius.circular(2),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  a,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(width: 4),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 31,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(2),
                          bottomRight: Radius.circular(2),
                        ),
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      height: 31,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2),
                          topRight: Radius.circular(2),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  b,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          lable,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
