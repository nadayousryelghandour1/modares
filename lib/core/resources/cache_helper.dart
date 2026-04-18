// ignore_for_file: deprecated_member_use

// ignore: unused_import
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheHelper {
  static const storage = FlutterSecureStorage(
    iOptions:  IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    aOptions:  AndroidOptions(encryptedSharedPreferences: true)
  );

  static Future<String> getToken() async {
    return await storage.read(key: 'token') ?? "";
  }

  static Future<void> saveToken(String token) async {
    return await storage.write(key: 'token', value: token);
  }

  static Future<void> delete() async {
    return await storage.delete(key: 'token');
  }

  static Future<String> getId() async {
    return await storage.read(key: 'id') ?? "";
  }

  static Future<void> saveId(int id) async {
    return await storage.write(key: 'id', value: id.toString());
  }

  static Future<void> deleteId() async {
    return await storage.delete(key: 'id');
  }

  // static Future<List<ProductModel>> getCart() async {
  //   final data = await storage.read(key: 'cart');
  //   if (data == null || data.isEmpty) return [];
  //   final List decoded = jsonDecode(data);
  //   return decoded.map((e) => ProductModel.fromJson(e)).toList();
  // }

  // static Future<void> saveCart(List<ProductModel> items) async {
  //   final jsonList = items.map((e) => e.toJson()).toList();
  //   await storage.write(
  //     key: 'cart',
  //     value: jsonEncode(jsonList),
  //   );
  // }

  static Future<void> deleteCart() async {
    await storage.delete(key: 'cart');
  }
}