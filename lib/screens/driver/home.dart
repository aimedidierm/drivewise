import 'package:drivewise/constants.dart';
import 'package:drivewise/screens/auth/login.dart';
import 'package:drivewise/screens/auth/settings.dart';
import 'package:drivewise/screens/components/appbar.dart';
import 'package:drivewise/screens/driver/dashboard.dart';
import 'package:drivewise/screens/driver/fuel/add.dart';
import 'package:drivewise/screens/driver/fuel/list.dart';
import 'package:drivewise/screens/driver/issue/add.dart';
import 'package:drivewise/screens/driver/issue/list.dart';
import 'package:drivewise/screens/driver/journey/add.dart';
import 'package:drivewise/screens/driver/journey/list.dart';
import 'package:drivewise/screens/driver/vehicle/details.dart';
import 'package:drivewise/services/auth.dart';
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
    const Dashboard(),
    const ListJourneys(),
    const ListIssues(),
    const ListFuel(),
    const VehicleDetails(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: ClipPath(
          clipper: AppBarClipPath(),
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Driver account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: page[_selectedIndex],
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
                  icon: Icons.route,
                  text: 'Journeys',
                ),
                GButton(
                  icon: Icons.error,
                  text: 'Issues',
                ),
                GButton(
                  icon: Icons.local_gas_station,
                  text: 'Fuel',
                ),
                GButton(
                  icon: Icons.drive_eta,
                  text: 'Vehicle',
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
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          onPressed: () {
            if (_selectedIndex == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              );
            } else if (_selectedIndex == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddJourney()),
              );
            } else if (_selectedIndex == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddIssue()),
              );
            } else if (_selectedIndex == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddFuel()),
              );
            } else {
              logout().then(
                (value) => {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Login()),
                    (route) => false,
                  ),
                },
              );
            }
          },
          child: (_selectedIndex == 0)
              ? Icon(
                  Icons.manage_accounts,
                  color: primaryColor,
                )
              : (_selectedIndex == 4)
                  ? Icon(
                      Icons.logout,
                      color: primaryColor,
                    )
                  : Icon(
                      Icons.add,
                      color: primaryColor,
                    ),
        ),
      ),
    );
  }
}
