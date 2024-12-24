import 'package:ecommerce_app_ui/components/costum_navigation_bar.dart';
import 'package:ecommerce_app_ui/routes.dart';
import 'package:ecommerce_app_ui/screens/splash/splash_screen.dart';
import 'package:ecommerce_app_ui/state_managements/auth_provider.dart';
import 'package:ecommerce_app_ui/state_managements/cart_provider.dart';
import 'package:ecommerce_app_ui/state_managements/favorite_provider.dart';
import 'package:ecommerce_app_ui/state_managements/theme_provider.dart';
import 'package:ecommerce_app_ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => CartProvider()),
    ChangeNotifierProvider(create: (context) => FavoriteProvider()),
  ], child: MainApp(isLoggedIn: isLoggedIn)));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, theme, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: isLoggedIn ? CustomNavigationBar.routeName : SplashScreen.routeName,
          theme: themeData(theme.isDarkMode),
          routes: routes,
        );
      },
    );
  }
}
