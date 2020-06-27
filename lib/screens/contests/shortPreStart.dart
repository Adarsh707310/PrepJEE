import 'package:flutter/material.dart';
import 'package:jeeapp/screens/contests/shortStart.dart';
import 'package:jeeapp/shared/constants.dart';

class ShortPreStart extends StatefulWidget {
  final String queBelongTo;
  final String duration;
  final String totalques;
  final String totalmarks;
  final String mcq;
  final String integer;
  final String subject;
  final String topic;

  ShortPreStart({
    this.queBelongTo,
    this.duration,
    this.totalques,
    this.totalmarks,
    this.mcq,
    this.integer,
    this.subject,
    this.topic,
  });

  @override
  _ShortPreStartState createState() => _ShortPreStartState();
}

class _ShortPreStartState extends State<ShortPreStart> {
  bool contestStarted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
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
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 25, left: 20, right: 20),
            child: contestStarted
                ? ShortStart(
                    queBelongTo: widget.queBelongTo,
                  )
                : Container(
                    //height: 640,
                    //width: 360,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 80,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget.topic,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 1),
                          child: Text(
                            'Short Contest Information: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        // duration ans stuff
                        Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Duration'),
                                  Text('Questions'),
                                  Text('Marks'),
                                ],
                              ),
                              sb20,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          widget.duration,
                                          style: TextStyle(fontSize: 30),
                                        ),
                                        Text(
                                          'minuts',
                                          style: TextStyle(fontSize: 10),
                                        )
                                      ]),
                                  //SizedBox(width: 80),
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          widget.totalques,
                                          style: TextStyle(fontSize: 30),
                                        ),
                                        Text(
                                          '(' +
                                              widget.mcq +
                                              '+' +
                                              widget.integer +
                                              ')',
                                          style: TextStyle(fontSize: 10),
                                        )
                                      ]),
                                  //SizedBox(width: 40),
                                  Text(
                                    widget.totalmarks,
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        sb20,
                        // Info
                        ListTile(
                          dense: true,
                          leading: Icon(Icons.check),
                          title: Text(
                            '7 question of Permutation & Combination',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        // Info for MCQ
                        ListTile(
                          dense: true,
                          leading: Icon(Icons.check),
                          title: Column(
                            children: <Widget>[
                              Text(
                                '5 Objective Multiple choice type questions(MCQs) per subject',
                                style: TextStyle(fontSize: 16),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 8),
                                  Text(
                                    '4 marks for correct answer',
                                    //style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '1 -ve marks for Incorrect answer',
                                    //style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '0 marks for skipped que',
                                    //style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Divider(
                          color: Colors.black,
                          height: 30,
                          indent: 4,
                        ),

                        // Info for Integer
                        ListTile(
                          dense: true,
                          leading: Icon(Icons.check),
                          title: Column(
                            children: <Widget>[
                              Text(
                                '2 Numerical type questions per subject (Integer ans)',
                                style: TextStyle(fontSize: 16),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 8),
                                  Text(
                                    '4 marks for correct answer',
                                    //style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '0 marks for Incorrect answer',
                                    //style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '0 marks for skipped que',
                                    //style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        // Start button
                        Center(
                          child: RaisedButton(
                            color: Colors.blueAccent[200],
                            onPressed: () => setState(() {
                              contestStarted = true;
                            }),
                            child: Text(
                              'Enter The Contest',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
