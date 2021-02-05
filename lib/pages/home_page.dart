import 'package:flutter/material.dart';
import 'package:herewego/pages/signIn_page.dart';

class HomePage extends StatefulWidget {
  static final String id = "home_page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
      ),
      body: Center(
        child: FlatButton(
          onPressed: (){
            Navigator.pushNamed(context, SignInPage.id);
          },
          child: Text("Log Out", style:  TextStyle(color: Colors.white),),
          color: Colors.deepOrange,
        ),
      ),
    );
  }
}
