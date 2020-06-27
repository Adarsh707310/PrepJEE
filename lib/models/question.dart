import 'package:flutter/cupertino.dart';

class Question {
  final String answer;
  final List topicTags;
  final String subject;
  final String queText;
  final String queType;
  final int timeSecond;
  final String label;
  final Image quePicturelink;
  final List options;
  final int points;
  final String ansRemark;
  final Image solPicturelink;
  final int appried = 0;
  final int peopleAttemted = 0;
  final int peopleAttemtedCorrectly = 0;
  //final double accurecy = null;
  final int likes = 0;
  final List discussion = [];

  Question(
      {this.ansRemark,
      this.topicTags,
      this.answer,
      this.queType,
      this.subject,
      this.queText,
      this.timeSecond,
      this.label,
      this.quePicturelink,
      this.options,
      this.points,
      this.solPicturelink});
}

class QuestionData {
  final String subject;
  final String answer;
  final String queText;
  final String queType;
  final String label;
  final String quePicturelink;
  final String ansRemark;
  final String solPicturelink;
  final int timeSecond;
  final int points;
  final int appried;
  final int peopleAttemted;
  final int peopleAttemtedCorrectly;
  final int likes;
  final List discussion;
  final List topicTags;
  final List options;
  // final double accurecy;

  QuestionData({
    this.topicTags,
    this.answer,
    this.subject,
    this.queText,
    this.queType,
    this.timeSecond,
    this.label,
    this.quePicturelink,
    this.options,
    this.points,
    this.ansRemark,
    this.solPicturelink,
    this.appried,
    this.peopleAttemted,
    this.peopleAttemtedCorrectly,
    // this.accurecy,
    this.likes,
    this.discussion,
  });
}
