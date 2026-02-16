import 'package:flutter/material.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/config_provider.dart';
import 'package:practica_obligatoria_tema5_fernanshop/routes/app_routes.dart'; // Asegúrate de que este import apunte a tu archivo de rutas
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
        // Aquí puedes añadir tus otros providers (AuthProvider, MoviesProvider, etc.)
        ChangeNotifierProvider(create: (_) => ConfigProvider()),
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

    final appRouter = AppRouter(configProvider);

    return MaterialApp.router(
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      themeMode: configProvider.temaOscuro ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'FERNANSHOP',
      routerConfig: appRouter.router,
    );
  }
}