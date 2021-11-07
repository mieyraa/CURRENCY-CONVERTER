import 'dart:async';
import 'package:currency_converter_app/convert.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({ Key? key }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState(){
      super.initState();
      Timer(
        const Duration(seconds: 3),
             () => Navigator.pushReplacement(context, 
             MaterialPageRoute(builder: (content) => const ConvertPage()))
      );
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212936),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                  const Text("SYHRSKR.CO",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.blue)),
                  const SizedBox(height: 50,),    
                  Image.asset('assets/images/rate4.png', scale: 2,),
                  const SizedBox(height: 10,),
                  const Text("CURRENCY CONVERTER",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ),
        )
    ),
    );
  }
}

