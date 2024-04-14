import 'package:drivewise/constants.dart';
import 'package:drivewise/screens/components/appbar.dart';
import 'package:flutter/material.dart';

class MaintenanceDetails extends StatefulWidget {
  final String name, description, unit, interval, vehicle;
  const MaintenanceDetails({
    Key? key,
    required this.name,
    required this.description,
    required this.unit,
    required this.interval,
    required this.vehicle,
  }) : super(key: key);

  @override
  State<MaintenanceDetails> createState() => _MaintenanceDetailsState();
}

class _MaintenanceDetailsState extends State<MaintenanceDetails> {
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
                        "Maintenance Details",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            Row(
              children: [
                const Text(
                  'Title: ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Notification: ',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              widget.description,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  'Period: ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Every ${widget.interval} ${widget.unit}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  'Vehicle: ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  widget.vehicle,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
