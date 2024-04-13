import 'package:drivewise/constants.dart';
import 'package:drivewise/screens/components/appbar.dart';
import 'package:flutter/material.dart';

class DriverDetails extends StatefulWidget {
  final String name, email, phone, vehicle, group;
  const DriverDetails({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
    required this.vehicle,
    required this.group,
  }) : super(key: key);

  @override
  State<DriverDetails> createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {
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
                        "Driver Details",
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
                  'Name: ',
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
            Row(
              children: [
                const Text(
                  'Email: ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  widget.email,
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
                  'Phone: ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  widget.phone,
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
                  'Vehicle plate: ',
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
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  'Vehicle group: ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  widget.group,
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
