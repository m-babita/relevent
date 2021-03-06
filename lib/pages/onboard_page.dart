import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relevent/pages/login_page.dart';
import 'package:relevent/pages/signup_page.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:relevent/services/firebase_auth_methods.dart';

class Onboard extends StatefulWidget {
  static String routeName = '/onboard';
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  googleSignin() async {
    context.read<FirebaseAuthMethods>().signInWithGoogle(context);
  }

  toLogin() async {
    Navigator.pushNamed(context, Login.routeName);
  }

  toSignup() async {
    Navigator.pushNamed(context, Signup.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Center(
          // decoration: new BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              SizedBox(height: 30),
              SizedBox(
                  height: 60, width: 60, child: Image.asset("images/logo.png")),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset("images/onboard.png"),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(
                  "There's a lot happening arround you!",
                  style: TextStyle(fontSize: 30, color: Colors.teal),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(
                  "We must stay focused. We'll help you attend relevant occasions meant for you. :)",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: toLogin,
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width / 3, 50),
                      ),
                    ),
                    child: Text('LogIn'),
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  ElevatedButton(
                    onPressed: toSignup,
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width / 3, 50),
                      ),
                    ),
                    child: Text('SignUp'),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              SignInButton(
                Buttons.Google,
                text: "Sign up with Google",
                onPressed: googleSignin,
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    ));
  }
}
