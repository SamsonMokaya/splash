import 'package:flutter/material.dart';
import 'package:geolocation_flutter/constants/colors.dart';
import 'package:geolocation_flutter/constants/constants.dart';
import 'package:geolocation_flutter/presentation/widgets/log_out_dialog.dart';
import 'package:geolocation_flutter/routes.dart' as route;

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  // Define a list of menu items
  final List<Map<String, dynamic>> menuItems = [
    {
      "title": 'Home',
      "icon": Icons.home,
      "route": route.dashboard,
      "arguments": {"page": "Airtime", "title": "Buy airtime"}
    },
    {"title": 'My Classes', "icon": Icons.class_, "route": route.classes},
    {
      "title": 'Recent Attendances',
      "icon": Icons.access_time,
      "route": route.passActivities
    },
    {
      "title": 'Exam Timetable',
      "icon": Icons.schedule,
      "route": route.timetable
    },
    // {"title": 'Settings', "icon": Icons.settings, "route": route.settings},
    {"title": 'Account', "icon": Icons.account_circle, "route": route.account},
    {"title": 'Log out', "icon": Icons.logout, "action": logOutDialog}
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      // Add your avatar image here
                    ),
                    const SizedBox(width: 20),
                    Text(
                      currentUser.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                )
              ],
            ),
          ),
          // Generate ListTile widgets from the menuItems list
          for (var item in menuItems)
            ListTile(
              leading: Icon(
                item['icon'],
                color: Colors.white,
                size: 24,
              ),
              title: Text(
                item['title'],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                if (item.containsKey('route')) {
                  Navigator.of(context)
                      .pushNamed(item['route'], arguments: item['arguments']);
                } else if (item.containsKey('action')) {
                  item['action'](context);
                }
              },
            ),
        ],
      ),
    );
  }
}
