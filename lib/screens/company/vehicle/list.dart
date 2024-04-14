import 'dart:async';
import 'dart:convert';

import 'package:drivewise/constants.dart';
import 'package:drivewise/screens/company/vehicle/details.dart';
import 'package:drivewise/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListVehicles extends StatefulWidget {
  const ListVehicles({super.key});

  @override
  State<ListVehicles> createState() => _ListVehiclesState();
}

class _ListVehiclesState extends State<ListVehicles> {
  bool _loading = true;

  List<Map<String, dynamic>> _allVehicles = [];

  Future<void> fetchData() async {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: _loading
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _allVehicles.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(index),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  const Text(
                                    "Plate: ",
                                    textAlign: TextAlign.justify,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    _allVehicles[index]['plate'],
                                    textAlign: TextAlign.justify,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              contentPadding: const EdgeInsets.all(16),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return VehicleDetails(
                                        name: _allVehicles[index]['name'],
                                        vehicle: _allVehicles[index]['plate'],
                                        group: _allVehicles[index]['group']
                                            ['name'],
                                        load: _allVehicles[index]['load'],
                                        type: _allVehicles[index]['fuel_type'],
                                        fuel: _allVehicles[index]['fuel'],
                                        driver: _allVehicles[index]['user']
                                            ['name'],
                                      );
                                    },
                                  ),
                                );
                              },
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Name: ${_allVehicles[index]['name']}'),
                                  Text(
                                      'Driver: ${_allVehicles[index]['user']['name']}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
