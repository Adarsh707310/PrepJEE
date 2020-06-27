import 'package:flutter/material.dart';
import 'package:jeeapp/screens/practice/allQueShow.dart';

class AllPracticeQueHome extends StatefulWidget {
  final String queOfSubject;
  AllPracticeQueHome({this.queOfSubject});

  @override
  _AllPracticeQueHomeState createState() => _AllPracticeQueHomeState();
}

class _AllPracticeQueHomeState extends State<AllPracticeQueHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[500],
      body: Stack(children: [
        Positioned.fill(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[500],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 30),
          child: AllPracticeQueShow(queOfSubject: widget.queOfSubject),
        ),
      ]),
    );
  }
}
