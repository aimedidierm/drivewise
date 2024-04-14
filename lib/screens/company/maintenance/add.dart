// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:drivewise/constants.dart';
import 'package:drivewise/models/api_response.dart';
import 'package:drivewise/screens/components/appbar.dart';
import 'package:drivewise/services/auth.dart';
import 'package:drivewise/services/maintenance.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum Unit { minute, hour, day, week, month }

class AddMaintenance extends StatefulWidget {
  const AddMaintenance({super.key});

  @override
  State<AddMaintenance> createState() => _AddMaintenanceState();
}

class _AddMaintenanceState extends State<AddMaintenance> {
  bool _loading = false;
  int _selectedVehicleId = 0;
  bool _loadingData = true;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController notification = TextEditingController();
  TextEditingController period = TextEditingController();

  Unit? _selectedUnit;

  List<Map<String, dynamic>> _allVehicles = [];

  String getEnumValue(Unit? enumValue) {
    if (enumValue != null) {
      return enumValue.toString().split('.').last;
    }
    return '';
  }

  void registerMaintenance() async {
    ApiResponse response = await register(
      title.text,
      notification.text,
      period.text,
      getEnumValue(_selectedUnit),
      _selectedVehicleId.toString(),
    );
    if (response.error == null) {
      setState(() {
        _loading = false;
        title.text = '';
        notification.text = '';
        period.text = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Maintenance registered'),
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

  Future<void> fetchVehicles() async {
    String token = await getToken();
    final response = await http.get(Uri.parse(adminVehiclesURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      final List<dynamic> decodedVehicles = decodedResponse['vehicles'];
      final List<Map<String, dynamic>> vehicles =
          List<Map<String, dynamic>>.from(decodedVehicles);
      setState(() {
        _allVehicles = vehicles;
        _selectedVehicleId = _allVehicles[0]['id'];
        _loadingData = false;
      });
    } else {
      // print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchVehicles();
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
                        "Create maintenance",
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
                              return 'Title are required';
                            } else {
                              return null;
                            }
                          },
                          controller: title,
                          decoration: const InputDecoration(
                            hintText: 'Enter title',
                            labelText: 'Title',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Notification is required';
                            } else {
                              return null;
                            }
                          },
                          controller: notification,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            hintText: 'Enter notification',
                            labelText: 'Notification',
                            alignLabelWithHint: true,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Period is required';
                            } else {
                              return null;
                            }
                          },
                          controller: period,
                          decoration: const InputDecoration(
                            hintText: 'Enter period',
                            labelText: 'Period',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField<Unit>(
                          value: _selectedUnit,
                          validator: (val) {
                            if (val == null) {
                              return 'Unit is required';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              _selectedUnit = val;
                            });
                          },
                          items: Unit.values.map((type) {
                            return DropdownMenuItem<Unit>(
                              value: type,
                              child: Text(type.toString().split('.').last),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            hintText: 'Unit:',
                            labelText: 'Unit',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField<int>(
                          value: _selectedVehicleId,
                          validator: (val) {
                            if (val == null) {
                              return 'Vehicle is required';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              _selectedVehicleId = val!;
                            });
                          },
                          items: _allVehicles.map((vehicle) {
                            return DropdownMenuItem<int>(
                              value: vehicle['id'],
                              child: Text(vehicle['name']),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            hintText: 'Vehicle:',
                            labelText: 'Vehicle',
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
                              registerMaintenance();
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
