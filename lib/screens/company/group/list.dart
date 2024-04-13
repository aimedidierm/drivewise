import 'dart:async';
import 'dart:convert';

import 'package:drivewise/constants.dart';
import 'package:drivewise/screens/company/group/details.dart';
import 'package:drivewise/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListGroups extends StatefulWidget {
  const ListGroups({super.key});

  @override
  State<ListGroups> createState() => _ListGroupsState();
}

class _ListGroupsState extends State<ListGroups> {
  bool _loading = true;

  List<Map<String, dynamic>> _allGroups = [];

  Future<void> fetchData() async {
    String token = await getToken();
    final response = await http.get(Uri.parse(adminGroupsURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      final List<dynamic> decodedGroups = decodedResponse['groups'];
      final List<Map<String, dynamic>> groups =
          List<Map<String, dynamic>>.from(decodedGroups);
      setState(() {
        _allGroups = groups;
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
                      itemCount: _allGroups.length,
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
                                    _allGroups[index]['name'],
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
                                      return GroupDetails(
                                        name: _allGroups[index]['name'],
                                        description: _allGroups[index]
                                                ['description'] ??
                                            '',
                                      );
                                    },
                                  ),
                                );
                              },
                              subtitle: Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          _allGroups[index]['description'] ??
                                              '',
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
