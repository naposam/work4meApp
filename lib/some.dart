

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("main Page"),
        centerTitle: true,

      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},
        child: Icon(Icons.add_circle_outline),),
    );
  }
}
