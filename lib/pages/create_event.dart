import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateEvent extends StatefulWidget {
  static String routeName = '/createEvent';
  const CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  DateTime? _date;
  String type = "";
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _registerController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  pickDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2050),
    );
    if (result != null) {
      setState(() {
        _date = result;
      });
    }
  }

  _dateString() {
    if (_date == null) {
      return 'Select date Of Event';
    } else {
      return '${_date?.day} | ${_date?.month} | ${_date?.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                    SizedBox(height: 8),
                    Row(
                      children: [
                        category('Seminar'),
                        SizedBox(width: 8),
                        category('Hackathon'),
                        SizedBox(width: 8),
                        category('Campaign'),
                        SizedBox(width: 8),
                        category('Webinar'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        category('Technical Event'),
                        SizedBox(width: 8),
                        category('Fest'),
                        SizedBox(width: 8),
                        category('Other'),
                      ],
                    ),
                    SizedBox(height: 10),
                    label('Description'),
                    SizedBox(height: 8),
                    description('Enter details about your event'),
                    SizedBox(height: 10),
                    label('Register Link'),
                    SizedBox(height: 8),
                    register('Enter registration link'),
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
                    SizedBox(height: 10),
                    label('Location'),
                    SizedBox(height: 8),
                    location('Enter location'),
                    SizedBox(height: 25),
                    createEventButton(),
                    SizedBox(height: 30),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

//submit button
  Widget createEventButton() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance.collection('EventDetails').add({
                    "title": _titleController.text,
                    "type": type,
                    "description": _descriptionController.text,
                    "link": _registerController,
                    "date": _dateString(),
                    "location": _locationController.text,
                  });
                  Navigator.pop(context);
                },
                child: Text('Create Event'))
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
          controller: _descriptionController,
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
  Widget category(String eventType) {
    return InkWell(
        onTap: () {
          setState(() {
            type = eventType;
          });
        },
        child: Chip(
            elevation: 5,
            backgroundColor:
                type == eventType ? Colors.teal[800] : Colors.teal[300],
            label: Text(
              eventType,
              style: TextStyle(color: Colors.white),
            )));
  }

//title
  Widget title(String titleText) => Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.teal[100]),
        child: TextFormField(
          controller: _titleController,
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

//register
  Widget register(String titleText) => Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.teal[100]),
        child: TextFormField(
          controller: _registerController,
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
//location
  Widget location(String titleText) => Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.teal[100]),
        child: TextFormField(
          controller: _locationController,
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
