import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relevent/pages/create_event.dart';
import 'package:relevent/pages/event_card.dart';
import 'package:relevent/pages/event_details.dart';
import 'package:relevent/pages/onboard_page.dart';
import 'package:relevent/pages/profile_page.dart';
import 'package:relevent/utils/extensions.dart';
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

  //firestore
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("EventDetails").snapshots();

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushNamed(context, Onboard.routeName);
      }
    });
  }

  getUser() async {
    User? firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        user = firebaseUser;
        isloggedin = true;
      });
    }
  }

  createEvent() {
    Navigator.pushNamed(context, CreateEvent.routeName);
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
      appBar: AppBar(
          toolbarHeight: 70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
            ),
          ),
          title: Row(
            children: const [
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
                  radius: 18,
                  child: ClipOval(
                    child: Image.asset(
                      'images/avatar.png',
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
      body: !isloggedin
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder<QuerySnapshot>(
              stream: _stream,
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 900,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: CustomTextField(
                        controller: searchController,
                        hintText: '',
                        labelText: '',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> document =
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                          return Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(children: [
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) => EventDetails(
                                                  document: document,
                                                )));
                                  },
                                  child: EventCard(
                                      title: document['title'] == ""
                                          ? "Event Title"
                                          : document['title'],
                                      type: document['type'] == ""
                                          ? "Others"
                                          : document['type'],
                                      date: document['date'] ==
                                              "Select date Of Event"
                                          ? "soon"
                                          : document['date'],
                                      description:
                                          document['description'] == null
                                              ? "description of event"
                                              : truncateString(
                                                  document['description'])),
                                ),
                                SizedBox(
                                  height: 5,
                                )
                              ]));
                        }),
                    SizedBox(
                      height: 20,
                    ),
                  ]),
                );
              })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[400],
        elevation: 5,
        onPressed: createEvent,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
