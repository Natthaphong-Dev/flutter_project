import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/pages/homepage.dart'; 
import 'package:project/pages/contextPage/random.dart'; 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

      create: (context)=> MyAppState(),

      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: .fromSeed(
            seedColor: const Color.fromARGB(255, 58, 183, 162)
            ),
        ),

        home: const Homepages(),
        
        debugShowCheckedModeBanner: false,
      )
    );
  }
}
 