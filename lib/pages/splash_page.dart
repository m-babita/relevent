import 'package:flutter/material.dart';
import 'package:relevent/pages/home_page.dart';
import 'package:relevent/pages/onboard_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    toOnboard();
  }

  toOnboard() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const AuthWrapper()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(
            height: 150,
            width: 150,
            child: Image.asset("images/logo.png")
          ),
          RichText(
            text: TextSpan(
              text:'Rel', style: TextStyle(
              color: Colors.black,
              fontSize: 24
            ), 

            children: [
              TextSpan(
                text: '\'Event', style: TextStyle(
                  color: Colors.teal
                )
              )
            ]
            ),
          )
        ]),
        ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const MyHomePage();
    }
    return const Onboard();
  }
}