import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relevent/pages/feedback_dialog.dart';
import 'package:relevent/pages/login_page.dart';
import 'package:relevent/pages/onboard_page.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  static String routeName = '/profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isloggedin = false;
  bool isSwitched = false;

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
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signout() async {
    await _auth.signOut().then((value) {
      Navigator.pushNamed(context, Login.routeName);
    });
  }

  feedback() {
    GiveFeedback();
  }

  @override
  void initState() {
    super.initState();
    checkAuthentification();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
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
            Text("Profile")
          ],
        ),
      ),
      body: Container(
          child: !isloggedin
              ? Center(child: CircularProgressIndicator())
              : Container(
                  padding: EdgeInsetsDirectional.all(12),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.teal[100],
                          radius: 100,
                          child: ClipOval(
                            child: Image.asset(
                              'images/avatar.png',
                              width: 185,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'Change Profile',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.edit,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Container(
                            width: 700,
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello,",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${user!.displayName}",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Email:',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.teal),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.mail, color: Colors.teal),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "${user!.email}",
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Give feedback:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.teal,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                GiveFeedback());
                                      },
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty
                                            .resolveWith<EdgeInsetsGeometry>(
                                          (Set<MaterialState> states) {
                                            return EdgeInsets.all(8);
                                          },
                                        ),
                                      ),
                                      child: Text(
                                        'Feedback',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(children: [
                                  Text(
                                    'Are you organizer?:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.teal),
                                  ),
                                  Switch(
                                    value: isSwitched,
                                    onChanged: (value) {
                                      setState(() {
                                        isSwitched = value;
                                      });
                                    },
                                    activeTrackColor: Colors.teal[100],
                                    activeColor: Colors.teal,
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: signout,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Logout'),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.logout,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.resolveWith<
                                EdgeInsetsGeometry>(
                              (Set<MaterialState> states) {
                                return EdgeInsets.all(6);
                              },
                            ),
                          ),
                          onPressed: () => showAboutDialog(
                              context: context,
                              applicationIcon: FlutterLogo(),
                              applicationVersion: '1.0.0',
                              applicationLegalese: 'Babita Majumdar'),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'About App',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.settings_rounded,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ))),
    );
  }
}
