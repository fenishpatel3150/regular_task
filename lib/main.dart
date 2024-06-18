import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:regular_task/screen/provider/Json/jsonProvider.dart';
import 'package:regular_task/screen/provider/second/HomeProvider.dart';
import 'package:regular_task/screen/view/home/HomeScreen.dart';
import 'package:regular_task/screen/view/second/SecondScreen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => JsonProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => HomeProvider(),
    ),
  ],
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/url',
      routes: {
      //  '/home':(context)=>AlbumScreen(),
        '/url':(context)=>UrlScreen(),
      },
    );
  }
}
