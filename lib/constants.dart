import 'package:flutter/material.dart';

//Endpoints
const baseURL = 'http://localhost/api';
const loginURL = '$baseURL/auth/login';

//Errors
const serverError = 'Internel server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong';

Color primaryColor = const Color(0xFF8155ff);
MaterialColor themeColor = const MaterialColor(0xFF8155ff, {
  50: Color(0xFFE6D7FF),
  100: Color(0xFFC3A8FF),
  200: Color(0xFFA37AFF),
  300: Color(0xFF824CFF),
  400: Color(0xFF6B29FF),
  500: Color(0xFF8155ff),
  600: Color(0xFF5D26FF),
  700: Color(0xFF4C00FF),
  800: Color(0xFF3B00D1),
  900: Color(0xFF2B0096),
});
