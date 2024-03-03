import 'dart:async';

import 'package:drivewise/constants.dart';
import 'package:drivewise/screens/company/maintenance/details.dart';
import 'package:flutter/material.dart';

class ListMaintenance extends StatefulWidget {
  const ListMaintenance({super.key});

  @override
  State<ListMaintenance> createState() => _ListMaintenanceState();
}

class _ListMaintenanceState extends State<ListMaintenance> {
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
                                    "Vehicle Plate: ",
                                    textAlign: TextAlign.justify,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'RAA 000 A',
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
                                      return const MaintenanceDetails();
                                    },
                                  ),
                                );
                              },
                              subtitle: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Title: Oil changing'),
                                  Text('Period: 1 month'),
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
