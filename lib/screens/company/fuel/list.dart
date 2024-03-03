import 'package:flutter/material.dart';

class FuelList extends StatefulWidget {
  const FuelList({super.key});

  @override
  State<FuelList> createState() => _FuelListState();
}

class _FuelListState extends State<FuelList> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Fuel list'),
      ),
    );
  }
}
