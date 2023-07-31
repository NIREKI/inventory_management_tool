//import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> getDatabase() async {
  await dotenv.load(fileName: ".env");
  var connection = PostgreSQLConnection(
      "ep-blue-snowflake-14769344.eu-central-1.aws.neon.tech",
      5432,
      "inventoryDB",
      username: "flutter",
      password: dotenv.env["POSTGRE_PASS"],
      useSSL: true);
  await connection.open();
  print("connection opened");
  List<Map<String, Map<String, dynamic>>> results =
      await connection.mappedResultsQuery("SELECT * FROM users");
  for (final result in results) {
    print(result);
  }
  connection.close();
}
