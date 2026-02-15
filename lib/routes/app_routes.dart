import 'package:go_router/go_router.dart';
import 'package:practica_obligatoria_tema5_fernanshop/presentation/screens/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(path: '/home',builder: (context,state) => HomeScreen())
  ]
);