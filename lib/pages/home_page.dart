import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relevent/pages/create_event.dart';
import 'package:relevent/pages/event_card.dart';
import 'package:relevent/pages/onboard_page.dart';
import 'package:relevent/widgets/custom_textfield.dart';

class MyHomePage extends StatefulWidget {
  static String routeName = '/home';
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController searchController = TextEditingController();
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, Onboard.routeName);
      }
    });
  }

  getUser() async {
    User? firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signout() async {
    _auth.signOut();
  }

  int _counter = 0;

  createEvent() {
    Navigator.pushNamed(context, CreateEvent.routeName);
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
          toolbarHeight: 70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
            ),
          ),
          title: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text("Rel'Event")
            ],
          ),
          actions: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  child: ClipOval(
                    child: Image.asset(
                      'images/profile.jpg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ]),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Container(
            child: !isloggedin
                ? CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: searchController,
                          hintText: '',
                          labelText: '',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        EventCard(
                            title: 'Workshop Series',
                            type: 'Session',
                            date: '24 | 03 | 22',
                            description:
                                'Workshop on various topic like Blockchain, Cryptocurrency, Algo Tradding and much more.'),
                        SizedBox(
                          height: 15,
                        ),
                        EventCard(
                            title: 'Summer Internship',
                            type: 'Program',
                            date: '15 | 04 | 22',
                            description:
                                'This program is help you build resume and interview preparations in various domains.'),
                        SizedBox(
                          height: 15,
                        ),
                        EventCard(
                            title: 'Data Science Bootcamp',
                            type: 'Session',
                            date: '18 | 05 | 22',
                            description:
                                'This program is help you build concepts of Data Science using python.'),
                        SizedBox(
                          height: 15,
                        ),
                        EventCard(
                            title: 'Hacktober Fest',
                            type: 'Technical Event',
                            date: '10 | 10 | 22',
                            description:
                                'Open Source contribution, Register now and start contributing on github.'),
                      ],
                    ),
                  ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createEvent,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
