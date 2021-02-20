import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/detail_page.dart';
import 'package:herewego/pages/home_page.dart';
import 'package:herewego/pages/signIn_page.dart';
import 'package:herewego/pages/signUp_page.dart';
import 'package:herewego/services/prefs_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget _startPage(){
      return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot){
          if(snapshot.hasData){
            Prefs.saveUserId(snapshot.data.uid);
            return HomePage();
          } else{
            Prefs.removeUserId();
            return SignInPage();
          }
        },
      );
    }


    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: _startPage(),
      routes: {
        HomePage.id:(context) => HomePage(),
        SignInPage.id:(context) => SignInPage(),
        SignUpPage.id:(context) => SignUpPage(),
        DetailPage.id:(context) => DetailPage(),
      },
    );
  }
}
