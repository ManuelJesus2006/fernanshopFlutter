import 'package:flutter/material.dart';
import 'package:practica_obligatoria_tema5_fernanshop/routes/app_routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'FERNANSHOP',
      routerConfig: appRouter,
    );
  }
}
