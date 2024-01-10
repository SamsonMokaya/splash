import 'package:flutter/material.dart';
import 'package:geolocation_flutter/constants/colors.dart';
import 'package:geolocation_flutter/repositories/models/unit.dart';

class UnitCard extends StatelessWidget {
  final VoidCallbackAction? onPressed;

  final CourseModel unit;
  final Size size;

  const UnitCard(
      {required this.unit,
      this.onPressed,
      Key? key,
      this.size = const Size(250, 230)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed,
      child: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(10, 20),
                blurRadius: 10,
                spreadRadius: 0,
                color: Colors.grey.withOpacity(.05)),
          ],
        ),
        child: Column(children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.secondary.withOpacity(.4),
            child: Text(
              //take only the first 3 letters of the course code
              unit.courseCode.toString().substring(0, 2).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          const Spacer(),
          Text(unit.courseCode.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          const SizedBox(height: 5),
          Text(
            unit.coordinatorId.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 12),
          ),
          const SizedBox(height: 10),
        ]),
      ),
    );
  }
}
