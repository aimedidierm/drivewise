import 'package:flutter/material.dart';

class ListFuel extends StatefulWidget {
  const ListFuel({super.key});

  @override
  State<ListFuel> createState() => _ListFuelState();
}

class _ListFuelState extends State<ListFuel> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('All fuel refillings'),
      ),
    );
  }
}
