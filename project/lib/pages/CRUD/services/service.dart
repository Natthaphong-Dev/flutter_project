import 'dart:convert';

import 'package:project/pages/CRUD/models/products.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String baseURL = 'http://127.0.0.1:8001';

  //get data
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseURL/products'));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    }
    throw Exception("fail to load data");
  }

  //post data
  Future<Product> createProduct({
    required String name,
    required double price,
    required int quantity,
  }) async {
    final response = await http.post(
      Uri.parse('$baseURL/products'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'price': price, 'quantity': quantity}),
    );
    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    }
    throw Exception('fail to sent data');
  }

  //put data
  Future<Product> updateProdcut({
    required int id,
    required String name,
    required double price,
    required int quantity,
  }) async {
    final response = await http.post(
      Uri.parse('$baseURL/products/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'price': price, 'quantity': quantity}),
    );
    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    }
    throw Exception('fail to update');
  }

  //delete data
  Future<void> deleteProdcut(int id) async {
    final response = await http.delete(Uri.parse('$baseURL/products/$id'));
    if (response.statusCode != 200) {
      throw Exception('fail to delete');
    }
  }
}
