// ignore_for_file: use_build_context_synchronously

import 'package:drivewise/constants.dart';
import 'package:drivewise/models/api_response.dart';
import 'package:drivewise/screens/components/appbar.dart';
import 'package:drivewise/services/price.dart';
import 'package:flutter/material.dart';

class PriceDetails extends StatefulWidget {
  final String id, type, price, name;
  const PriceDetails({
    Key? key,
    required this.id,
    required this.type,
    required this.price,
    required this.name,
  }) : super(key: key);

  @override
  State<PriceDetails> createState() => _PriceDetailsState();
}

class _PriceDetailsState extends State<PriceDetails> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController price = TextEditingController();

  bool loading = false;

  void updatePrice() async {
    ApiResponse response = await updatePrices(
      widget.id,
      widget.name,
      widget.type,
      price.text,
    );
    if (response.error == null) {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Details updated'),
        ),
      );
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

  @override
  void initState() {
    price.text = widget.price;
    super.initState();
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Form(
                      key: formkey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: price,
                              validator: (val) =>
                                  val!.isEmpty ? 'Price is required' : null,
                              decoration: InputDecoration(
                                labelText: '${widget.name} price (Rwf/L)',
                                contentPadding: const EdgeInsets.all(8.0),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextButton(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  updatePrice();
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
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: loading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        'Update price details',
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
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
