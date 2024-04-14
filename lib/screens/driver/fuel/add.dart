// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:drivewise/constants.dart';
import 'package:drivewise/models/api_response.dart';
import 'package:drivewise/screens/components/appbar.dart';
import 'package:drivewise/services/auth.dart';
import 'package:drivewise/services/fuel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum FuelType { diesel, gasoline }

class AddFuel extends StatefulWidget {
  const AddFuel({super.key});

  @override
  State<AddFuel> createState() => _AddFuelState();
}

class _AddFuelState extends State<AddFuel> {
  bool _loading = true;
  bool _loadingButton = false;
  String gasolinePrice = '';
  String dieselPrice = '';

  String moneyInput = '';
  double fuelAmount = 0.0;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController moneyController = TextEditingController();

  FuelType? _selectedFuel;

  String getEnumValue(FuelType? enumValue) {
    if (enumValue != null) {
      return enumValue.toString().split('.').last;
    }
    return '';
  }

  Future<void> fetchData() async {
    String token = await getToken();
    final response = await http.get(Uri.parse(driverPricesURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      final List<dynamic> decodedPrices = decodedResponse['prices'];
      final List<Map<String, dynamic>> priceDetails =
          List<Map<String, dynamic>>.from(decodedPrices);
      setState(() {
        dieselPrice = priceDetails[1]['price'];
        gasolinePrice = priceDetails[0]['price'];
        _loading = false;
      });
    } else {
      // print('Request failed with status: ${response.statusCode}.');
    }
  }

  void registerFuel() async {
    ApiResponse response = await register(
      fuelAmount.toString(),
      moneyController.text,
    );
    if (response.error == null) {
      setState(() {
        _loadingButton = false;
        moneyController.text = '';
        fuelAmount = 0.0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fuel registered'),
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

  @override
  void initState() {
    super.initState();
    fetchData();
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
                        "Add fuel refilling",
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
      body: _loading
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
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          '$fuelAmount L',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
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
                              moneyController.text = '';
                              _selectedFuel = val;
                            });
                          },
                          items: FuelType.values.map((type) {
                            return DropdownMenuItem<FuelType>(
                              value: type,
                              child: Text(type.toString().split('.').last),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            hintText: 'Fuel Type:',
                            labelText: 'Fuel Type',
                          ),
                        ),
                        TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Money is required';
                            } else {
                              if (double.tryParse(val) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            }
                          },
                          controller: moneyController,
                          onChanged: (val) {
                            setState(() {
                              moneyInput = val;
                              if (double.tryParse(val) != null) {
                                if (getEnumValue(_selectedFuel) == 'diesel') {
                                  fuelAmount = double.parse(val) /
                                      double.parse(dieselPrice);
                                  fuelAmount = double.parse(
                                      fuelAmount.toStringAsFixed(2));
                                } else {
                                  fuelAmount = double.parse(val) /
                                      double.parse(gasolinePrice);
                                  fuelAmount = double.parse(
                                      fuelAmount.toStringAsFixed(2));
                                }
                              }
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter Money',
                            labelText: 'Money',
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              setState(
                                () {
                                  _loadingButton = true;
                                  registerFuel();
                                },
                              );
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
                            child: (_loadingButton)
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
