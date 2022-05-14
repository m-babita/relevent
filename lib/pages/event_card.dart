import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard(
      {Key? key,
      required this.title,
      required this.type,
      required this.date,
      required this.description})
      : super(key: key);

  final String title, type, date, description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 700,
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 165,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              color: Colors.teal[100],
              child: Row(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          type,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          date,
                          style: TextStyle(fontSize: 18),
                        ),
                        Container(
                          width: 300,
                          child: Text(
                            description,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
