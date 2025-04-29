import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TLocalStorage {
  static Future<bool> saveData(String key, dynamic data) async {
    try {
      final box = Hive.box('favourite_items_box');
      box.put(key, data);
      return true;
    } catch (e) {
      debugPrint('Error saving data: $e');
      return false;
    }
  }

  static dynamic getData(String key) {
    try {
      final box = Hive.box('favourite_items_box');
      final data = box.get(key);

      return data;
    } catch (e) {
      debugPrint('Error getting data: $e');
    }
  }

  static void removeData(String key) async {
    try {
      final box = Hive.box('favourite_items_box');
      box.delete(key);
    } catch (e) {
      debugPrint('Error removing data: $e');
    }
  }
}
