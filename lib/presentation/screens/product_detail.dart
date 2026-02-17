import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/tech_product_model.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/config_provider.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.producto});

  final TechProduct producto;

  @override
  Widget build(BuildContext context) {
    final configProvider = Provider.of<ConfigProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.arrow_back),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              producto.imageUrl,
                              width: 200,
                              height: 200,
                              fit: BoxFit.fill,
                            ),
                          ),

                          SizedBox(width: 20),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${producto.business} ${producto.name}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${producto.price.toString()}€',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          productsProvider.aniadirProductoCarro(producto);
                          ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Se ha insertado el producto con éxito'),
                                action: SnackBarAction(label: 'Ver en el carro', onPressed: () {context.push('/home',extra: 2);}),
                                duration: const Duration(seconds: 2),),
                                
                              );
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[600]
                              : Colors.indigo,
                        ),
                        child: Text(
                          'Añadir al carrito🛒',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
