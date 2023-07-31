//import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// ignore: slash_for_doc_comments
/***
This function adds basic functionality for accessing the postgreSQL database.

For that, the postgres dart package is used. Auth files get pulled from a env file using the flutter_dotenv flutter package.

The postgreSQL Database is hosted by neon, for handling advantages.#
*/
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
