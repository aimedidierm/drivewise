import 'dart:async';
import 'dart:convert';

import 'package:drivewise/constants.dart';
import 'package:drivewise/screens/company/driver/details.dart';
import 'package:drivewise/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListDrivers extends StatefulWidget {
  const ListDrivers({super.key});

  @override
  State<ListDrivers> createState() => _ListDriversState();
}

class _ListDriversState extends State<ListDrivers> {
  bool _loading = true;

  List<Map<String, dynamic>> _allDrivers = [];

  Future<void> fetchData() async {
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
                      itemCount: _allDrivers.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(index),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  const Text(
                                    "Name: ",
                                    textAlign: TextAlign.justify,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    _allDrivers[index]['name'],
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
                                      return DriverDetails(
                                        name: _allDrivers[index]['name'],
                                        email: _allDrivers[index]['email'],
                                        phone: _allDrivers[index]['phone'],
                                        vehicle: _allDrivers[index]
                                                    ['vehicle'] !=
                                                null
                                            ? _allDrivers[index]['vehicle']
                                                    ['plate'] ??
                                                ''
                                            : '',
                                        group: _allDrivers[index]['vehicle'] !=
                                                null
                                            ? (_allDrivers[index]['vehicle']
                                                        ['group'] !=
                                                    null
                                                ? _allDrivers[index]['vehicle']
                                                        ['group']['name'] ??
                                                    ''
                                                : '')
                                            : '',
                                      );
                                    },
                                  ),
                                );
                              },
                              subtitle: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text('Phone: '),
                                      Text(
                                        _allDrivers[index]['phone'],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text('Email: '),
                                      Text(
                                        _allDrivers[index]['email'],
                                      ),
                                    ],
                                  ),
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
