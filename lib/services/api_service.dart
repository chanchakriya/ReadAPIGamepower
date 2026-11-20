import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/giveaway.dart';

class ApiService {
  static const String _url = 'https://www.gamerpower.com/api/giveaways';

  static Future<List<Giveaway>> fetchGiveaways() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Giveaway.fromJson(e)).toList();
    }
    throw Exception('Failed to load giveaways (${response.statusCode})');
  }
}
