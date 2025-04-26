import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_app/home/home_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Set preferred orientations (optional)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: Colors.green,
        ),
        fontFamily: 'Poppins', // Make sure to add this font to your pubspec.yaml
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      // Define routes
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        // '/notifications': (context) => const NotificationsScreen(),
      },
      // Alternatively, you can use onGenerateRoute for more dynamic routing
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => const HomeScreen());
        } else if (settings.name == '/notifications') {
          // return MaterialPageRoute(builder: (context) => const NotificationsScreen());
        }
        // If route is not found, show a not found page
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Not Found')),
            body: const Center(child: Text('Page not found')),
          ),
        );
      },
    );
  }
}