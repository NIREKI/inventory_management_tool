import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

// ignore: slash_for_doc_comments
/***
This function adds basic functionality for using an API (https://github.com/NIREKI/inventory_database_api)
that returns the database querys as JSON strings. This removes the database requests from the clients and thus makes the 
application more dynamic and safe. By this, the application code also gets cleaner.
*/
Future<List<dynamic>> getDatabase() async {
  var response = await getDB().timeout(const Duration(seconds: 5));
  print(response.statusCode);
  print(response.body);
  return json.decode(response.body);
}

Future<http.Response> getDB() {
  var httpResponse = http.get(Uri.parse('http://localhost:8080/test'));
  return httpResponse;
}
