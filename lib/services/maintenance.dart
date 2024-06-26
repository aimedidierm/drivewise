import 'dart:convert';

import 'package:drivewise/constants.dart';
import 'package:drivewise/models/api_response.dart';
import 'package:drivewise/services/auth.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> register(
  String? title,
  String? nofication,
  String? date1,
  String? date2,
  String? date3,
  String? vehicle,
) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(adminMaintenancesURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'title': title,
      'notification': nofication,
      'date1': date1,
      'date2': date2,
      'date3': date3,
      'vehicle_id': vehicle,
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = "Maintenance registered";
        break;
      case 401:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 422:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 500:
        apiResponse.error = serverError;
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
