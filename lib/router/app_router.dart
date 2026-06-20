import 'package:go_router/go_router.dart';
import '../features/splash/splash_screen.dart';
import '../features/home/home_screen.dart';
import '../features/history/history_screen.dart';
import '../features/analytics/analytics_screen.dart';
import '../features/settings/settings_screen.dart';
import '../widgets/scaffold_with_nav.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => ScaffoldWithNav(child: child),
      routes: [
        GoRoute(path: '/home',      builder: (context, state) => const HomeScreen()),
        GoRoute(path: '/history',   builder: (context, state) => const HistoryScreen()),
        GoRoute(path: '/analytics', builder: (context, state) => const AnalyticsScreen()),
        GoRoute(path: '/settings',  builder: (context, state) => const SettingsScreen()),
      ],
    ),
  ],
);
