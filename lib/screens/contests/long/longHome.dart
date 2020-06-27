import 'package:flutter/material.dart';
import 'package:jeeapp/screens/drawerHome/configuration.dart';
import 'package:jeeapp/screens/contests/long/longPreStart.dart';

class LongContestHome extends StatefulWidget {
  @override
  _LongContestHomeState createState() => _LongContestHomeState();
}

class _LongContestHomeState extends State<LongContestHome> {
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
                  child: Text('Long Contests'),
                ),
              ),
              Container(
                height: 300,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: longContest.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text('${index + 1}'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LongPreStart(
                                        duration: longContest[index]
                                            ['duration'],
                                        totalques: longContest[index]
                                            ['totalques'],
                                        totalmarks: longContest[index]
                                            ['totalmarks'],
                                        mcq: longContest[index]['mcq'],
                                        integer: longContest[index]['integer'],
                                        subject: longContest[index]['subject'],
                                        topic: longContest[index]['topic'],
                                        queBelongTo: longContest[index]
                                            ['queBelongTo'],
                                      )));
                        },
                        title: Text(longContest[index]['subject']),
                        subtitle: Text(longContest[index]['topic']),
                      );
                    }),
              )
            ],
          )),
    );
  }
}
