import 'package:flutter/material.dart';
import 'package:relevent/pages/home_page.dart';
import 'package:relevent/pages/onboard_page.dart';
import 'package:relevent/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BottomNav extends StatefulWidget {
  static String routeName = '/bottom';
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  User? user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, Onboard.routeName);
      }
    });
  }

  getUser() async {
    User? firebaseUser = await _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  int index = 0;
  final screens = [MyHomePage(), Profile()];

  setIndex(index) {
    setState(() {
      this.index = index;
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isloggedin ? CircularProgressIndicator() : screens[index],
      bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: Colors.teal[100],
              labelTextStyle: MaterialStateProperty.all(TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.teal[800],
              ))),
          child: NavigationBar(
            height: 60,
            backgroundColor: Colors.teal[50],
            selectedIndex: index,
            onDestinationSelected: setIndex,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            animationDuration: Duration(seconds: 1),
            destinations: [
              NavigationDestination(
                label: 'Home',
                icon: Icon(
                  Icons.home_outlined,
                  size: 28,
                  color: Colors.teal[800],
                ),
                selectedIcon: Icon(
                  Icons.home_rounded,
                  size: 28,
                  color: Colors.teal[800],
                ),
              ),
              NavigationDestination(
                label: 'Profile',
                icon: Icon(
                  Icons.person_outline_rounded,
                  size: 28,
                  color: Colors.teal[800],
                ),
                selectedIcon: Icon(
                  Icons.person_rounded,
                  size: 28,
                  color: Colors.teal[800],
                ),
              ),
            ],
          )),
    );
  }
}
