import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jeeapp/screens/contests/overall/overallConResult.dart';
import 'package:jeeapp/screens/contests/question/question.dart';
import 'package:jeeapp/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:jeeapp/models/user.dart';

class OverallStart extends StatefulWidget {
  final String queBelongTo;
  OverallStart({this.queBelongTo});

  @override
  _OverallStartState createState() => _OverallStartState();
}

class _OverallStartState extends State<OverallStart> {
  List score = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List answerMarked = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    ''
  ];
  List qid = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    ''
  ];
  List pointScored = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  ];
  bool likeButtonPressed = false;
  int likes = 0;
  Color likeIconcolor = Colors.brown[100];
  Color reviewIconcolor = Colors.brown[100];
  List options = ['(a)', '(b)', '(c)', '(d)'];
  int timeSecond = 0;
  bool condition = false;

  List ansFromDB = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    ''
  ];
  List points = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  int pageCahnged = 0;
  List quelevel = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    ''
  ];
  String uid = '';
  int counter = 2700;
  Duration oneSec = Duration(seconds: 1);
  String timer = '';

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
    if (counter > 0)
      startTimer();
    else
      endContest();
  }

  void setMarks(String queType, bool ansIs) {
    answerMarked[pageCahnged] == ''
        ? setState(() {
            score[pageCahnged] = 0;
            pointScored[pageCahnged] = 0;
          })
        : ansIs
            ? setState(() {
                score[pageCahnged] = 4;
                pointScored[pageCahnged] = points[pageCahnged];
              })
            : queType == 'MCQ'
                ? setState(() {
                    score[pageCahnged] = -1;
                    pointScored[pageCahnged] = 0;
                  })
                : setState(() {
                    score[pageCahnged] = 0;
                    pointScored[pageCahnged] = 0;
                  });
  }

  void updateEvalution(String queType) {
    if (queType == 'MCQ')
      answerMarked[pageCahnged] == ansFromDB[pageCahnged]
          ? setMarks(queType, true)
          : setMarks(queType, false);
    else
      int.parse(answerMarked[pageCahnged]) == int.parse(ansFromDB[pageCahnged])
          ? setMarks(queType, true)
          : setMarks(queType, false);
  }

  void endContest() {
    counter = -1;

    Navigator.pop(context);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OverallContestResult(
                  score: score,
                  answerMarked: answerMarked,
                  pointScored: pointScored,
                  quelevel: quelevel,
                  queBelongTo: widget.queBelongTo,
                  uid: uid,
                  qidList: qid,
                )));
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    uid = user.uid;
    return SingleChildScrollView(
      child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                height: 105,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      sb15,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 15,
                            child: Icon(Icons.arrow_left),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.timer,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(timer,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          CircleAvatar(
                            radius: 15,
                            child: Icon(Icons.arrow_right),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 120,
                          ),
                          RaisedButton(
                            color: Colors.green[300],
                            onPressed: () {
                              endContest();
                            },
                            child: Text('Submit'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 530,
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection('questions')
                        .where("queBelongTo", isEqualTo: widget.queBelongTo)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Text('Data is loading ...');
                      return PageView.builder(
                          onPageChanged: (int page) {
                            setState(() {
                              pageCahnged = page;
                              likeButtonPressed = false;
                            });
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.documents.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            ansFromDB[pageCahnged] =
                                snapshot.data.documents[index]['answer'];
                            points[pageCahnged] =
                                snapshot.data.documents[index]['points'];
                            quelevel[pageCahnged] =
                                snapshot.data.documents[index]['label'];
                            qid[pageCahnged] =
                                snapshot.data.documents[index]['qid'];

                            return Question(
                              likeButtonPressed: likeButtonPressed,
                              qid: qid[pageCahnged],
                              likes: snapshot.data.documents[index]['likes'],
                              point: points[pageCahnged],
                              answerMarked: answerMarked,
                              pageCahnged: pageCahnged,
                              queText: snapshot.data.documents[index]
                                  ['queText'],
                              queType: snapshot.data.documents[index]
                                  ['queType'],
                              options: snapshot.data.documents[index]
                                  ['options'],
                              score: score,
                              updateEvalution: updateEvalution,
                              quePicturelink: snapshot.data.documents[index]
                                  ['quePicturelink'],
                              solPicturelink: snapshot.data.documents[index]
                                  ['solPicturelink'],
                              ansRemark: snapshot.data.documents[index]
                                  ['ansRemark'],
                            );
                          });
                    }),
              ),
            ],
          )),
    );
  }
}
