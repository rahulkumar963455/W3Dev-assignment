import 'package:flutter/material.dart';
import 'package:my_assignmentt/providers/user_provider.dart';
import 'package:my_assignmentt/screens/home_screen.dart';
import 'package:my_assignmentt/screens/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_assignmentt/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()..fetchUsers()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Removes the debug banner
        title: 'Flutter Demo',
        home: SplashScreen()
      ),
    );
  }
}
