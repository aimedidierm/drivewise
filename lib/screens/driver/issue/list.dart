import 'package:flutter/material.dart';

class ListIssues extends StatefulWidget {
  const ListIssues({super.key});

  @override
  State<ListIssues> createState() => _ListIssuesState();
}

class _ListIssuesState extends State<ListIssues> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('All issues'),
      ),
    );
  }
}
