import 'package:go_router/go_router.dart';
import 'package:rest_app_movil/src/views/home_screens/home_screen.dart';
import 'package:rest_app_movil/src/views/page404.dart';

class AppRouter {
  static GoRouter routerConfig = GoRouter(
    initialLocation: '/home', // Puedes cambiar a la ruta inicial que prefieras
    routes: [
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) =>
            const HomeScreen(), // Aquí pones tu pantalla Home
      ),
      // GoRoute(
      //   path: '/menu',
      //   name: 'menu',
      //   builder: (context, state) =>
      //       const MenuScreen(), // Aquí pones tu pantalla Menu
      // ),
      // GoRoute(
      //   path: '/ventas',
      //   name: 'ventas',
      //   builder: (context, state) =>
      //       const SalesScreen(), // Aquí pones tu pantalla de Ventas
      //   routes: [
      //     GoRoute(
      //       path: 'details/:saleId',
      //       name: 'sale-details',
      //       builder: (context, state) => SalesDetailScreen(
      //         saleId: state.pathParameters['saleId']!,
      //       ),
      //     ),
      //   ],
      // ),
      // GoRoute(
      //   path: '/login',
      //   builder: (context, state) => const LoginScreen(),
      //   routes: [
      //     // Aquí mantienes el resto de las rutas
      //   ],
      // ),
      // Otros GoRoutes...
    ],
    errorBuilder: (context, state) =>
        const NotFoundScreen(), // Pantalla para manejar errores de ruta
  );
}
