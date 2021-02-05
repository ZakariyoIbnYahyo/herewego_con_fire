import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/home_page.dart';
import 'package:herewego/pages/signIn_page.dart';
import 'package:herewego/services/auth_service.dart';
import 'package:herewego/services/prefs_service.dart';
import 'package:herewego/services/utils_service.dart';

class SignUpPage extends StatefulWidget {
  static final String id = "signUp_page";
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var isLoad = false;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var pwController = TextEditingController();

  _doSignUp(){
    String name = nameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = pwController.text.toString().trim();
    if(name.isEmpty || email.isEmpty || password.isEmpty) return;


    setState(() {
      isLoad = true;
    });
    AuthService.signUpUser(context, name, email, password).then((firebaseUser) => {
      _getFirebaseUser(firebaseUser),
    });

  }
  
  _getFirebaseUser(FirebaseUser firebaseUser)async{
    setState(() {
      isLoad = true;
    });
    if(firebaseUser != null){
      Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    }else{
      Utils.fireToast("Check your informations");
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
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Name",
                    ),
                  ),
                  SizedBox(height: 10,),
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
                      child: Text("Sing Up", style: TextStyle(color: Colors.white),),
                      onPressed: (){
                        _doSignUp();
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Already have an account?"),
                      SizedBox(width: 5,),
                      GestureDetector(
                        child: Text("Sign In", style: TextStyle(color: Colors.red, fontSize: 18),),
                        onTap: (){
                          Navigator.pushNamed(context, SignInPage.id);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),

            isLoad ?
            Center(
              child: CircularProgressIndicator(),
            ) : SizedBox.shrink(),
          ],
        )
    );
  }
}
