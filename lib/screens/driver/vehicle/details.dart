import 'dart:convert';

import 'package:drivewise/constants.dart';
import 'package:drivewise/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VehicleDetails extends StatefulWidget {
  const VehicleDetails({super.key});

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  bool _loading = true;
  String name = '',
      vehicle = '',
      group = '',
      load = '',
      type = '',
      fuel = '',
      driver = '';

  Future<void> fetchData() async {
    String token = await getToken();
    final response = await http.get(Uri.parse(drivervehicleURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body)['vehicle'];
      setState(() {
        name = decodedResponse['name'];
        vehicle = decodedResponse['plate'];
        group = decodedResponse['group']['name'];
        load = decodedResponse['load'];
        type = decodedResponse['fuel_type'];
        fuel = decodedResponse['fuel'];
        driver = decodedResponse['user']['name'];
        _loading = false;
      });
    } else {
      // print('Request failed with status: ${response.statusCode}.');
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
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Name: ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Vehicle plate: ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        vehicle,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Vehicle group: ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        group,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Max load: ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        '$load KG',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Fuel type: ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        type,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Fuel (KM/L): ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        fuel,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Driver: ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        driver,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
