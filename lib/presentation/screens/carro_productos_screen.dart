import 'package:flutter/material.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/tech_product_model.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/products_provider.dart';
import 'package:provider/provider.dart';

class CarroProductosScreen extends StatelessWidget {
  const CarroProductosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productosProvider = Provider.of<ProductsProvider>(context);
    
    //Detectamos si es modo oscuro para ajustar colores de fondo
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? null : Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Tu Carrito 🛒',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: isDark ? Colors.grey[800]: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.orange[800], size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '⚠️ Atención: Este carro NO se guarda en tu cuenta, pero sí se guardará en tu almacenamiento interno',
                    style: TextStyle(
                      color: Colors.orange[900],
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //Lista de productos
          Expanded(
            child: productosProvider.productosEnCarro.isEmpty 
            ? Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[400]),
                  SizedBox(height: 10),
                  Text("Tu carro está vacío", style: TextStyle(color: Colors.grey))
                ],
              ))
            : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: productosProvider.productosEnCarro.length,
              itemBuilder: (context, index) {
                final TechProduct productoActual = productosProvider.productosEnCarro[index];
                
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Nombre del producto
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productoActual.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        // Precio
                        const SizedBox(width: 16),
                        Text(
                          '${productoActual.price.toStringAsFixed(2)}€',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white: Colors.indigo,
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(onPressed: () {
                          productosProvider.eliminarProductoCarroIndex(index);
                        }, icon: Icon(Icons.delete, color: Colors.red,))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          //Total
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[850] : Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -5),
                  blurRadius: 20,
                )
              ],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total a pagar:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${productosProvider.calcularPrecioTotal()}€', 
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white: Colors.indigo,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}