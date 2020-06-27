import 'package:flutter/material.dart';
import 'package:jeeapp/shared/constants.dart';

class Guide extends StatefulWidget {
  @override
  _GuideState createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.blue[300],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 5.0,
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                        sb10,
                        Text('Platform Developed by Adarsh Jain'),
                        Text('( IIT Jodhpur )'),
                        sb20,
                        Text('PrepJEE: Level up you problem solving skills.'),
                      ],
                    )),
              ),
              Card(
                elevation: 5.0,
                child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            'PrepJEE assist you in you JEE preparation with lots of features: '),
                        sb20,
                        Text(
                          'Practice: ',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        sb20,
                        Text(
                            'Keeps Track of "Solved" and "Review later" Questions'),
                        sb5,
                        Text(
                            'Allows you to Set Difficuly label you want to practice for'),
                        sb5,
                        Text(
                            'You will build you profile on the way, earning Question points'),
                        sb5,
                        Text(
                            'Average Solving time gives you a idea for your question solving speed'),
                        sb5,
                        Text(
                            'you can sort question on the bases of there accuracy and practice accordingly'),
                        sb5,
                        Text('Question likes gives you Que\'s popularity idea'),
                        sb20,
                        Text(
                          'Evaluation: ',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        sb20,
                        Text(
                            'According to the survey done on over 1M sudents and analysis made be our sintists, Students needs a lot of mental preparation to take part in a test of same pattern and duration as JEE Examination.'),
                        sb10,
                        Text('So, here is PrepJEE with all its short Contests'),
                        sb10,
                        Text(
                          'Individual Short: ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        sb3,
                        Text(
                            'Contest of 15 minuts duration, with total 7 Questions of the selected subject out of which 5 are MCQs and 2 are of Integer Type'),
                        sb10,
                        Text(
                          'PCM Overall: ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        sb3,
                        Text(
                            'Contest of 45 minuts duration, with total 21 Questions, 7 for each Physics, Chemistry and Mathmatics out of which 5 are MCQs and 2 are of Integer Type'),
                        sb10,
                        Text(
                          'Individual Long: ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        sb3,
                        Text(
                            'Contest of 60 minuts duration, with total 25 Questions of the selected subject out of which 20 are MCQs and 5 are of Integer Type'),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
