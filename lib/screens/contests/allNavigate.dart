import 'package:flutter/material.dart';
import 'package:jeeapp/screens/contests/shortHome.dart';
import 'package:jeeapp/screens/contests/overall/OverallHome.dart';
import 'package:jeeapp/screens/contests/long/longHome.dart';

class AllNavigater extends StatelessWidget {
  final String navigateTo;
  AllNavigater({this.navigateTo});

  @override
  Widget build(BuildContext context) {
    if (navigateTo == 'OverallContestHome')
      return OverallContestHome();
    else if (navigateTo == 'ShortContestHome')
      return ShortContestHome();
    else if (navigateTo == 'LongContestHome')
      return LongContestHome();
    else
      return Text('here in else block');
  }
}
