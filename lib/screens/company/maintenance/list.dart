import 'dart:async';
import 'dart:convert';

import 'package:drivewise/constants.dart';
import 'package:drivewise/screens/company/maintenance/details.dart';
import 'package:drivewise/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListMaintenance extends StatefulWidget {
  const ListMaintenance({super.key});

  @override
  State<ListMaintenance> createState() => _ListMaintenanceState();
}

class _ListMaintenanceState extends State<ListMaintenance> {
  bool _loading = true;

  List<Map<String, dynamic>> _allMaintenances = [];

  Future<void> fetchData() async {
    String token = await getToken();
    final response = await http.get(Uri.parse(adminMaintenancesURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      final List<dynamic> decodedMaintenances = decodedResponse['maintenance'];
      final List<Map<String, dynamic>> maintenances =
          List<Map<String, dynamic>>.from(decodedMaintenances);
      setState(() {
        _allMaintenances = maintenances;
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
                      itemCount: _allMaintenances.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(index),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  const Text(
                                    "Vehicle Plate: ",
                                    textAlign: TextAlign.justify,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    _allMaintenances[index]['vehicle']['plate'],
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
                                      return MaintenanceDetails(
                                          name: _allMaintenances[index]
                                              ['title'],
                                          description: _allMaintenances[index]
                                              ['notification'],
                                          unit: _allMaintenances[index]['unit'],
                                          interval: _allMaintenances[index]
                                                  ['interval']
                                              .toString(),
                                          vehicle: _allMaintenances[index]
                                              ['vehicle']['plate'],
                                          next: _allMaintenances[index]
                                              ['next_time']);
                                    },
                                  ),
                                );
                              },
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Title: ${_allMaintenances[index]['title']}'),
                                  Text(
                                      'Period: Every ${_allMaintenances[index]['interval']} ${_allMaintenances[index]['unit']}'),
                                  (_allMaintenances[index]['next_time'] != null)
                                      ? Text(
                                          'Next: ${_allMaintenances[index]['next_time']}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )
                                      : const SizedBox()
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
