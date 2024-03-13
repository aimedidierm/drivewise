import 'package:drivewise/constants.dart';
import 'package:drivewise/screens/auth/login.dart';
import 'package:drivewise/screens/auth/settings.dart';
import 'package:drivewise/screens/company/dashboard.dart';
import 'package:drivewise/screens/company/driver/add.dart';
import 'package:drivewise/screens/company/driver/list.dart';
import 'package:drivewise/screens/company/group/add.dart';
import 'package:drivewise/screens/company/group/list.dart';
import 'package:drivewise/screens/company/maintenance/add.dart';
import 'package:drivewise/screens/company/maintenance/list.dart';
import 'package:drivewise/screens/company/vehicle/add.dart';
import 'package:drivewise/screens/company/vehicle/list.dart';
import 'package:drivewise/screens/components/appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CompanyHome extends StatefulWidget {
  const CompanyHome({super.key});

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  int _selectedIndex = 0;
  static List<Widget> page = [
    const Dashboard(),
    const ListDrivers(),
    const ListGroups(),
    const ListVehicles(),
    const ListMaintenance(),
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
                        "Company account",
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
                MaterialPageRoute(builder: (context) => const AddDriver()),
              );
            } else if (_selectedIndex == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddGroup()),
              );
            } else if (_selectedIndex == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddVehicle()),
              );
            } else if (_selectedIndex == 4) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddMaintenance()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            }
          },
          child: (_selectedIndex == 0)
              ? Icon(
                  Icons.manage_accounts,
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
