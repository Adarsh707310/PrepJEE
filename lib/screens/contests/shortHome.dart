import 'package:flutter/material.dart';
import 'package:jeeapp/screens/drawerHome/configuration.dart';
import 'package:jeeapp/screens/contests/shortPreStart.dart';

class ShortContestHome extends StatefulWidget {
  @override
  _ShortContestHomeState createState() => _ShortContestHomeState();
}

class _ShortContestHomeState extends State<ShortContestHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 8),
          child: Column(
            children: <Widget>[
              Container(
                height: 40,
                child: Center(
                  child: Text('Short Contests'),
                ),
              ),
              Container(
                height: 300,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: shortContest.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text('${index + 1}'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShortPreStart(
                                        duration: shortContest[index]
                                            ['duration'],
                                        totalques: shortContest[index]
                                            ['totalques'],
                                        totalmarks: shortContest[index]
                                            ['totalmarks'],
                                        mcq: shortContest[index]['mcq'],
                                        integer: shortContest[index]['integer'],
                                        subject: shortContest[index]['subject'],
                                        topic: shortContest[index]['topic'],
                                        queBelongTo: shortContest[index]
                                            ['queBelongTo'],
                                      )));
                        },
                        title: Text(shortContest[index]['subject']),
                        subtitle: Text(shortContest[index]['topic']),
                      );
                    }),
              )
            ],
          )),
    );
  }
}
