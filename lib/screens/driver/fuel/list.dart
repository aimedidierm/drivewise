import 'dart:async';

import 'package:drivewise/constants.dart';
import 'package:flutter/material.dart';

class ListFuel extends StatefulWidget {
  const ListFuel({super.key});

  @override
  State<ListFuel> createState() => _ListFuelState();
}

class _ListFuelState extends State<ListFuel> {
  bool _loading = true;
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _loading = false;
      });
    });
    return Scaffold(
      body: Center(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "12/03/2024",
                                    textAlign: TextAlign.justify,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              contentPadding: const EdgeInsets.all(16),
                              // onTap: () {},
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Price: 4,000Rwf'),
                                      Text('Volume: 1.7L'),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      child: Text(
                                        'RAA 000 A',
                                        style: TextStyle(color: primaryColor),
                                      ),
                                    ),
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
