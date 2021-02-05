import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/home_page.dart';
import 'package:herewego/pages/signUp_page.dart';
import 'package:herewego/services/auth_service.dart';
import 'package:herewego/services/prefs_service.dart';
import 'package:herewego/services/utils_service.dart';

class SignInPage extends StatefulWidget {
  static final String id = "signIn_page";
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  var isLoad = false;

  var emailController = TextEditingController();
  var pwController = TextEditingController();

  _doSignIn(){
    String email = emailController.text.toString().trim();
    String password = pwController.text.toString().trim();
    if(email.isEmpty || password.isEmpty) return;

    setState(() {
      isLoad = true;
    });
    AuthService.signInUser(context, email, password).then((firebaseuser) => {
      _getFirebaseUser(firebaseuser),
    });
  }

  _getFirebaseUser(FirebaseUser firebaseUser)async{
    setState(() {
      isLoad = false;
    });

    if(firebaseUser != null){
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushNamed(context, HomePage.id);
    }else{
      Utils.fireToast("Check your email or password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: pwController,
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: FlatButton(
                      color: Colors.red,
                      child: Text("Sing In", style: TextStyle(color: Colors.white),),
                      onPressed: (){
                        _doSignIn();
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Don't have an account?"),
                      SizedBox(width: 5,),
                      GestureDetector(
                        child: Text("Sign Up", style: TextStyle(color: Colors.red, fontSize: 20),),
                        onTap: (){
                          Navigator.pushNamed(context, SignUpPage.id);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            isLoad ?
            Center(
              child:  CircularProgressIndicator(),
            ): SizedBox.shrink()
          ],
        )
    );
  }
}
