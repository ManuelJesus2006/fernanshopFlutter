import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/tech_product_model.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/users_model.dart';
import 'package:practica_obligatoria_tema5_fernanshop/presentation/screens/actualizacion_producto.dart';
import 'package:practica_obligatoria_tema5_fernanshop/presentation/screens/home_screen.dart';
import 'package:practica_obligatoria_tema5_fernanshop/presentation/screens/login_screen.dart';
import 'package:practica_obligatoria_tema5_fernanshop/presentation/screens/onboarding_screen.dart';
import 'package:practica_obligatoria_tema5_fernanshop/presentation/screens/product_detail.dart';
import 'package:practica_obligatoria_tema5_fernanshop/presentation/screens/settings_screen.dart';
import 'package:practica_obligatoria_tema5_fernanshop/presentation/screens/signup_screen.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/config_provider.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/users_provider.dart';

class AppRouter {
  final ConfigProvider configProvider;
  final UsersProvider usersProvider;

  AppRouter(this.configProvider, this.usersProvider);

  late final GoRouter router = GoRouter(
    initialLocation: configProvider.isPrimeraVez ? '/onboarding' : usersProvider.userLogued != null ? '/home': configProvider.enPantallaRegistro ? '/signup' : '/login',
    
    routes: [
      GoRoute(path: '/home', builder: (context, state){
        final index = state.extra == null ? 0 : state.extra as int;
        return HomeScreen(indexBottomNavigationBar: index);
      }),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) =>
            _buildTransition(state: state, child: LoginScreen()),
      ),
      GoRoute(
        path: '/signup',
        pageBuilder: (context, state) =>
            _buildTransition(state: state, child: SignupScreen()),
      ),
      GoRoute(
        path: '/detail',
        pageBuilder: (context, state) {
          final producto = state.extra as TechProduct;
          return _buildTransition(
            state: state,
            child: ProductDetail(producto: producto),
          );
        },
      ),
      GoRoute(
        path: '/settings',
        pageBuilder: (context, state) =>
            _buildTransition(state: state, child: SettingsScreen()),
      ),
      GoRoute(path: '/editarProducto',
      builder: (context,state){
        final producto = state.extra as TechProduct;
        return ActualizacionProducto(producto: producto);
      })
    ],
  );

  CustomTransitionPage _buildTransition({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 450),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Animación simple de derecha a izquierda
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeOutQuart;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
