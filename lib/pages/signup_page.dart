import 'package:flutter/gestures.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:relevent/services/firebase_auth_methods.dart';
import 'package:relevent/pages/login_page.dart';
import 'package:relevent/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:relevent/widgets/password_textfield.dart';

class Signup extends StatefulWidget {
  static String routeName = '/signup';
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  googleSignin() async {
    context.read<FirebaseAuthMethods>().signInWithGoogle(context);
  }

  void signUpUser() async {
    context.read<FirebaseAuthMethods>().signUpWithEmail(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width,
        h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: h * 0.04),
            Container(
                height: 60, width: 60, child: Image.asset("images/logo.png")),
            Container(
              height: h * 0.3,
              child: Image.asset("images/signup.png"),
            ),
            const Text(
              "SignUp",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: h * 0.01),
            Text('Please fill the details and create account'),
            SizedBox(height: h * 0.02),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              width: w,
              child: Form(
                child: Column(
                  children: [
                    CustomTextField(
                      controller: nameController,
                      hintText: 'Enter your name',
                      labelText: 'Name',
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: emailController,
                      hintText: 'Enter your email',
                      labelText: 'Email',
                    ),
                    SizedBox(height: 20),
                    PasswordTextField(
                      controller: passwordController,
                      hintText: 'Enter your password',
                      labelText: 'Password',
                    ),
                    SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: signUpUser,
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          Size(w / 2.5, 50),
                        ),
                      ),
                      child: const Text(
                        "Signup",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  children: [
                    TextSpan(
                        text: "Log In",
                        style: TextStyle(color: Colors.teal),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushReplacementNamed(
                              context, Login.routeName)),
                  ]),
            ),
            Column(children: [
              Text('or'),
              SignInButton(
                Buttons.Google,
                text: "Sign up with Google",
                onPressed: googleSignin,
              )
            ]),
          ],
        ),
      ),
    );
  }
}
