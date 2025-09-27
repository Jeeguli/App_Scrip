import 'dart:convert';

import 'package:app_scrip_bloc/features/app_scrip_list/data/models/app_scrip_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String url = "https://jsonplaceholder.typicode.com/users";

  Future<List<AppScripModel>> fetchAppScrips() async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "User-Agent": "FlutterApp/1.0",
      },
    );

    print("status: ${response.statusCode}");

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => AppScripModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load users (code: ${response.statusCode})");
    }
  }
}
