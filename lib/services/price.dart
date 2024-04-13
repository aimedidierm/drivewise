import 'dart:convert';

import 'package:drivewise/constants.dart';
import 'package:drivewise/models/api_response.dart';
import 'package:drivewise/services/auth.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> updatePrices(
  String? id,
  String? name,
  String? type,
  String? price,
) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.put(Uri.parse('$adminPricesURL/$id'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'name': name,
      'type': type,
      'price': price,
    });
    print(response.body);
    switch (response.statusCode) {
      case 200:
        apiResponse.data = "Price details updated";
        break;
      case 401:
        final errors = jsonDecode(response.body)['error'];
        apiResponse.error = errors;
        break;
      case 422:
        final errors = jsonDecode(response.body)['message'];
        apiResponse.error = errors;
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 404:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}
