import 'package:flutter/material.dart';

class VehicleDetails extends StatefulWidget {
  const VehicleDetails({super.key});

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Vehicle Details'),
      ),
    );
  }
}
