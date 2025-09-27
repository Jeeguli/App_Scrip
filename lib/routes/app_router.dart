import 'package:app_scrip_bloc/features/app_scrip_list/presentation/pages/app_scrip_pages.dart';
import 'package:app_scrip_bloc/features/app_scrip_list/presentation/pages/user_details.dart';
import 'package:app_scrip_bloc/routes/app_routes_string.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutesString.appScripScreen,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: AppRoutesString.appScripScreen,
      builder: (context, state) {
        return AppScripScreen();
      },
    ),
    GoRoute(
      path: AppRoutesString.userDetailsScreen,
      builder: (context, state) {
        return UserDetailsScreen();
      },
    ),
  ],
);
