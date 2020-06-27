import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jeeapp/screens/drawerHome/configuration.dart';
import 'package:jeeapp/screens/practice/allQuestion.dart';
import 'package:provider/provider.dart';
import 'package:jeeapp/models/user.dart';
import 'package:jeeapp/services/database.dart';
import 'package:jeeapp/screens/student/student_profile.dart';
import 'package:jeeapp/shared/loading.dart';
import 'package:jeeapp/screens/contests/allNavigate.dart';
import 'package:jeeapp/shared/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          if (userData == null) return Loading();
          return AnimatedContainer(
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(scaleFactor)
              ..rotateY(isDrawerOpen ? -0.5 : 0),
            duration: Duration(milliseconds: 250),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
            child: SingleChildScrollView(
              child: Container(
                padding:
                    EdgeInsets.only(top: 30, bottom: 15, left: 10, right: 10),
                child: Column(
                  children: [
                    /*SizedBox(
                      height: 30,
                    ),*/
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isDrawerOpen
                              ? IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  onPressed: () {
                                    setState(() {
                                      xOffset = 0;
                                      yOffset = 0;
                                      scaleFactor = 1;
                                      isDrawerOpen = false;
                                    });
                                  },
                                )
                              : IconButton(
                                  icon: Icon(Icons.menu),
                                  onPressed: () {
                                    setState(() {
                                      xOffset = 184;
                                      yOffset = 75;
                                      scaleFactor = 0.8;
                                      isDrawerOpen = true;
                                    });
                                  }),
                          Row(
                            children: <Widget>[
                              Text('Prep',
                                  style: TextStyle(
                                      fontSize: 24.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w300)),
                              Text('JEE',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.blueAccent[200],
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StudentProfile()));
                            },
                            child: CircleAvatar(
                                radius: 17,
                                backgroundColor: Colors.blueGrey[300],
                                backgroundImage: userData.gender == 'Female'
                                    ? AssetImage('images/girl.png')
                                    : AssetImage('images/boy.png')),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllPracticeQueHome(
                                          queOfSubject: categories[index]
                                              ['queOfSubject'])));
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: shadowList,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.asset(
                                      categories[index]['iconPath'],
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    categories[index]['name'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    sb10,
                    Container(
                      height: 435,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: contests.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllNavigater(
                                          navigateTo: contests[index]
                                              ['navigateTo'])));
                            },
                            child: Container(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  //  Contest
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: shadowList,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Image.asset(
                                            contests[index]['iconPath'],
                                            height: 100,
                                            //color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Colors.blue[100],
                                              boxShadow: shadowList,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              )),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Center(
                                                child: Text(
                                                  contests[index]['type'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              sb5,
                                              sb5,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text('Time'),
                                                  Text('Que.'),
                                                  Text('Score'),
                                                ],
                                              ),
                                              sb3,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          ' ' +
                                                              contests[index]
                                                                  ['duration'],
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                        Text(
                                                          'min.',
                                                          style: TextStyle(
                                                              fontSize: 10),
                                                        )
                                                      ]),
                                                  //SizedBox(width: 80),
                                                  Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          contests[index]
                                                              ['totalques'],
                                                          style: TextStyle(
                                                              fontSize: 15),
                                                        ),
                                                        Text(
                                                          '(' +
                                                              contests[index]
                                                                  ['mcq'] +
                                                              '+' +
                                                              contests[index]
                                                                  ['integer'] +
                                                              ')',
                                                          style: TextStyle(
                                                              fontSize: 8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        )
                                                      ]),
                                                  //SizedBox(width: 40),
                                                  Text(
                                                    contests[index]
                                                            ['totalmarks'] +
                                                        '  ',
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    /*SizedBox(
                      height: 10,
                    )*/
                  ],
                ),
              ),
            ),
          );
        });
  }
}
