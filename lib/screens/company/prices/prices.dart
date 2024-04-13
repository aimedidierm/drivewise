import 'dart:convert';

import 'package:drivewise/constants.dart';
import 'package:drivewise/screens/company/prices/details.dart';
import 'package:drivewise/screens/components/appbar.dart';
import 'package:drivewise/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Prices extends StatefulWidget {
  const Prices({super.key});

  @override
  State<Prices> createState() => _PricesState();
}

class _PricesState extends State<Prices> {
  bool loading = true;

  List<Map<String, dynamic>> _priceDetails = [];

  Future<void> fetchData() async {
    String token = await getToken();
    final response = await http.get(Uri.parse(adminPricesURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      final List<dynamic> decodedPrices = decodedResponse['prices'];
      final List<Map<String, dynamic>> priceDetails =
          List<Map<String, dynamic>>.from(decodedPrices);
      setState(() {
        _priceDetails = priceDetails;
        loading = false;
      });
    } else {
      // print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
                        "Fuel prices",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _priceDetails.length,
                    itemBuilder: (context, index) => Card(
                      key: ValueKey(index),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              _priceDetails[index]['name'],
                              textAlign: TextAlign.justify,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            contentPadding: const EdgeInsets.all(16),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return PriceDetails(
                                      id: _priceDetails[index]['id'].toString(),
                                      type: _priceDetails[index]['type'],
                                      price: _priceDetails[index]['price'],
                                      name: _priceDetails[index]['name'],
                                    );
                                  },
                                ),
                              );
                            },
                            subtitle: Text(
                              "${_priceDetails[index]['price']} Rwf",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
