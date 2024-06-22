import 'package:flutter/material.dart';
import 'package:drivewise/constants.dart';
import 'package:drivewise/screens/components/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class JourneyDetails extends StatefulWidget {
  final String location, destination, distance;
  const JourneyDetails({
    Key? key,
    required this.location,
    required this.destination,
    required this.distance,
  }) : super(key: key);

  @override
  State<JourneyDetails> createState() => _JourneyDetailsState();
}

class _JourneyDetailsState extends State<JourneyDetails> {
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
                        "Journey details",
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'From: ${widget.location}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'To: ${widget.destination}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '${widget.distance} KM',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                final locationText = widget.location;
                final destinationText = widget.destination;
                final url =
                    'https://www.google.com/maps/dir/?api=1&origin=${Uri.encodeComponent(locationText)}&destination=${Uri.encodeComponent(destinationText)}&travelmode=driving';
                _launchURL(url);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                  (states) => primaryColor,
                ),
                padding: MaterialStateProperty.resolveWith(
                  (states) => const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: Text(
                  'Start',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
