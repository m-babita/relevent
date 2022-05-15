import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:relevent/utils/show_snackbar.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetails extends StatefulWidget {
  static String routeName = '/eventDetails';
  const EventDetails({Key? key, required this.document}) : super(key: key);
  final Map<String, dynamic> document;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  String type = "", date = "", link = "";
  TextEditingController? _titleController;
  TextEditingController? _descriptionController;
  TextEditingController? _locationController;

  @override
  void initState() {
    super.initState();
    String title = widget.document['title'] ?? "Event Name";
    _titleController = TextEditingController(text: title);
    String description = widget.document['description'] ?? "Event Name";
    _descriptionController = TextEditingController(text: description);
    String location = widget.document['location'] ?? "Event Name";
    _locationController = TextEditingController(text: location);
    type = widget.document['type'];
    date = widget.document['date'];
    link = widget.document['link'] ?? "https://forms.gle/BPyKjhisyyE3cJu96";
  }

  launchURL() async {
    if (await canLaunchUrlString(link)) {
      await launchUrlString(
        link,
        mode: LaunchMode.externalApplication,
        webViewConfiguration: WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
        webOnlyWindowName: link,
      );
    } else {
      showSnackBar(context, 'Could not launch');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment(0.0, 0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.teal[50],
          ),
          height: MediaQuery.of(context).size.height * 0.9,
          width: 800,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    CupertinoIcons.clear,
                    color: Colors.teal,
                    size: 24,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Event Details",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      label('Event Title :'),
                      SizedBox(height: 10),
                      title('Enter Event Title'),
                      SizedBox(height: 10),
                      label('Event Type :'),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          category(type),
                          SizedBox(width: 8),
                        ],
                      ),
                      SizedBox(height: 10),
                      label('Description :'),
                      SizedBox(height: 10),
                      description('Details about event'),
                      SizedBox(height: 10),
                      registerButton(),
                      SizedBox(height: 10),
                      label('Date :'),
                      SizedBox(height: 10),
                      Text(
                        date,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      label('Location :'),
                      SizedBox(height: 10),
                      Row(children: [
                        Icon(
                          Icons.fmd_good_sharp,
                          color: Colors.teal,
                          size: 33,
                        ),
                        SizedBox(width: 2),
                        location('Location'),
                      ]),
                      SizedBox(height: 30),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget registerButton() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () => launchURL(),
              child: Text('Register Now'),
            ),
          ],
        ));
  }

//description
  Widget description(String titleText) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.teal[100]),
        child: TextFormField(
          controller: _descriptionController,
          style: TextStyle(fontSize: 20),
          maxLines: null,
          decoration: InputDecoration(
            hintText: titleText,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
          ),
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
            backgroundColor: Colors.teal[400],
            labelPadding: EdgeInsets.all(8),
            label: Text(
              eventType,
              style: TextStyle(color: Colors.white, fontSize: 20),
            )));
  }

//title
  Widget title(String titleText) => Container(
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.teal[100]),
        child: TextFormField(
          controller: _titleController,
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
            hintText: titleText,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
          ),
        ),
      );

//location
  Widget location(String titleText) => Container(
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.teal[100]),
        child: TextFormField(
          controller: _locationController,
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
            hintText: titleText,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
          ),
        ),
      );

//label
  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    );
  }
}
