import 'package:flutter/gestures.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:relevent/pages/reset_password.dart';
import 'package:relevent/services/firebase_auth_methods.dart';
import 'package:relevent/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:relevent/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:relevent/widgets/password_textfield.dart';

class Login extends StatefulWidget {
  static String routeName = '/login';
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  googleSignin() async {
    context.read<FirebaseAuthMethods>().signInWithGoogle(context);
  }

  void loginUser() {
    context.read<FirebaseAuthMethods>().loginWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

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
              child: Image.asset("images/login.png"),
            ),
            const Text(
              "Login",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: h * 0.01),
            Text('Please login to continue using our app'),
            SizedBox(height: h * 0.02),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              width: w,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
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
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        TextButton(
                          child: Text("Forgot Password?"),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, ResetPassword.routeName);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: loginUser,
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          Size(w / 2.5, 50),
                        ),
                      ),
                      child: const Text(
                        "Login",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RichText(
              text: TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  children: [
                    TextSpan(
                        text: "Sign Up",
                        style: TextStyle(color: Colors.teal),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushReplacementNamed(
                              context, Signup.routeName)),
                  ]),
            ),
            Column(children: [
              Text('or'),
              SignInButton(
                Buttons.Google,
                text: "Sign in with Google",
                onPressed: googleSignin,
              )
            ]),
            SizedBox(height: h * 0.02),
          ],
        ),
      ),
    );
  }
}
