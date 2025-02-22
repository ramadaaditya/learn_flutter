import 'package:flutter/material.dart';
import 'package:josresto/data/api/api_service.dart';
import 'package:josresto/provider/database_provider.dart';
import 'package:josresto/provider/nav_provider.dart';
import 'package:josresto/provider/restaurant_detail_provider.dart';
import 'package:josresto/provider/restaurant_list_provider.dart';
import 'package:josresto/provider/restaurant_search_provider.dart';
import 'package:josresto/provider/setting_provider.dart';
import 'package:josresto/screen/detail/detail_screen.dart';
import 'package:josresto/screen/favorite/favorite_screen.dart';
import 'package:josresto/screen/main/main_screen.dart';
import 'package:josresto/screen/setting/setting_screen.dart';
import 'package:josresto/services/sqlite_service.dart';
import 'package:josresto/static/navigation_route.dart';
import 'package:josresto/style/theme/restaurant_theme.dart';
import 'package:provider/provider.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
void main() {
  runApp(MultiProvider(
    providers: [
      Provider(create: (context) => ApiService()),
      Provider(
        create: (context) => SqliteService(),
      ),
      ChangeNotifierProvider(
        create: (context) => DatabaseProvider(
          context.read<SqliteService>(),
        ),
      ),
      ChangeNotifierProvider(create: (context) => SettingProvider()),
      ChangeNotifierProvider(
          create: (context) => DatabaseProvider(context.read<SqliteService>())),
      ChangeNotifierProvider(
        create: (context) => IndexNavProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => RestaurantListProvider(
          context.read<ApiService>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => RestaurantDetailProvider(
          context.read<ApiService>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => RestaurantSearchProvider(
          context.read<ApiService>(),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          theme: RestaurantTheme.lightTheme,
          darkTheme: RestaurantTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          scaffoldMessengerKey: scaffoldMessengerKey,
          initialRoute: NavigationRoute.mainRoute.name,
          routes: {
            NavigationRoute.mainRoute.name: (context) => const MainScreen(),
            NavigationRoute.detailRoute.name: (context) {
              final args = ModalRoute.of(context)?.settings.arguments;
              if (args is String) {
                return DetailScreen(restaurantId: args);
              } else {
                return const Scaffold(
                  body: Center(
                    child: Text('Invalid arguments for DetailScreen'),
                  ),
                );
              }
            },
            NavigationRoute.favoriteRoute.name: (context) =>
                const FavoriteScreen(),
            NavigationRoute.settingRoute.name: (context) =>
                const SettingScreen(),
          },
        );
      },
    );
  }
}
