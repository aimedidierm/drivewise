import 'dart:async';

import 'package:drivewise/constants.dart';
import 'package:drivewise/screens/company/driver/details.dart';
import 'package:flutter/material.dart';

class ListDrivers extends StatefulWidget {
  const ListDrivers({super.key});

  @override
  State<ListDrivers> createState() => _ListDriversState();
}

class _ListDriversState extends State<ListDrivers> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _loading = false;
      });
    });
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
                      itemCount: 20,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(index),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          children: [
                            ListTile(
                              title: const Row(
                                children: [
                                  Text(
                                    "Name: ",
                                    textAlign: TextAlign.justify,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Driver name',
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
                                      return const DriverDetails();
                                    },
                                  ),
                                );
                              },
                              subtitle: const Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('phone: '),
                                      Text(
                                        "0788750979",
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Email: '),
                                      Text(
                                        'driver@gmail.com',
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
