import 'dart:convert';

import 'package:ecommerce_app_bloc/models/product.dart';
import 'package:http/http.dart';

class StoreRepository{
  final String _client = 'https://fakestoreapi.com/products';

  Future<List<Product>>getProduct() async {
    Response response = await get(Uri.parse(_client));
    if(response.statusCode == 200){
      final List result = jsonDecode(response.body);
      return result.map((e) => Product.fromMap(e)).toList();
    }else{
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Product>> getMenClothing() async {
    List<Product> products = await getProduct();
    List<Product> menClothing = products.where((product) => product.category == "men's clothing").toList();
    return menClothing;
  }

  Future<List<Product>> getWomenClothing() async {
    List<Product> products = await getProduct();
    List<Product> menClothing = products.where((product) => product.category == "women's clothing").toList();
    return menClothing;
  }

  Future<List<Product>> getJewelry() async {
    List<Product> products = await getProduct();
    List<Product> menClothing = products.where((product) => product.category == "jewelery").toList();
    return menClothing;
  }

  Future<List<Product>> getElectronics() async {
    List<Product> products = await getProduct();
    List<Product> menClothing = products.where((product) => product.category == "electronics").toList();
    return menClothing;
  }
}
