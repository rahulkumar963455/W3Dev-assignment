import 'package:flutter/material.dart';
import 'package:my_assignmentt/providers/user_provider.dart';
import 'package:my_assignmentt/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main()async{
  try{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }catch(e){
    print(e.toString());
  }
  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider()..fetchUsers(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SplashScreen()
    );
  }
}

