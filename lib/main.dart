import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'screens/dashboard_screen.dart';
import 'screens/wine_list_screen.dart';
import 'screens/wine_detail_screen.dart';
import 'widgets/adaptive_navigation_shell.dart';
import 'theme/app_theme.dart';
import 'providers/wine_provider.dart';
import 'providers/cellar_provider.dart';
import 'services/api_client.dart';
import 'widgets/adaptive_navigation_shell.dart' show NavigationItem;

void main() {
  runApp(const GlouApp());
}

class GlouApp extends StatelessWidget {
  const GlouApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiClient>(create: (_) => ApiClient()),
        ChangeNotifierProvider(
          create: (context) => WineProvider(
            apiClient: context.read<ApiClient>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => CellarProvider(
            apiClient: context.read<ApiClient>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Glou - Wine Cellar Management',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: _router,
        localizationsDelegates: const [
          // Add localization delegates if needed
        ],
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    // Root redirect to dashboard
    GoRoute(
      path: '/',
      redirect: (context, state) => '/dashboard',
    ),
    // Main shell route with adaptive navigation
    ShellRoute(
      builder: (context, state, child) {
        // Determine selected index based on current route
        int selectedIndex = 0;
        if (state.matchedLocation.startsWith('/wines')) {
          selectedIndex = 1;
        }
        
        return AdaptiveNavigationShell(
          selectedIndex: selectedIndex,
          onNavigationIndexChange: (index) {
            switch (index) {
              case 0:
                context.go('/dashboard');
                break;
              case 1:
                context.go('/wines');
                break;
            }
          },
          items: const [
            NavigationItem(
              icon: Icons.dashboard_outlined,
              selectedIcon: Icons.dashboard,
              label: 'Dashboard',
            ),
            NavigationItem(
              icon: Icons.wine_bar_outlined,
              selectedIcon: Icons.wine_bar,
              label: 'Wines',
            ),
          ],
          body: child,
        );
      },
      routes: [
        // Dashboard route
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        // Wines list route
        GoRoute(
          path: '/wines',
          builder: (context, state) => const WineListScreen(),
          routes: [
            // Wine detail route
            GoRoute(
              path: ':wineId',
              builder: (context, state) {
                final wineId = state.pathParameters['wineId']!;
                return WineDetailScreen(wineId: wineId);
              },
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Erreur')),
    body: Center(
      child: Text('Page non trouvée: ${state.uri}'),
    ),
  ),
);

