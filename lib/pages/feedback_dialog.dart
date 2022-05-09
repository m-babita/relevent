import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GiveFeedback extends StatefulWidget {
  static String routeName = '/feedback';
  const GiveFeedback({Key? key}) : super(key: key);

  @override
  State<GiveFeedback> createState() => _GiveFeedbackState();
}

class _GiveFeedbackState extends State<GiveFeedback> {
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.arrow_left,
                color: Colors.teal,
                size: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Give Feedback",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Do you have a suggestion? or found some bug let us know! It will help us improve Rel'Event.",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  feedbackMessage('Describe your experience here'),
                  SizedBox(height: 20),
                  FeedbackButton(),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

//submit button
  Widget FeedbackButton() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('FeedbackMessage')
                      .add({"message": _feedbackController.text});
                  Navigator.pop(context);
                },
                child: Text('Submit'))
          ],
        ));
  }

//feedbackMessage
  Widget feedbackMessage(String titleText) => Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.teal[100]),
        child: TextFormField(
          controller: _feedbackController,
          style: TextStyle(fontSize: 17),
          maxLines: null,
          decoration: InputDecoration(
              hintText: titleText,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              hintStyle: TextStyle(fontSize: 17)),
        ),
      );
}
