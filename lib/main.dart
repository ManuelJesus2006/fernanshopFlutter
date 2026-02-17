import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/config_provider.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/products_provider.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/users_provider.dart';
import 'package:practica_obligatoria_tema5_fernanshop/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConfigProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider())
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
    final usersProvider = Provider.of<UsersProvider>(context);

    final appRouter = AppRouter(configProvider,usersProvider);

    return MaterialApp.router(
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      themeMode: configProvider.temaOscuro ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'FERNANSHOP',
      scrollBehavior: AppScrollBehavior(),
      routerConfig: appRouter.router,
    );
  }
}