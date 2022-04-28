import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    _auth.signOut();
    Navigator.pushReplacementNamed(context, Onboard.routeName);
  }

  @override
  void initState() {
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
          ),
        ),
        title: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text("Profile")
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsetsDirectional.all(12),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: !isloggedin
            ? CircularProgressIndicator()
            : Column(
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
                        'images/profile.jpg',
                        width: 190,
                        height: 190,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: (){},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Change Profile',style: TextStyle(fontSize: 16),),
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,",
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${user!.displayName}",
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Email:', style: TextStyle(fontSize: 20, color: Colors.teal ),),
                        Row(
                          children: [
                            Icon(Icons.mail,color: Colors.teal),
                            SizedBox(width: 10,),
                            Text(
                              "${user!.email}",
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 20,),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: signout,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                ],
              ),
      )),
    );
  }
}
