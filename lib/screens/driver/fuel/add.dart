import 'package:drivewise/constants.dart';
import 'package:drivewise/screens/components/appbar.dart';
import 'package:flutter/material.dart';

enum FuelType { DIESEL, GASOLINE }

class AddFuel extends StatefulWidget {
  const AddFuel({super.key});

  @override
  State<AddFuel> createState() => _AddFuelState();
}

class _AddFuelState extends State<AddFuel> {
  bool _loading = false;

  String moneyInput = '';
  double fuelAmount = 0.0;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController moneyController = TextEditingController();

  FuelType? _selectedFuel;

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
      body: ListView(
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
                          fuelAmount = double.parse(val) * 2;
                        }
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter Money',
                      labelText: 'Money',
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        setState(
                          () {
                            _loading = true;
                          },
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => primaryColor,
                      ),
                      padding: MaterialStateProperty.resolveWith(
                        (states) => const EdgeInsets.symmetric(vertical: 20),
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
