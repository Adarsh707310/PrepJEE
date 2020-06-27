import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jeeapp/shared/constants.dart';
import 'package:jeeapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:jeeapp/models/user.dart';

class AllPracticeQueShow extends StatefulWidget {
  final String queOfSubject;
  AllPracticeQueShow({this.queOfSubject});

  @override
  _AllPracticeQueShowState createState() => _AllPracticeQueShowState();
}

class _AllPracticeQueShowState extends State<AllPracticeQueShow> {
  String answerMarked;
  bool submit = false;
  bool likeButtonPressed = false;
  int likes;
  Color likeIconcolor = Colors.brown[100];
  Color reviewIconcolor = Colors.brown[100];
  List options = ['(a)', '(b)', '(c)', '(d)'];

  int timeSecond;
  bool condition = false;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    //print(widget.queOfSubject);
    return StreamBuilder(
      stream: Firestore.instance
          .collection('questions')
          .where("queBelongTo", isEqualTo: "Practice")
          .where("subject", isEqualTo: widget.queOfSubject)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('Data is loading ...');

        return PageView.builder(
          onPageChanged: (int page) {
            setState(() {
              submit = false;
              answerMarked = '';
              likeButtonPressed = false;
              reviewIconcolor = Colors.brown[100];
              likeIconcolor = Colors.brown[100];
            });
          },
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            likes = snapshot.data.documents[index]['likes'];
            timeSecond = snapshot.data.documents[index]['timeSecond'];
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Container(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              snapshot.data.documents[index]['subject'] + ' / ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(snapshot.data.documents[index]['queType'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text('AVG Time '),
                              Text(timeSecond.toString() + ' Sec'),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              //Text('$_counter'),
                              Text('counter'),
                              Text('Points: ' +
                                  snapshot.data.documents[index]['points']
                                      .toString()),
                            ],
                          ),
                        ],
                      ),
                      sb20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                                        likeButtonPressed == true
                                            ? DatabaseService()
                                                .updateQuestionLike(
                                                    snapshot.data.documents[
                                                        index]['qid'],
                                                    snapshot.data.documents[
                                                            index]['likes'] +
                                                        1)
                                            : DatabaseService()
                                                .updateQuestionLike(
                                                    snapshot.data
                                                            .documents[index]
                                                        ['qid'],
                                                    snapshot.data.documents[
                                                            index]['likes'] -
                                                        1);
                                      },
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(likes.toString()),
                                    SizedBox(
                                      width: 10,
                                    ),
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
                                        DatabaseService()
                                            .updateUserContestTodoInsertions(
                                                user.uid,
                                                snapshot.data.documents[index]
                                                    ['qid']);
                                      },
                                    ),
                                    Text('Todo'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          sb10,
                          snapshot.data.documents[index]['queText'] != null
                              ? Text(
                                  'Que: ' +
                                      snapshot.data.documents[index]['queText'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                )
                              : sb3,

                          sb10,
                          snapshot.data.documents[index]['quePicturelink'] ==
                                  null
                              ? sb3
                              : Image.network(snapshot.data.documents[index]
                                  ['quePicturelink']),
                          sb10,

                          // show options orr intizers
                          snapshot.data.documents[index]['queType'] == 'MCQ'
                              ? Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('options'),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        '(a)  ' +
                                            snapshot.data.documents[index]
                                                ['options'][0],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text('(b)  ' +
                                          snapshot.data.documents[index]
                                              ['options'][1]),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text('(c)  ' +
                                          snapshot.data.documents[index]
                                              ['options'][2]),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text('(d)  ' +
                                          snapshot.data.documents[index]
                                              ['options'][3]),
                                    ],
                                  ))
                              : Container(
                                  child: Column(
                                  children: <Widget>[
                                    Text('Integer Type Question: '),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )),

                          snapshot.data.documents[index]['queType'] == 'MCQ'
                              ? DropdownButtonFormField(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Select option'),
                                  items: options.map((option) {
                                    return DropdownMenuItem(
                                      value: option,
                                      child: Text('option $option'),
                                    );
                                  }).toList(),
                                  onChanged: (val) =>
                                      setState(() => answerMarked = val),
                                )
                              : TextFormField(
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Write Answer Here'),
                                  validator: (val) =>
                                      val.isEmpty ? 'Enter an the ans' : null,
                                  onChanged: (val) {
                                    setState(() => answerMarked = val);
                                  },
                                ),

                          sb20,
                          //submit button
                          Container(
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
                          ),
                          sb20,
                          submit == true
                              ? answerMarked ==
                                      snapshot.data.documents[index]['answer']
                                  ? Center(child: Text('Correct'))
                                  : Center(child: Text('InCorrect'))
                              : SizedBox(height: 1)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
