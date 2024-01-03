import 'package:go_router/go_router.dart';
import 'package:noteme/src/app.dart';
import 'package:noteme/src/config/navigation/navigation_routes.dart';
import 'package:noteme/src/ui/screens/main_holder.dart';

final router = GoRouter(
    routes: [
      GoRoute(
        path: routes.home,
        builder:(context, state) {
          return MainHolder();
        }
      ),
    ]

);