import 'dart:async';

import 'package:drivewise/constants.dart';
import 'package:drivewise/screens/company/group/details.dart';
import 'package:flutter/material.dart';

class ListGroups extends StatefulWidget {
  const ListGroups({super.key});

  @override
  State<ListGroups> createState() => _ListGroupsState();
}

class _ListGroupsState extends State<ListGroups> {
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
                                    'Group name',
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
                                      return const GroupDetails();
                                    },
                                  ),
                                );
                              },
                              subtitle: const Column(
                                children: [
                                  Row(
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
