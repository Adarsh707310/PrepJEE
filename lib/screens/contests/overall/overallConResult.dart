import 'package:flutter/material.dart';
import 'package:jeeapp/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jeeapp/services/database.dart';
import 'package:jeeapp/screens/contests/solution/allsol.dart';

class OverallContestResult extends StatefulWidget {
  final List score, answerMarked, pointScored, quelevel, qidList;
  final String queBelongTo, uid;
  OverallContestResult(
      {this.qidList,
      this.score,
      this.answerMarked,
      this.pointScored,
      this.quelevel,
      this.queBelongTo,
      this.uid});

  @override
  _OverallContestResultState createState() => _OverallContestResultState();
}

class _OverallContestResultState extends State<OverallContestResult> {
  int attemtedQue = 0;
  int unattemtedQue = 0;
  int correctAns = 0;
  int totalQue = 21;
  int maximumMarks = 84;
  int incorrectAns = 0;
  int negetiveMarks = 0;
  int totalmarksScored = 0;
  int totalpointsScored = 0;
  String accuracy = '';
  List queStatus = [
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
  int indexofmaparray = -1;
  int ratingInc = 0;
  int rank = 1000;
  int totalstudents = 1000;

  initiliseFields() {
    for (int i = 0; i < 21; i++) {
      totalpointsScored += widget.pointScored[i];

      if (widget.pointScored[i] == 0) {
        if (widget.answerMarked[i] != '') incorrectAns++;
      } else
        correctAns++;

      if (widget.score[i] == -1) {
        queStatus[i] = 'negetive';
        negetiveMarks--;
        totalmarksScored--;
      } else {
        totalmarksScored += widget.score[i];
        if (widget.score[i] > 0)
          queStatus[i] = 'correct';
        else {
          widget.answerMarked[i] == ''
              ? queStatus[i] = 'unattemted'
              : queStatus[i] = 'incorrect';
        }
      }
      widget.answerMarked[i] == '' ? unattemtedQue++ : attemtedQue++;
    }

    accuracy = (100 * correctAns / attemtedQue).toString().split('.')[0];
    ratingInc = (100 * totalmarksScored / maximumMarks).round();
  }

  @override
  void initState() {
    super.initState();
    initiliseFields();
    updateIt();
  }

  void updateIt() async {
    await DatabaseService()
        .updateLongResult(totalmarksScored, widget.queBelongTo, widget.uid);

    await DatabaseService().updateUserContestIncriments(
        widget.uid, totalpointsScored, correctAns, ratingInc, attemtedQue);

    for (int i = 0; i < 21; i++) {
      if (widget.qidList[i] != '' && queStatus[i] == 'correct')
        await DatabaseService()
            .updateUserContestSolvedInsertions(widget.uid, widget.qidList[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            sb20,
            sb20,
            // title
            Container(
              height: 50,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.home,
                            color: Colors.indigo[800],
                          ),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Text(
                          'Report',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 24,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    Text(
                      'Overall Contest:',
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),

            // blue card
            Container(
              height: 260,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.indigo[800],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(20),
                    // Score
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.assignment,
                              color: Colors.white,
                            ),
                            sbw10,
                            Text('Score',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(totalmarksScored.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30)),
                            Text(
                              'out of ' + maximumMarks.toString(),
                              style: tsl.copyWith(fontSize: 10),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  // accuracy
                  Container(
                    width: 125,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('Accuracy: ' + accuracy.toString() + '%',
                        style: tsl.copyWith(fontSize: 16)),
                  ),

                  // Divider
                  Divider(
                    height: 30,
                    indent: 15,
                    endIndent: 15,
                    thickness: 2,
                    color: Colors.white,
                  ),

                  // attemt
                  Container(
                    margin: EdgeInsets.all(20),

                    // Individual Score fields
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  ' Attemted : ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  attemtedQue.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            sb15,
                            Row(
                              children: <Widget>[
                                Text(
                                  'UnAttemted : ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  unattemtedQue.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Correct : ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  correctAns.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            sb15,
                            Row(
                              children: <Widget>[
                                Text(
                                  'Incorrect : ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                sb10,
                                Text(
                                  incorrectAns.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'Total Que : ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  totalQue.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            sb15,
                            Row(
                              children: <Widget>[
                                Text(
                                  'Negetive : ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                sb10,
                                Text(
                                  negetiveMarks.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            sb5,
            // Rank & Persentile
            StreamBuilder(
                stream: Firestore.instance
                    .collection('contests')
                    .document(widget.queBelongTo)
                    .collection('students')
                    .where("score", isGreaterThanOrEqualTo: totalmarksScored)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) rank = snapshot.data.documents.length;

                  return StreamBuilder(
                      stream: Firestore.instance
                          .collection('contests')
                          .document(widget.queBelongTo)
                          .collection('students')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          totalstudents = snapshot.data.documents.length;
                        return Container(
                          child: Column(
                            children: <Widget>[
                              Text('persentile : ' +
                                  (100 * (totalstudents - rank) / totalstudents)
                                      .toString()
                                      .split('.')[0] +
                                  ' %'),
                              Divider(
                                height: 30,
                                indent: 20,
                                endIndent: 20,
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Text('Rank : ' +
                                  rank.toString() +
                                  '/' +
                                  totalstudents.toString()),
                              Divider(
                                height: 30,
                                indent: 20,
                                endIndent: 20,
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Text('points Scored : ' +
                                  totalpointsScored.toString()),
                            ],
                          ),
                        );
                      });
                }),
            RaisedButton(
              color: Colors.blueAccent[200],
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Solution(
                          answerMarked: widget.answerMarked,
                          queBelongTo: widget.queBelongTo))),
              child: Text(
                'Solutions',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),

            sb10,
          ],
        ),
      ),
    );
  }
}
