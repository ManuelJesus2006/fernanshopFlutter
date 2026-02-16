import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/config_provider.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController _controllerPageView = PageController();

  @override
  Widget build(BuildContext context) {
    final configProvider = Provider.of<ConfigProvider>(context);
    return Scaffold(
      backgroundColor:
          Colors.grey[50], // Fondo gris clarito para que resalte la tarjeta
      body: SafeArea(
        child: PageView(
          controller: _controllerPageView,
          scrollDirection: Axis.horizontal,
          children: [
            //Pagina 1
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.black, Colors.indigo],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(
                    30,
                  ), // Bordes redondeados de la tarjeta
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icono decorativo arriba
                    const Icon(
                      Icons.shopping_bag_outlined,
                      size: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 40),
                    Container(
                      color: Colors.indigo,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'FERNANSHOP',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Textos de abajo
                    const Text(
                      'Bienvenido a FernanShop',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Donde encontrarás MILES de productos tecnológicos al mejor precio.',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            //Pagina 2
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.indigo, Colors.orange],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(
                    30,
                  ), // Bordes redondeados de la tarjeta
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icono decorativo arriba
                    const Icon(Icons.euro, size: 100, color: Colors.white),

                    const SizedBox(height: 30),

                    // Textos de abajo
                    const Text(
                      'Precios de locos',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Apto para todas las personas',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            //Pagina 3
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.indigo.shade900, Colors.indigo.shade500],
                  ),
                  borderRadius: BorderRadius.circular(
                    30,
                  ), // Bordes redondeados de la tarjeta
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icono decorativo arriba
                    const Icon(
                      Icons.add_moderator_outlined,
                      size: 100,
                      color: Colors.white,
                    ),

                    const SizedBox(height: 30),

                    // Textos de abajo
                    const Text(
                      'Equipado para administradores',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Posibilidad de cambiar productos de forma simple desde la misma app',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            //Pagina 3
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.orange.shade400, // Empieza brillante
                      Colors.deepOrange.shade600, // Termina intenso
                    ],
                  ),
                  borderRadius: BorderRadius.circular(
                    30,
                  ), // Bordes redondeados de la tarjeta
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icono decorativo arriba
                    const Icon(
                      Icons.shopping_cart,
                      size: 100,
                      color: Colors.white,
                    ),

                    const SizedBox(height: 30),

                    // Textos de abajo
                    const Text(
                      '¿A que estás esperando?',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Inicia sesión y...¡compra sin parar!',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        configProvider.confirmarPrimeraVez();
                        context.push('/home');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ), // Cambia el 20 por el radio que quieras
                        ),
                      ),
                      child: Text(
                        'Iniciar sesión',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
