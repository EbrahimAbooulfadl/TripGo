import 'package:flutter/material.dart';
import 'package:untitled/screens/a_on_boarding_screen/on_boarding_screen.dart';
import 'package:untitled/screens/favorites_screen.dart';
import 'package:untitled/screens/gmap_screen.dart';
import 'package:untitled/screens/hotels_screen.dart';
import 'package:untitled/screens/restaurants_screen.dart';
import 'package:untitled/screens/shops_screen.dart';
import 'package:untitled/styles/themes/themes.dart';
import 'screens/welcome_screen.dart';
import 'screens/c_signup_screen/signup_screen.dart';
import 'screens/b-login_screen/login_screen.dart';
import 'screens/select_service_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/landmarks_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(),
      theme: lightTheme,
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'signup_screen': (context) => SignUpScreen(),
        'signin_screen': (context) => SignInScreen(),
        'service_selection_screen': (context) => SelectServiceScreen(),
        'landmarks_screen': (context) => LandMarksScreen(),
        'restaurants_screen': (context) => RestaurantsScreen(),
        'hotels_screen': (context) => HotelsScreen(),
        'shops_screen': (context) => ShopsScreen(),
        // 'favorites_screen': (context) => FavoritesScreen()
        // 'gmap_screen': (context) => GMap()
      },
    );
  }
}
