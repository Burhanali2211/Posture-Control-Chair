import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_strings.dart';

class ScaffoldWithNav extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNav({super.key, required this.child});

  int _locationIndex(BuildContext context) {
    final loc = GoRouterState.of(context).uri.path;
    if (loc.startsWith('/history'))   return 1;
    if (loc.startsWith('/analytics')) return 2;
    if (loc.startsWith('/settings'))  return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _locationIndex(context),
        onDestinationSelected: (i) {
          switch (i) {
            case 0: context.go('/home');
            case 1: context.go('/history');
            case 2: context.go('/analytics');
            case 3: context.go('/settings');
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined),      selectedIcon: Icon(Icons.home),            label: AppStrings.navHome),
          NavigationDestination(icon: Icon(Icons.history_outlined),   selectedIcon: Icon(Icons.history),         label: AppStrings.navHistory),
          NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart),       label: AppStrings.navAnalytics),
          NavigationDestination(icon: Icon(Icons.settings_outlined),  selectedIcon: Icon(Icons.settings),        label: AppStrings.navSettings),
        ],
      ),
    );
  }
}
