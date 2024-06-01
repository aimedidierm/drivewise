import 'dart:convert';

import 'package:drivewise/constants.dart';
import 'package:drivewise/models/api_response.dart';
import 'package:drivewise/services/auth.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> register(
  String? name,
  String? plate,
  String? load,
  String? fuel,
  String? fuelType,
  String? groupId,
  String? userId,
) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse(adminVehiclesURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'name': name,
      'plate': plate,
      'load': load,
      'fuel': fuel,
      'fuel_type': fuelType,
      'group_id': groupId,
      'user_id': userId
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = "Driver registered";
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
