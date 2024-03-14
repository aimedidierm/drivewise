import 'package:flutter/material.dart';

class ListJourneys extends StatefulWidget {
  const ListJourneys({super.key});

  @override
  State<ListJourneys> createState() => _ListJourneysState();
}

class _ListJourneysState extends State<ListJourneys> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('All journeys'),
      ),
    );
  }
}
