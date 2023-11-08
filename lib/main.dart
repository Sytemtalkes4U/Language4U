import 'package:firebase_core/firebase_core.dart';
import 'package:ing/Pages/HomePage.dart';
import 'package:ing/Pages/Login.dart';
import 'package:flutter/material.dart';
//import 'package:ing/Pages/Home_Pagee.dart';
//import 'package:ing/Pages/game/game.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      //home: const Videos(),
      routes: {
        'home': (context) => HomePage(),
       // 'game': (context) => Game(),

      },
    );
  }
}

