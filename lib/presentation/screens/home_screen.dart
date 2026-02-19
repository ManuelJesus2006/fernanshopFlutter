import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/tech_product_model.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/users_model.dart';
import 'package:practica_obligatoria_tema5_fernanshop/presentation/screens/carro_productos_screen.dart';
import 'package:practica_obligatoria_tema5_fernanshop/presentation/screens/profile_screen.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/users_provider.dart';
import 'package:practica_obligatoria_tema5_fernanshop/services/tech_product_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.indexBottomNavigationBar});

  final int indexBottomNavigationBar;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int navigationBarIndex = widget.indexBottomNavigationBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: navigationBarIndex,
        children: [_principal(), ProfileScreen(),CarroProductosScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationBarIndex,
        onTap: (index) {
          setState(() {
            navigationBarIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_sharp), label: 'Carro'),
        ],
      ),
    );
  }
}

class _principal extends StatefulWidget {
  const _principal({super.key});

  @override
  State<_principal> createState() => _principalState();
}

class _principalState extends State<_principal> {
  final TextEditingController controllerSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: controllerSearch,
                  onChanged: (value) {
                    setState(() {});
                  },
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
            future: controllerSearch.text.isEmpty
                ? TechProductService().getAllProducts()
                : TechProductService().getProductsByQuery(
                    controllerSearch.text,
                  ),
            builder:
                (
                  BuildContext context,
                  AsyncSnapshot<List<TechProduct>> snapshot,
                ) {
                  return snapshot.hasData
                      ? _mostrarProductos(productos: snapshot.data!)
                      : Center(child: CircularProgressIndicator());
                },
          ),
        ],
      ),
    );
  }
}

class _mostrarProductos extends StatelessWidget {
  const _mostrarProductos({super.key, required this.productos});

  final List<TechProduct> productos;

  @override
  Widget build(BuildContext context) {
    //Medimos la pantalla (esto es para que se vea bien en web)
    final width = MediaQuery.of(context).size.width;
    int columnas = width > 900 ? 4 : 2;

    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columnas,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.7,
        ),
        itemCount: productos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => context.push('/detail', extra: productos[index]),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(15),
                      child: Image(
                        image: NetworkImage(productos[index].imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    '${productos[index].business} ${productos[index].name}',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    '${productos[index].price.toString()}€',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
