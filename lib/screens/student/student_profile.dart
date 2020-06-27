//import 'dart:html';

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jeeapp/models/user.dart';
import 'package:jeeapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentProfile extends StatefulWidget {
  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  String instaImagelink =
      'https://firebasestorage.googleapis.com/v0/b/jeeapp-2a139.appspot.com/o/picture%2Fbjvcxrchvb?alt=media&token=a108bc7b-5fc0-4a1f-a306-fd970a26866a';
  @override
  Widget build(BuildContext context) {
    int globalRank = 0;
    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return StreamBuilder(
                stream: Firestore.instance
                    .collection('appInformation')
                    .where("rating", isGreaterThanOrEqualTo: userData.rating)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    globalRank = snapshot.data.documents.length;
                    return Scaffold(
                      body: Stack(
                        children: [
                          Positioned.fill(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey[300],
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(40),
                                          bottomRight: Radius.circular(40),
                                        )),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.share),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 60),
                            child: Column(
                              children: <Widget>[
                                // Image
                                Container(
                                  height: 120,
                                  alignment: Alignment.topCenter,
                                  child: userData.gender == 'Female'
                                      ? Image.asset(
                                          'images/girl.png',
                                          height: 120,
                                          width: 120,
                                        )
                                      : Image.asset(
                                          'images/boy.png',
                                          height: 120,
                                          width: 120,
                                        ),
                                ),
                                SizedBox(height: 10),

                                // Name
                                Container(
                                  child: Text(
                                    userData.name,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                SizedBox(height: 10),

                                // Starts
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      for (var i = 1; i <= 5; i++)
                                        if (1 <= i && i <= userData.stars)
                                          Container(
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ),
                                          )
                                        else
                                          Container(
                                            child: Icon(
                                              Icons.star,
                                            ),
                                          ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),

                                // Rating Points
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.blueGrey[100]),
                                          child: Column(children: <Widget>[
                                            ListTile(
                                              title: Text('Rating'),
                                              subtitle: Text(
                                                  userData.rating.toString()),
                                            ),
                                          ]),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.blueGrey[100]),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  ListTile(
                                                    title: Text('Points'),
                                                    subtitle: Text(userData
                                                        .points
                                                        .toString()),
                                                  ),
                                                ])),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),

                                // Accuracy
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.blueGrey[100]),
                                          child: Column(children: <Widget>[
                                            ListTile(
                                              title: Text('Accuracy'),
                                              subtitle: Text((100 *
                                                          userData
                                                              .correctSubmission /
                                                          userData
                                                              .totalSubmission)
                                                      .toString()
                                                      .split('.')[0] +
                                                  ' %'), //
                                            ),
                                          ]),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                              margin: EdgeInsets.only(left: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.blueGrey[100]),
                                              child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    ListTile(
                                                      title:
                                                          Text('Global rank'),
                                                      subtitle: Text(globalRank
                                                          .toString()),
                                                    ),
                                                  ]))),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),

                                // Total and Correct submission
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.blueGrey[100]),
                                          child: Column(children: <Widget>[
                                            ListTile(
                                              title: Text('Total submission'),
                                              subtitle: Text(userData
                                                  .totalSubmission
                                                  .toString()),
                                            ),
                                          ]),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.blueGrey[100]),
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  ListTile(
                                                    title: Text(
                                                        'Correct submission'),
                                                    subtitle: Text(userData
                                                        .correctSubmission
                                                        .toString()),
                                                  ),
                                                ])),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),

                                // finished contest best rank
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.blueGrey[100]),
                                    child: Column(children: <Widget>[
                                      ListTile(
                                        title: Text('Finished contests  ' +
                                            userData.finishedQuizes.toString()),
                                      ),
                                    ]),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else
                    return Scaffold(
                      body: Center(
                        child: Text('Loading'),
                      ),
                    );
                });
          } else {
            return Scaffold(
              body: Center(
                child: Text('Loading'),
              ),
            );
          }
        });
  }
}
