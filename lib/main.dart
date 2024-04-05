import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/screens/AddressSearchScreen.dart';
import 'package:testapp/controllers/ApiController.dart';

void main() {
  runApp(MaterialApp(
    home: AddressSearchScreen(),
  ));
}

