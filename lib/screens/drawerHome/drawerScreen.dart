import 'package:flutter/material.dart';
import 'package:jeeapp/screens/admin/Guide.dart';
import 'package:jeeapp/screens/drawerHome/configuration.dart';
import 'package:jeeapp/screens/liketodosol/liketodosol.dart';
import 'package:jeeapp/services/auth.dart';
//import 'package:jeeapp/screens/admin/addQue.dart';
import 'package:jeeapp/screens/student/student_profile.dart';
import 'package:provider/provider.dart';
import 'package:jeeapp/models/user.dart';
import 'package:jeeapp/services/database.dart';
import 'package:jeeapp/screens/practice/preLabelWise.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          if (userData == null) return Text('Loding');
          return Container(
            color: primaryGreen,
            padding: EdgeInsets.only(top: 40, bottom: 15, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentProfile()));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.blueGrey[300],
                          backgroundImage: userData.gender == 'Female'
                              ? AssetImage('images/girl.png')
                              : AssetImage('images/boy.png')),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userData.name ?? '',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text('Active Status',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: drawerItems1
                            .map(
                              (element) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LikeTodoSol(
                                              label: element['navigation'])));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        element['icon'],
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(element['title'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Divider(
                            color: Colors.white,
                            height: 30,
                            thickness: 3,
                            indent: 5,
                            endIndent: 210,
                          ),
                        ],
                      ),
                      Column(
                        children: drawerItems2
                            .map((element) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PreLabelWise(
                                                label: element['navigation'])));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          element['icon'],
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(element['title'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20))
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Guide()));
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            'About',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 2,
                      height: 20,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await _auth.signOut();
                      },
                      child: Text(
                        'Log out',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
