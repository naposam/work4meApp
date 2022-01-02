import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work4meartisan/pages/chooseTabs.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  String usernameId="";
  bool loading = true;
  List<dynamic> searchList = [];
  List<dynamic> userDetails = [];


  Future<dynamic> getUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('username') != null) {
      var userCheck = preferences.getString('username');
      var dataUrl = Uri.parse("https://ultdev.org/jobbackend/test.php");
      var response = await http.post(dataUrl, body: {'username': userCheck});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          userDetails = data;
        });
      }
    }
    //print(userDetails);
  }
  Future getUser()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      usernameId=preferences.getString('username');
    });
  }
  Future logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.remove('username');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChooseScreenTabs()));
  }
  Widget menuDrawer(){
    return Drawer(
      child: Material(
        // color: Color.fromRGBO(200, 150, 205, 1),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.purple, Colors.purpleAccent]),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: userDetails.length,
                  itemBuilder: (context, index) {
                    return new ListTile(
                      title: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              //child:  Icon(Icons.person,)
                              backgroundImage: NetworkImage(
                                  'https://ultdev.org/jobbackend/uploads/${userDetails[index]['picture']}'),
                            ),
                          ),
                          Text(
                            usernameId != '' ? "$usernameId" : "",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            userDetails[index]['fname'] +
                                ' ' +
                                userDetails[index]['lname'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
              },
              leading: Icon(
                Icons.home,
                color: Colors.purple,
              ),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.purple),
              ),
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: userDetails.length,
                itemBuilder: (context, i) {
                  return new ListTile(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ChangeUserPassword(
                      //           firstname: userDetails[i]['fname'],
                      //           lastname: userDetails[i]['lname'],
                      //           uid: userDetails[i]['uid'],
                      //           picture:
                      //           'https://ultdev.org/jobbackend/uploads/${userDetails[i]['picture']}',
                      //         )));
                    },
                    leading: Icon(
                      Icons.lock,
                      color: Colors.purple,
                    ),
                    title: Text(
                      "Change Password",
                      style: TextStyle(color: Colors.purple),
                    ),
                  );
                }),
            Divider(
              color: Colors.grey,
              height: 0.5,
            ),
            ListTile(
              onTap: () {
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) => ScreenTabs()));
              },
              leading: Icon(
                Icons.settings,
                color: Colors.purple,
              ),
              title: Text(
                "Settings",
                style: TextStyle(color: Colors.purple),
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 0.5,
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.share,
                color: Colors.purple,
              ),
              title: Text(
                "Share",
                style: TextStyle(color: Colors.purple),
              ),
            ),
            ListTile(
              onTap: () {
                logOut();
              },
              leading: Icon(
                Icons.lock_open,
                color: Colors.purple,
              ),
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.purple),
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 100,
            ),
          ],
        ),
      ),
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: menuDrawer(),
    );
  }
}
