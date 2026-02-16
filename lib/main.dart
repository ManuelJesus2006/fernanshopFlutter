import 'package:flutter/material.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/config_provider.dart';
import 'package:practica_obligatoria_tema5_fernanshop/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => ConfigProvider())
      ],
      child: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final configProvider = Provider.of<ConfigProvider>(context);
    return MaterialApp.router(
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      themeMode: configProvider.temaOscuro ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'FERNANSHOP',
      routerConfig: appRouter,
    );
  }
}
