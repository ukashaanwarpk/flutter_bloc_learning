import 'dart:convert';

import 'package:flutter/material.dart';
import '../model/get_model.dart';
import 'package:http/http.dart' as http;

class GetRepository {
  Future<List<GetModel>> getApiData() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));

      if (response.statusCode == 200) {
        final body = json.decode(response.body.toString());
        return body.map<GetModel>((e) => GetModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint('The error in getApiData $e');
      throw 'Somethign went wrong, Try again later';
    }
  }
}
