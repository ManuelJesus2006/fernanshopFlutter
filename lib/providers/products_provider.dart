import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/tech_product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsProvider with ChangeNotifier {
  List<TechProduct> productosEnCarro = [];

  ProductsProvider() {
    _cargarProductosCarro();
  }

  void aniadirProductoCarro(TechProduct product) async {
    productosEnCarro.add(product);
    final listaDeMapas = productosEnCarro
        .map((producto) => producto.toJson())
        .toList();
    String jsonCarro = jsonEncode(listaDeMapas);
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('carro', jsonCarro);
    notifyListeners();
  }

  void _cargarProductosCarro() async {
    final preferences = await SharedPreferences.getInstance();
    String? jsonCarro = preferences.getString('carro');
    if (jsonCarro != null) {
      List<dynamic> listaJsonCarro = jsonDecode(jsonCarro);
      List<TechProduct> carroLista = listaJsonCarro
          .map((item) => TechProduct.fromJson(item))
          .toList();
      productosEnCarro = carroLista;
    }
    notifyListeners();
  }

  calcularPrecioTotal() {
    double precioTotal = 0;
    productosEnCarro.forEach((p) {
      precioTotal += p.price;
    });
    return precioTotal.toStringAsFixed(2);
  }

  void eliminarProductoCarroIndex(int index) {
    productosEnCarro.removeAt(index);
    notifyListeners();
  }
}
