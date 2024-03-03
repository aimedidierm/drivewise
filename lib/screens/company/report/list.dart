import 'package:flutter/material.dart';

class ListReports extends StatefulWidget {
  const ListReports({super.key});

  @override
  State<ListReports> createState() => _ListReportsState();
}

class _ListReportsState extends State<ListReports> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Reports list'),
      ),
    );
  }
}
