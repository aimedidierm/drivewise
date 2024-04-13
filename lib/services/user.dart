import 'dart:convert';

import 'package:drivewise/constants.dart';
import 'package:drivewise/models/api_response.dart';
import 'package:drivewise/models/user.dart';
import 'package:drivewise/services/auth.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> getUserDetails() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(settingsURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        final responseData = jsonDecode(response.body);
        final userData = responseData['user'];
        apiResponse.data = User.fromJson(userData);
        break;
      case 422:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = jsonDecode(response.body)['error'];
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<ApiResponse> updateDetails(
  String? name,
  String? email,
  String? phone,
  String? password,
) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.put(Uri.parse(settingsURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }, body: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = "User details updated";
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
