import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_learning/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<List<ProductModel>> getProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse
            .map<ProductModel>((e) => ProductModel.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint('The error in getProduct $e ');
      throw 'Something went wrong, Try again later';
    }
  }
}
