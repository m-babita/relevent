import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  DateTime? _date;

  pickDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2050),
    );
    if (result != null) {
      setState(() {
        _date = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _dateString() {
      if (_date == null) {
        return 'Select date Of Event';
      } else {
        return '${_date?.day} | ${_date?.month} | ${_date?.year}';
      }
    }

    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.arrow_left,
                color: Colors.teal,
                size: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create a",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "New Event ",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  label('Event Title'),
                  SizedBox(height: 8),
                  title('Enter Event Title'),
                  SizedBox(height: 10),
                  label('Event Type'),
                  Row(
                    children: [
                      category('Seminar'),
                      SizedBox(width: 8),
                      category('Hackathon'),
                      SizedBox(width: 8),
                      category('Campaign'),
                      SizedBox(width: 8),
                      category('Other'),
                    ],
                  ),
                  SizedBox(height: 10),
                  label('Description'),
                  SizedBox(height: 8),
                  description('Enter details about your event'),
                  SizedBox(height: 10),
                  label('Date'),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: pickDate,
                        icon: Icon(Icons.calendar_today_rounded),
                        label: Text('Choose a Date'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        _dateString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  label('Location'),
                  SizedBox(height: 8),
                  title('Enter location'),
                  SizedBox(height: 30),
                  createEventButton(),
                  SizedBox(height: 30),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

//submit button
  Widget createEventButton() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {}, child: Text('Create Event'))
          ],
        ));
  }

//description
  Widget description(String titleText) => Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.teal[100]),
        child: TextFormField(
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

//event type
  Widget category(String type) {
    return Chip(
        backgroundColor: Colors.teal[400],
        // Colors.accents[Random().nextInt(Colors.accents.length)],
        label: Text(
          type,
          style: TextStyle(color: Colors.white),
        ));
  }

//title
  Widget title(String titleText) => Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.teal[100]),
        child: TextFormField(
          style: TextStyle(fontSize: 17),
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

//label
  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    );
  }
}
