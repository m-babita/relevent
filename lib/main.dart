import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:relevent/pages/bottom_nav.dart';
import 'package:relevent/pages/create_event.dart';
import 'package:relevent/pages/feedback_dialog.dart';
import 'package:relevent/pages/home_page.dart';
import 'package:relevent/pages/profile_page.dart';
import 'package:relevent/pages/reset_password.dart';
import 'package:relevent/pages/splash_page.dart';
import 'package:relevent/pages/login_page.dart';
import 'package:relevent/pages/signup_page.dart';
import 'package:relevent/pages/onboard_page.dart';
import 'package:relevent/services/firebase_auth_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:relevent/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiProvider(
        providers: [
          Provider<FirebaseAuthMethods>(
            create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) => context.read<FirebaseAuthMethods>().authState,
            initialData: null,
          ),
        ],
        child: MaterialApp(
          title: "Rel'Event",
          theme: ThemeData(
              primarySwatch: Colors.teal,
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      shadowColor: Colors.teal,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ))),
              textTheme: GoogleFonts.barlowTextTheme(
                Theme.of(context).textTheme,
              )),
          debugShowCheckedModeBanner: false,
          home: const Splash(),
          routes: {
            Signup.routeName: (context) => Signup(),
            Login.routeName: (context) => Login(),
            ResetPassword.routeName: (context) => ResetPassword(),
            Onboard.routeName: (context) => Onboard(),
            CreateEvent.routeName: (context) => CreateEvent(),
            Profile.routeName: (context) => Profile(),
            MyHomePage.routeName: (context) => MyHomePage(),
            BottomNav.routeName: (context) => BottomNav(),
            GiveFeedback.routeName: (context) => GiveFeedback(),
          },
        ),
      ),
    );
  }
}
