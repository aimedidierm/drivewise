import 'package:drivewise/constants.dart';
import 'package:flutter/material.dart';

class MaintenanceDetails extends StatefulWidget {
  const MaintenanceDetails({super.key});

  @override
  State<MaintenanceDetails> createState() => _MaintenanceDetailsState();
}

class _MaintenanceDetailsState extends State<MaintenanceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: const [
            Row(
              children: [
                Text(
                  'Title: ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Oil changing',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Notification: ',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Attention vehicle owners! It's time to give your car some TLC. Don't forget to schedule your oil change appointment. Keeping your oil fresh is crucial for maintaining your vehicle's performance and longevity. Book now to ensure smooth rides ahead. Remember, regular oil changes are essential for keeping your engine running smoothly and avoiding costly repairs down the road. Don't delay, schedule your appointment today!",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Period: ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  '1 month',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Vehicle: ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'RAA 000 A',
                  style: TextStyle(
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
