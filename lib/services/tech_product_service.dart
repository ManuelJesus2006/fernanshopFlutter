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
}
