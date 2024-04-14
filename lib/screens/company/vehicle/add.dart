// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:drivewise/constants.dart';
import 'package:drivewise/models/api_response.dart';
import 'package:drivewise/screens/components/appbar.dart';
import 'package:drivewise/services/auth.dart';
import 'package:drivewise/services/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum FuelType { diesel, gasoline }

class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key});

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController plate = TextEditingController();
  TextEditingController load = TextEditingController();
  TextEditingController fuel = TextEditingController();
  TextEditingController fuelType = TextEditingController();

  bool _loading = false;
  bool _loadingData = true;
  int _selectedDriverId = 0;
  int _selectedGroupId = 0;

  FuelType? _selectedFuel;

  List<Map<String, dynamic>> _allDrivers = [];
  List<Map<String, dynamic>> _allGroups = [];

  Future<void> fetchDrivers() async {
    String token = await getToken();
    final response = await http.get(Uri.parse(adminDriversURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      final List<dynamic> decodedDrivers = decodedResponse['drivers'];
      final List<Map<String, dynamic>> drivers =
          List<Map<String, dynamic>>.from(decodedDrivers);
      setState(() {
        _allDrivers = drivers;
        _selectedDriverId = _allDrivers[0]['id'];
      });
    } else {
      // print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> fetchGroups() async {
    String token = await getToken();
    final response = await http.get(Uri.parse(adminGroupsURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      final List<dynamic> decodedGroups = decodedResponse['groups'];
      final List<Map<String, dynamic>> groups =
          List<Map<String, dynamic>>.from(decodedGroups);
      setState(() {
        _allGroups = groups;
        _selectedGroupId = _allGroups[0]['id'];
        _loadingData = false;
      });
    } else {
      // print('Request failed with status: ${response.statusCode}.');
    }
  }

  void registerVehicle() async {
    ApiResponse response = await register(
      name.text,
      plate.text,
      load.text,
      fuel.text,
      getEnumValue(_selectedFuel),
      _selectedDriverId.toString(),
      _selectedGroupId.toString(),
    );
    if (response.error == null) {
      setState(() {
        _loading = false;
        name.text = '';
        name.text = '';
        plate.text = '';
        load.text = '';
        fuel.text = '';
        fuelType.text = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vehicle registered'),
        ),
      );
    } else {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

  String getEnumValue(FuelType? enumValue) {
    if (enumValue != null) {
      return enumValue.toString().split('.').last;
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    fetchDrivers();
    fetchGroups();
  }

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const Text(
                        "Create vehicle",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: _loadingData
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : ListView(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Names are required';
                            } else {
                              return null;
                            }
                          },
                          controller: name,
                          decoration: const InputDecoration(
                            hintText: 'Enter names',
                            labelText: 'names',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Plate number is required';
                            } else {
                              return null;
                            }
                          },
                          controller: plate,
                          decoration: const InputDecoration(
                            hintText: 'Enter plate',
                            labelText: 'Plate',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Max load is required';
                            } else {
                              return null;
                            }
                          },
                          controller: load,
                          decoration: const InputDecoration(
                            hintText: 'Enter payload',
                            labelText: 'Payload',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Fuel is required';
                            } else {
                              return null;
                            }
                          },
                          controller: fuel,
                          decoration: const InputDecoration(
                            hintText: 'Fuel consumed  (L/KM):',
                            labelText: 'KMPL',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField<FuelType>(
                          value: _selectedFuel,
                          validator: (val) {
                            if (val == null) {
                              return 'Fuel Type is required';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              _selectedFuel = val;
                            });
                          },
                          items: FuelType.values.map((type) {
                            return DropdownMenuItem<FuelType>(
                              value: type,
                              child: Text(type
                                  .toString()
                                  .split('.')
                                  .last), // Display only the enum value
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            hintText: 'Fuel Type:',
                            labelText: 'Fuel Type',
                          ),
                        ),
                        DropdownButtonFormField<int>(
                          value: _selectedGroupId,
                          validator: (val) {
                            if (val == null) {
                              return 'Group is required';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              _selectedGroupId = val!;
                            });
                          },
                          items: _allGroups.map((group) {
                            return DropdownMenuItem<int>(
                              value: group['id'],
                              child: Text(group['name']),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            hintText: 'Group:',
                            labelText: 'Group',
                          ),
                        ),
                        DropdownButtonFormField<int>(
                          value: _selectedDriverId,
                          validator: (val) {
                            if (val == null) {
                              return 'Driver is required';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              _selectedDriverId = val!;
                            });
                          },
                          items: _allDrivers.map((driver) {
                            return DropdownMenuItem<int>(
                              value: driver['id'],
                              child: Text(driver['name']),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            hintText: 'Driver:',
                            labelText: 'Driver',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              setState(() {
                                _loading = true;
                              });
                              registerVehicle();
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) => primaryColor,
                            ),
                            padding: MaterialStateProperty.resolveWith(
                              (states) =>
                                  const EdgeInsets.symmetric(vertical: 20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: (_loading)
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
