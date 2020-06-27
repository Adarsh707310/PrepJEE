import 'dart:async';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:jeeapp/models/user.dart';
import 'package:jeeapp/shared/constants.dart';

class LikeTodoSol extends StatefulWidget {
  final String label;
  LikeTodoSol({this.label});

  @override
  _LikeTodoSolState createState() => _LikeTodoSolState();
}

class _LikeTodoSolState extends State<LikeTodoSol> {
  String answerMarked = '';

  List options = ['(a)', '(b)', '(c)', '(d)'];
  int timeSecond = 0;
  String avgsolTime = '00:00';
  String queType;
  int pageCahnged = 0;

  int counter = 240;
  Duration oneSec = Duration(seconds: 1);
  String timer = '00:00';
  bool submit = false;

  void startTimer() {
    Timer(oneSec, keepRunning);
  }

  void keepRunning() {
    setState(() {
      counter--;
      timer = ((counter - counter % 60) / 60)
              .toString()
              .split('.')[0]
              .padLeft(2, "0") +
          ':' +
          (counter % 60).toString().padLeft(2, "0");
    });
    if (counter > 0) startTimer();
  }

  void avgTime() {
    avgsolTime = ((timeSecond - timeSecond % 60) / 60)
            .toString()
            .split('.')[0]
            .padLeft(2, "0") +
        ':' +
        (timeSecond % 60).toString().padLeft(2, "0");
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .where("uid", isEqualTo: user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('Data is loading ...');
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[300],
              title: Text(widget.label),
              actions: <Widget>[Text('hii')],
            ),
            body: StreamBuilder(
                stream: Firestore.instance
                    .collection('users')
                    .where("uid", isEqualTo: user.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Text('Data is loading ...');
                  return PageView.builder(
                      onPageChanged: (int page) {
                        setState(() {
                          pageCahnged = page;
                          counter = 0;
                          answerMarked = '';
                          submit = false;
                        });
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          snapshot.data.documents[0][widget.label].length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        index = 0;
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                sb10,
                                Row(children: <Widget>[
                                  Text(
                                    'Points: ' +
                                        snapshot.data.documents[index]['points']
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  answerMarked != ''
                                      ? Text(
                                          'Marked: ' + answerMarked.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w500),
                                        )
                                      : Text(
                                          'not marked',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w500),
                                        ),
                                ]),

                                sb10,

                                Text(
                                  'Que: ' +
                                      snapshot.data.documents[index]['queText'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),

                                snapshot.data.documents[index]
                                            ['quePictureLink'] ==
                                        null
                                    ? SizedBox(height: 1)
                                    : AssetImage(snapshot.data.documents[index]
                                        ['quePictureLink']),

                                sb20,

                                // show options orr intizers
                                snapshot.data.documents[index]['queType'] ==
                                        'MCQ'
                                    ? Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Options:',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            sb15,
                                            Text(
                                              ' (a)  ' +
                                                  snapshot.data.documents[index]
                                                      ['options'][0],
                                            ),
                                            sb15,
                                            Text(' (b)  ' +
                                                snapshot.data.documents[index]
                                                    ['options'][1]),
                                            sb15,
                                            Text(' (c)  ' +
                                                snapshot.data.documents[index]
                                                    ['options'][2]),
                                            sb15,
                                            Text(' (d)  ' +
                                                snapshot.data.documents[index]
                                                    ['options'][3]),
                                          ],
                                        ))
                                    : Container(
                                        child: Column(
                                        children: <Widget>[
                                          Text('Integer Type Question: '),
                                          sb10,
                                        ],
                                      )),

                                snapshot.data.documents[index]['queType'] ==
                                        'MCQ'
                                    ? answerMarked != ''
                                        ? DropdownButtonFormField(
                                            value: answerMarked,
                                            decoration:
                                                textInputDecoration.copyWith(
                                                    hintText: 'Select option'),
                                            items: options.map((option) {
                                              return DropdownMenuItem(
                                                value: option,
                                                child: Text('option $option'),
                                              );
                                            }).toList(),
                                            onChanged: (val) {
                                              setState(
                                                  () => answerMarked = val);
                                            },
                                          )
                                        : DropdownButtonFormField(
                                            decoration:
                                                textInputDecoration.copyWith(
                                                    hintText: 'Select option'),
                                            items: options.map((option) {
                                              return DropdownMenuItem(
                                                value: option,
                                                child: Text('option $option'),
                                              );
                                            }).toList(),
                                            onChanged: (val) {
                                              setState(
                                                  () => answerMarked = val);
                                            },
                                          )
                                    : TextFormField(
                                        decoration:
                                            textInputDecoration.copyWith(
                                                hintText: 'Write Answer Here'),
                                        onChanged: (val) {
                                          setState(() => answerMarked = val);
                                        },
                                      ),

                                if (answerMarked != '')
                                  if (snapshot.data.documents[index]
                                          ['queType'] ==
                                      'MCQ')
                                    Container(
                                      height: 20,
                                      padding: EdgeInsets.only(left: 220),
                                      child: FlatButton(
                                        child: Text(
                                          'Reset',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            answerMarked = '';
                                          });
                                        },
                                      ),
                                    ),

                                //submit button
                                submit == false
                                    ? Container(
                                        height: 40,
                                        child: Center(
                                          child: FlatButton(
                                            child: Text('Submit'),
                                            color: Colors.blue,
                                            onPressed: () {
                                              setState(() => submit = true);
                                            },
                                          ),
                                        ),
                                      )
                                    : SizedBox(height: 25),
                                sb20,
                                submit == true
                                    ? answerMarked ==
                                            snapshot.data.documents[index]
                                                ['answer']
                                        ? Center(
                                            child: Text('Correct',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w700)))
                                        : Center(
                                            child: Text('InCorrect',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w400)))
                                    : SizedBox(height: 1)
                              ],
                            ),
                          ),
                        );
                      });
                }),
          );
        });
  }
}
