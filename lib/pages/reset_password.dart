import 'package:flutter/material.dart';
import 'package:relevent/services/firebase_auth_methods.dart';
import 'package:relevent/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  static String routeName = '/reset';
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController emailController = TextEditingController();

  resetpass() {
    context.read<FirebaseAuthMethods>().resetPassword(
          email: emailController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width,
        h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
          ),
        ),
        title: Row(
          children: const [
            SizedBox(
              width: 10,
            ),
            Text("Forgot Password")
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: h * 0.04),
            Container(
                height: 60, width: 60, child: Image.asset("images/logo.png")),
            Container(
              height: h * 0.3,
              child: Image.asset("images/reset.png"),
            ),
            const Text(
              "Did someone forget their password?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: h * 0.02),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              width: w,
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("That's ok..."),
                    Text("Just enter the email address you've used to"),
                    Text(
                        "register with us and we we'll send you a reset link!"),
                    SizedBox(height: h * 0.02),
                    CustomTextField(
                      controller: emailController,
                      hintText: 'Enter your email',
                      labelText: 'Email',
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: resetpass,
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          Size(w / 2.5, 50),
                        ),
                      ),
                      child: const Text(
                        "Reset",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(height: h * 0.02),
          ],
        ),
      ),
    );
  }
}
