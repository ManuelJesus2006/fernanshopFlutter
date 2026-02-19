import 'dart:convert';

import 'package:http/http.dart';
import 'package:practica_obligatoria_tema5_fernanshop/Env.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/tech_product_model.dart';

class TechProductService {
  Future<List<TechProduct>> getAllProducts() async {
    List<TechProduct> lista = [];
    Uri uri = Uri.parse(Env.endPointBase);
    Response response = await get(uri, headers: {'api_key': Env.apiKey});
    if (response.statusCode != 200) return lista;
    lista = techProductFromJson(response.body);
    return lista;
  }

  Future<List<TechProduct>> getProductsByQuery(String query) async {
    List<TechProduct> lista = [];
    Uri uri = Uri.parse('${Env.endPointBase}?name=$query');
    Response response = await get(uri, headers: {'api_key': Env.apiKey});
    if (response.statusCode != 200) return lista;
    lista = techProductFromJson(response.body);
    return lista;
  }

  Future<bool> actualizarProductoByID(TechProduct productoActualizado) async {
    Uri uri = Uri.parse('${Env.endPointBase}/${productoActualizado.id}');
    Map<String, dynamic> data = {
      "business": productoActualizado.business,
      "name": productoActualizado.name,
      "type": productoActualizado.type,
      "price": productoActualizado.price, 
      "imageUrl": productoActualizado.imageUrl,
      "release_date": productoActualizado.releaseDate!.toIso8601String().split('T')[0],
    };

    if (productoActualizado.characteristics != null && productoActualizado.characteristics!.hasData) {
      data["characteristics"] = productoActualizado.characteristics!.toJson();
    }

    Response response = await put(uri, headers: {"Content-Type": "application/json",'api_key':Env.apiKey}, body:jsonEncode(data));
    return response.statusCode == 200;
  }

  Future<bool> crearProducto(TechProduct productoNuevo) async {
    Uri uri = Uri.parse('${Env.endPointBase}');

    Map<String, dynamic> data = {
      "business": productoNuevo.business,
      "name": productoNuevo.name,
      "type": productoNuevo.type,
      "price": productoNuevo.price, 
      "imageUrl": productoNuevo.imageUrl,
      "release_date": productoNuevo.releaseDate!.toIso8601String().split('T')[0],
    };

    if (productoNuevo.characteristics != null && productoNuevo.characteristics!.hasData) {
      data["characteristics"] = productoNuevo.characteristics!.toJson();
    }

    Response response = await put(uri, headers: {"Content-Type": "application/json",'api_key':Env.apiKey}, body:jsonEncode(data));
    return response.statusCode == 200;
  }

  Future<bool> eliminarProducto(TechProduct producto)async{
    Uri uri = Uri.parse('${Env.endPointBase}/${producto.id}');

    Response response = await delete(uri, headers: {"Content-Type": "application/json",'api_key':Env.apiKey});
    return response.statusCode == 204;
  }
}