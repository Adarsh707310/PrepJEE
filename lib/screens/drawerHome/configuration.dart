import 'package:flutter/material.dart'
    show BoxShadow, Color, Colors, Icons, Offset;

Color primaryGreen = Color(0xff416d6d);
List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
];

List<Map> categories = [
  {
    'name': '    Maths',
    'iconPath': 'images/math.png',
    'queOfSubject': 'Mathematics'
  },
  {
    'name': '    Physics',
    'iconPath': 'images/physics.png',
    'queOfSubject': 'Physics'
  },
  {
    'name': '   OC',
    'iconPath': 'images/oc.png',
    'queOfSubject': 'Organic Chemistry'
  },
  {
    'name': '   IOC',
    'iconPath': 'images/ioc.png',
    'queOfSubject': 'Inorganic Chemistry'
  },
  {
    'name': '    PC',
    'iconPath': 'images/pc.png',
    'queOfSubject': 'Physical Chemistry'
  }
];

List<Map> drawerItems1 = [
  {'icon': Icons.book, 'title': 'To-Do', 'navigation': 'todoQuestions'},
  {'icon': Icons.favorite, 'title': 'Solved', 'navigation': 'solvedQuestions'},
];
List<Map> drawerItems2 = [
  {'icon': Icons.question_answer, 'title': 'Easy', 'navigation': 'Easy'},
  {'icon': Icons.queue, 'title': 'Medium', 'navigation': 'Medium'},
  {'icon': Icons.rate_review, 'title': 'Hard', 'navigation': 'Hard'},
];

List<Map> contests = [
  {
    'type': 'PCM Overall',
    'duration': '45',
    'totalques': '21',
    'totalmarks': '84',
    'mcq': '15',
    'integer': '6',
    'iconPath': 'images/overall.png',
    'navigateTo': 'OverallContestHome'
  },
  {
    'type': 'Individual Short',
    'duration': '15',
    'totalques': '7',
    'totalmarks': '28',
    'mcq': '5',
    'integer': '2',
    'iconPath': 'images/short.png',
    'navigateTo': 'ShortContestHome'
  },
  {
    'type': 'Individual Long',
    'duration': '60',
    'totalques': '25',
    'totalmarks': '100',
    'mcq': '20',
    'integer': '5',
    'iconPath': 'images/long.png',
    'navigateTo': 'LongContestHome'
  },
];

List<Map> shortContest = [
  {
    'queBelongTo': 'P&C_Short_contest',
    'duration': '15',
    'totalques': '7',
    'totalmarks': '28',
    'mcq': '5',
    'integer': '2',
    'subject': 'Mathematics',
    'topic': 'Permutation & Combination'
  }
];

List<Map> overallContest = [
  {
    'queBelongTo': 'PCM_Overall01_contest',
    'duration': '45',
    'totalques': '21',
    'totalmarks': '84',
    'mcq': '15',
    'integer': '6',
    'subject': 'PCM',
    'topic': 'All Topic'
  }
];

List<Map> longContest = [
  {
    'queBelongTo': 'C_Long01_contest',
    'duration': '60',
    'totalques': '25',
    'totalmarks': '100',
    'mcq': '20',
    'integer': '5',
    'subject': 'Chemistry',
    'topic': 'All chemistry Topic'
  }
];
