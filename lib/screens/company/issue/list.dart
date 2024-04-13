import 'dart:async';
import 'dart:convert';

import 'package:drivewise/constants.dart';
import 'package:drivewise/screens/company/issue/details.dart';
import 'package:drivewise/screens/components/appbar.dart';
import 'package:drivewise/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListIssues extends StatefulWidget {
  const ListIssues({super.key});

  @override
  State<ListIssues> createState() => _ListIssuesState();
}

class _ListIssuesState extends State<ListIssues> {
  bool _loading = true;

  List<Map<String, dynamic>> _allIssues = [];

  Future<void> fetchData() async {
    String token = await getToken();
    final response = await http.get(Uri.parse(adminIssuesURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      final List<dynamic> decodedIssues = decodedResponse['issues'];
      final List<Map<String, dynamic>> issues =
          List<Map<String, dynamic>>.from(decodedIssues);
      setState(() {
        _allIssues = issues;
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: ClipPath(
          clipper: AppBarClipPath(),
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const Text(
                        "Issues",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
                      itemCount: _allIssues.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(index),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                _allIssues[index]['title'],
                                textAlign: TextAlign.justify,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(16),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return IssueDetails(
                                        title: _allIssues[index]['title'],
                                        status: _allIssues[index]['status'],
                                        description: _allIssues[index]
                                            ['description'],
                                        vehicle: _allIssues[index]['user']
                                            ['vehicle']['plate'],
                                        driver: _allIssues[index]['user']
                                            ['name'],
                                        contact: _allIssues[index]['user']
                                            ['phone'],
                                      );
                                    },
                                  ),
                                );
                              },
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _allIssues[index]['status'],
                                    textAlign: TextAlign.justify,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          _allIssues[index]['description'],
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
