import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/views/map_view.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(children: [const SizedBox(height: 300,),const Text("Welcome"),const SizedBox(height: 10,),TextButton(onPressed: (){Get.to(const MyMapPage());}, child: const Text(" Tap here to view Map"))],)),
    );
  }
}