// ignore_for_file: use_build_context_synchronously

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

import 'package:drivewise/constants.dart';
import 'package:drivewise/models/api_response.dart';
import 'package:drivewise/screens/components/appbar.dart';
import 'package:drivewise/services/journey.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class AddJourney extends StatefulWidget {
  const AddJourney({super.key});

  @override
  State<AddJourney> createState() => _AddJourneyState();
}

class _AddJourneyState extends State<AddJourney> {
  bool _loading = false;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController location = TextEditingController();
  TextEditingController destination = TextEditingController();
  TextEditingController load = TextEditingController();
  double? distance;

  // String apiKey = dotenv.env['GOOGLE_MAPS_API_KEY']!;
  String apiKey = '';

  void registerJourney() async {
    ApiResponse response = await register(
      location.text,
      load.text,
      destination.text,
      distance.toString(),
    );
    if (response.error == null) {
      setState(() {
        _loading = false;
        location.text = '';
        destination.text = '';
        load.text = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Journey created'),
        ),
      );
    } else {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

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
                        "Create new journey",
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
      body: ListView(
        children: [
          const SizedBox(
            height: 40,
          ),
          Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Location is required';
                      } else {
                        return null;
                      }
                    },
                    controller: location,
                    decoration: const InputDecoration(
                      hintText: 'Enter Location',
                      labelText: 'Location',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Destination is required';
                      } else {
                        return null;
                      }
                    },
                    controller: destination,
                    decoration: const InputDecoration(
                      hintText: 'Enter destination',
                      labelText: 'Destination',
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Load is required';
                      } else {
                        return null;
                      }
                    },
                    controller: load,
                    decoration: const InputDecoration(
                      hintText: 'Enter load',
                      labelText: 'Load',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            final locationText = location.text;
                            final destinationText = destination.text;
                            final url =
                                'https://www.google.com/maps/dir/?api=1&origin=${Uri.encodeComponent(locationText)}&destination=${Uri.encodeComponent(destinationText)}&travelmode=driving';
                            _launchURL(url);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                            (states) => primaryColor,
                          ),
                          padding: MaterialStateProperty.resolveWith(
                            (states) =>
                                const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60),
                          child: Text(
                            'Map',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  TextButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        setState(() {
                          _loading = true;
                        });
                        final distanceResult = await getDistance(
                            location.text, destination.text, apiKey);
                        setState(() {
                          distance = distanceResult;
                        });
                        registerJourney();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => primaryColor,
                      ),
                      padding: MaterialStateProperty.resolveWith(
                        (states) => const EdgeInsets.symmetric(vertical: 20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: (_loading)
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Register',
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
          ),
        ],
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

  Future<double?> getDistance(
      String origin, String destination, String apiKey) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=${Uri.encodeComponent(origin)}&destinations=${Uri.encodeComponent(destination)}&key=$apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['rows'][0]['elements'][0]['status'] == 'OK') {
        final distance = data['rows'][0]['elements'][0]['distance']['value'];
        // distance is in meters
        return distance / 1000; // Convert to kilometers
      } else {
        return null;
      }
    } else {
      print('Hello');
      throw Exception('Failed to load distance');
    }
  }
}
