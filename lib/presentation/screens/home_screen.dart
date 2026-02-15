import 'package:flutter/material.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/tech_product_model.dart';
import 'package:practica_obligatoria_tema5_fernanshop/services/tech_product_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controllerSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                Expanded(
                  child: TextField(
                    controller: controllerSearch,
                    style: TextStyle(color: Colors.grey[600]),
                    decoration: const InputDecoration(
                      hintText: 'Busque un producto...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  color: Colors.indigo,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'FERNANSHOP',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 10),
            Divider(thickness: 2, color: Colors.grey[800]),
            FutureBuilder(
              future: TechProductService().getAllProducts(), 
              builder: (BuildContext context, AsyncSnapshot<List<TechProduct>> snapshot){
                return snapshot.hasData ? _mostrarProductos(productos: snapshot.data!,) : Center(child: CircularProgressIndicator());
              }
            )
          ],
        ),
      ),
    );
  }
}

class _mostrarProductos extends StatelessWidget {
  const _mostrarProductos({super.key, required this.productos});

  final List<TechProduct> productos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: gridDelegate, 
      itemBuilder: itemBuilder
    )
  }
}
