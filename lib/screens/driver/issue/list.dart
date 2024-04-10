import 'dart:async';

import 'package:drivewise/constants.dart';
import 'package:drivewise/screens/driver/issue/details.dart';
import 'package:flutter/material.dart';

class ListIssues extends StatefulWidget {
  const ListIssues({super.key});

  @override
  State<ListIssues> createState() => _ListIssuesState();
}

class _ListIssuesState extends State<ListIssues> {
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
                              title: const Text(
                                "Accident ",
                                textAlign: TextAlign.justify,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(16),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return const IssueDetails();
                                    },
                                  ),
                                );
                              },
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Emergency",
                                    textAlign: TextAlign.justify,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  const Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "Explore our diverse range of vehicles designed to meet your every need. From sleek and stylish sports cars to rugged and dependable trucks, we have something for every driver. Our selection includes fuel-efficient hybrids, spacious SUVs, and nimble compact cars. Whether you're commuting to work or heading off-road for adventure, our vehicles are built to deliver performance, comfort, and reliability.",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
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
