import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work4meartisan/components/DashboardScreenTabs.dart';
import 'package:work4meartisan/pages/chooseTabs.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  var username = preferences.getString('username');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.purpleAccent,
        accentColor: Colors.purple
    ),
    home: username == null ? ChooseScreenTabs():DashBoardScreen(),
  ));
}



