import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practica_obligatoria_tema5_fernanshop/models/tech_product_model.dart';
import 'package:practica_obligatoria_tema5_fernanshop/presentation/screens/home_screen.dart';
import 'package:practica_obligatoria_tema5_fernanshop/presentation/screens/login_screen.dart';
import 'package:practica_obligatoria_tema5_fernanshop/presentation/screens/onboarding_screen.dart';
import 'package:practica_obligatoria_tema5_fernanshop/presentation/screens/product_detail.dart';
import 'package:practica_obligatoria_tema5_fernanshop/presentation/screens/settings_screen.dart';
import 'package:practica_obligatoria_tema5_fernanshop/providers/config_provider.dart';
import 'package:provider/provider.dart';

final appRouter = GoRouter(
  redirect: (context, state) {
    final configProvider = Provider.of<ConfigProvider>(context);
    if (configProvider.isPrimeraVez) return '/onboarding';
    else return '/home';
  },
  routes: [
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/onboarding', builder: (context, state) => OnboardingScreen(),),
    GoRoute(path: '/login', builder: (context, state) => LoginScreen(),),
    GoRoute(
      path: '/detail',
      pageBuilder: (context, state) {
        final producto = state.extra as TechProduct;

        return CustomTransitionPage(
          key: state.pageKey,
          child: ProductDetail(producto: producto),
          transitionDuration: const Duration(
            milliseconds: 450,
          ),
          reverseTransitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutQuart,
              reverseCurve: Curves.easeInQuart,
            );

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(-0.3, 0.0),
                    ).animate(
                      CurvedAnimation(
                        parent: secondaryAnimation,
                        curve: Curves.easeOutQuart,
                      ),
                    ),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(-5, 0),
                      ),
                    ],
                  ),
                  child: child,
                ),
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: SettingsScreen(),
          transitionDuration: const Duration(
            milliseconds: 450,
          ),
          reverseTransitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutQuart,
              reverseCurve: Curves.easeInQuart,
            );

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(-0.3, 0.0),
                    ).animate(
                      CurvedAnimation(
                        parent: secondaryAnimation,
                        curve: Curves.easeOutQuart,
                      ),
                    ),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(-5, 0),
                      ),
                    ],
                  ),
                  child: child,
                ),
              ),
            );
          },
        );
      },
    ),
  ],
);
