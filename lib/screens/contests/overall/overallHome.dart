import 'package:flutter/material.dart';
import 'package:jeeapp/screens/drawerHome/configuration.dart';
import 'package:jeeapp/screens/contests/overall/overallPreStart.dart';

class OverallContestHome extends StatefulWidget {
  @override
  _OverallContestHomeState createState() => _OverallContestHomeState();
}

class _OverallContestHomeState extends State<OverallContestHome> {
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
                  child: Text('Overall Contests'),
                ),
              ),
              Container(
                height: 300,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: overallContest.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text('${index + 1}'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OverallPreStart(
                                        duration: overallContest[index]
                                            ['duration'],
                                        totalques: overallContest[index]
                                            ['totalques'],
                                        totalmarks: overallContest[index]
                                            ['totalmarks'],
                                        mcq: overallContest[index]['mcq'],
                                        integer: overallContest[index]
                                            ['integer'],
                                        subject: overallContest[index]
                                            ['subject'],
                                        topic: overallContest[index]['topic'],
                                        queBelongTo: overallContest[index]
                                            ['queBelongTo'],
                                      )));
                        },
                        title: Text(overallContest[index]['subject']),
                        subtitle: Text(overallContest[index]['topic']),
                      );
                    }),
              )
            ],
          )),
    );
  }
}
