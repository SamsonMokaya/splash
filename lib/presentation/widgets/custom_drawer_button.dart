//button used on the ProfessionalService drawer
import 'package:flutter/material.dart';

class CustomDrawerButton extends StatelessWidget {
  final String icon;
  final String title;
  final String route;
  final Color color;
  const CustomDrawerButton(
      {super.key,
      this.color = Colors.white,
      required this.icon,
      required this.title,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: Image(
            image: AssetImage(
              icon,
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(color: color),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          color: Colors.white,
        ),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}
