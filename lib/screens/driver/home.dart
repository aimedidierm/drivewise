import 'package:drivewise/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({super.key});

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  int _selectedIndex = 0;
  static List<Widget> page = [
    const Center(
      child: Text('Dashboard'),
    ),
    const Center(
      child: Text('Journey'),
    ),
    const Center(
      child: Text('Issues'),
    ),
    const Center(
      child: Text('Fuel'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: primaryColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: GNav(
              backgroundColor: primaryColor,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.white38,
              gap: 10,
              padding: const EdgeInsets.all(10),
              duration: const Duration(milliseconds: 400),
              tabBorderRadius: 10,
              tabs: const [
                GButton(
                  icon: Icons.dashboard,
                  text: 'Dashboard',
                ),
                GButton(
                  icon: Icons.group,
                  text: 'Drivers',
                ),
                GButton(
                  icon: Icons.group_work,
                  text: 'Group',
                ),
                GButton(
                  icon: Icons.drive_eta_outlined,
                  text: 'Vehicles',
                ),
                GButton(
                  icon: Icons.car_repair_sharp,
                  text: 'Maintenance',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
