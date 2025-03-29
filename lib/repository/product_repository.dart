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
        final List<ProductModel> products = jsonResponse
            .map<ProductModel>((e) => ProductModel.fromJson(e))
            .toList();

        products.sort((a, b) => a.title!.compareTo(b.title!));

        return products;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e, stackTrace) {
      debugPrint('The error in getProduct $e $stackTrace');
      throw 'Something went wrong, Try again later';
    }
  }
}
