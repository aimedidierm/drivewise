import 'package:drivewise/constants.dart';
import 'package:flutter/material.dart';

enum FuelType { DIESEL, GASOLINE }

enum Group { GROUP1, GROUP2 }

enum Driver { DRIVER1, DRIVER2 }

class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key});

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  bool _loading = false;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController plate = TextEditingController();
  TextEditingController load = TextEditingController();
  TextEditingController fuel = TextEditingController();
  TextEditingController fuelType = TextEditingController();

  FuelType? _selectedFuel;
  Group? _selectedGroup;
  Driver? _selectedDriver;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
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
                      hintText: 'Enter max load',
                      labelText: 'Max load',
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
                      hintText: 'Fuel  (L/KM):',
                      labelText: 'Fuel',
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
                        child: Text(type.toString().split('.').last),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      hintText: 'Fuel Type:',
                      labelText: 'Fuel Type',
                    ),
                  ),
                  DropdownButtonFormField<Group>(
                    value: _selectedGroup,
                    validator: (val) {
                      if (val == null) {
                        return 'Group is required';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        _selectedGroup = val;
                      });
                    },
                    items: Group.values.map((type) {
                      return DropdownMenuItem<Group>(
                        value: type,
                        child: Text(type.toString().split('.').last),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      hintText: 'Group:',
                      labelText: 'Group',
                    ),
                  ),
                  DropdownButtonFormField<Driver>(
                    value: _selectedDriver,
                    validator: (val) {
                      if (val == null) {
                        return 'Driver is required';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        _selectedDriver = val;
                      });
                    },
                    items: Driver.values.map((type) {
                      return DropdownMenuItem<Driver>(
                        value: type,
                        child: Text(type.toString().split('.').last),
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
                        // registerDriver();
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
