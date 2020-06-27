import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jeeapp/shared/constants.dart';
import 'package:jeeapp/services/database.dart';

class LabelWisePractice extends StatefulWidget {
  final String label;
  LabelWisePractice({this.label});

  @override
  _LabelWisePracticeState createState() => _LabelWisePracticeState();
}

class _LabelWisePracticeState extends State<LabelWisePractice> {
  String answerMarked = '';
  bool likeButtonPressed = false;
  int likes;
  Color likeIconcolor = Colors.brown[100];
  Color reviewIconcolor = Colors.brown[100];
  List options = ['(a)', '(b)', '(c)', '(d)'];
  int timeSecond = 0;
  String avgsolTime = '00:00';

  int pageCahnged = 0;

  int counter = 0;
  Duration oneSec = Duration(seconds: 1);
  String timer = '00:00';

  void startTimer() {
    Timer(oneSec, keepRunning);
  }

  void keepRunning() {
    setState(() {
      counter++;
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
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 640,
      width: 360,
      child: Column(
        children: <Widget>[
          // title
          Container(
            height: 70,
            child: Center(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.timer,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(timer,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Text(widget.label,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600)),
                      Row(
                        children: <Widget>[
                          Text('Exp. time: ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            width: 4,
                          ),
                          Text(avgsolTime,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        ],
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
                  .where("queBelongTo", isEqualTo: "Practice")
                  .where("label", isEqualTo: widget.label)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Text('Data is loading ...');
                return PageView.builder(
                  onPageChanged: (int page) {
                    setState(() {
                      pageCahnged = page;
                      counter = 0;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.documents.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    likes = snapshot.data.documents[index]['likes'];
                    timeSecond = snapshot.data.documents[index]['timeSecond'];
                    avgTime();

                    return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          sb10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Card(
                                    elevation: 5.0,
                                    color: Colors.white,
                                    child: Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.favorite),
                                          color: likeIconcolor,
                                          onPressed: () {
                                            setState(() {
                                              likeIconcolor =
                                                  likeIconcolor == Colors.red
                                                      ? Colors.brown[100]
                                                      : Colors.red;

                                              likeButtonPressed =
                                                  !likeButtonPressed;
                                            });

                                            likeButtonPressed ==
                                                    true
                                                ? DatabaseService()
                                                    .updateQuestionLike(
                                                        snapshot.data
                                                                .documents[index]
                                                            ['qid'],
                                                        snapshot.data
                                                                        .documents[
                                                                    index]
                                                                ['likes'] +
                                                            1)
                                                : DatabaseService()
                                                    .updateQuestionLike(
                                                        snapshot.data.documents[
                                                            index]['qid'],
                                                        snapshot.data.documents[
                                                                    index]
                                                                ['likes'] -
                                                            1);
                                          },
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(likes.toString()),
                                        sbw10,
                                      ],
                                    ),
                                  ),
                                  Card(
                                    elevation: 5.0,
                                    color: Colors.white,
                                    child: Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.check_box),
                                          color: reviewIconcolor,
                                          onPressed: () {
                                            setState(() {
                                              reviewIconcolor =
                                                  reviewIconcolor == Colors.red
                                                      ? Colors.brown[100]
                                                      : Colors.red;
                                            });
                                          },
                                        ),
                                        Text('Review'),
                                        sbw10,
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),

                              snapshot.data.documents[index]
                                          ['quePictureLink'] ==
                                      null
                                  ? SizedBox(height: 1)
                                  : AssetImage(snapshot.data.documents[index]
                                      ['quePictureLink']),

                              sb20,

                              // show options orr intizers
                              snapshot.data.documents[index]['queType'] == 'MCQ'
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

                              snapshot.data.documents[index]['queType'] == 'MCQ'
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
                                            setState(() => answerMarked = val);
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
                                            setState(() => answerMarked = val);
                                          },
                                        )
                                  : TextFormField(
                                      decoration: textInputDecoration.copyWith(
                                          hintText: 'Write Answer Here'),
                                      onChanged: (val) {
                                        setState(() => answerMarked = val);
                                      },
                                    ),

                              answerMarked != ''
                                  ? Container(
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
                                    )
                                  : SizedBox(
                                      height: 1,
                                    ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
