//import 'package:flutter/cupertino.dart';
//import 'package:flutter/cupertino.dart';
import 'package:jeeapp/models/question.dart';
import 'package:jeeapp/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

//******************************************************** Question ************************************************************************************ //

  final CollectionReference questionsCollection =
      Firestore.instance.collection('questions');

  Future<void> addQuestionTodataDase(
      String answer,
      String subject,
      String queType,
      String queText,
      String ansRemark,
      String label,
      String quePicturelink,
      String solPicturelink,
      String queBelongTo,
      List options,
      int points,
      int timeSecond) async {
    String qid = subject.split(' ')[0] + DateTime.now().toString();
    return await questionsCollection.document(qid).setData({
      'qid': qid,
      'queBelongTo': queBelongTo,
      'answer': answer,
      'subject': subject,
      'queType': queType,
      'queText': queText,
      'ansRemark': ansRemark,
      'label': label,
      'quePicturelink': quePicturelink,
      'solPicturelink': solPicturelink,
      'options': options,
      'points': points,
      'timeSecond': timeSecond,
      'topicTags': [],
      'appried': 0,
      'peopleAttemted': 0,
      'peopleAttemtedCorrectly': 0,
      //'accurecy': null,
      'likes': 0,
      'discussion': [],
    });
  }

  Future<void> updateQuestionLike(String qid, int likes) async {
    return await questionsCollection
        .document(qid)
        .updateData({'likes': likes}).whenComplete(() async {
      print("Completed");
    }).catchError((e) => print(e));
  }

  List<QuestionData> _questionsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return QuestionData(
        answer: doc.data['answer'],
        subject: doc.data['subject'],
        queText: doc.data['queText'],
        queType: doc.data['queType'],
        label: doc.data['label'],
        quePicturelink: doc.data['quePicturelink'],
        ansRemark: doc.data['ansRemark'],
        solPicturelink: doc.data['solPicturelink'],
        timeSecond: doc.data['timeSecond'],
        points: doc.data['points'],
        appried: doc.data['appried'],
        peopleAttemted: doc.data['peopleAttemted'],
        peopleAttemtedCorrectly: doc.data['peopleAttemtedCorrectly'],
        likes: doc.data['likes'],
        options: doc.data['options'],
        topicTags: doc.data['answer'],
        discussion: doc.data['discussion'],
        //accurecy: doc.data['accurecy'],
      );
    }).toList();
  }

  Stream<List<QuestionData>> get questions {
    return questionsCollection.snapshots().map(_questionsListFromSnapshot);
  }

  // ******************************************************** Usersdata ************************************************************************************ //

  // collection reference
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  // points
  Future<void> updateUserContestIncriments(String uid, int points,
      int correctQue, int rating, int totalSubmission) async {
    return await usersCollection.document(uid).updateData({
      "points": FieldValue.increment(points),
      "correctSubmission": FieldValue.increment(correctQue),
      "finishedQuizes": FieldValue.increment(1),
      "rating": FieldValue.increment(rating),
      "totalSubmission": FieldValue.increment(totalSubmission)
    });
  }

  Future<void> updateUserContestSolvedInsertions(String uid, String qid) async {
    return await usersCollection.document(uid).updateData({
      "solvedQuestions": FieldValue.arrayUnion([qid])
    });
  }

  Future<void> updateUserContestTodoInsertions(String uid, String qid) async {
    return await usersCollection.document(uid).updateData({
      "todoQuestions": FieldValue.arrayUnion([qid])
    });
  }

  Future<void> updateUserData(String email, String name, String gender,
      String profilePiclink, int rating) async {
    await Firestore.instance
        .collection('appInformation')
        .document(uid)
        .setData({
      'rating': rating,
    });

    return await usersCollection.document(uid).setData({
      'uid': uid,
      'name': name,
      'email': email,
      'gender': gender,
      'worldRank': 0,
      'rating': 1500,
      'stars': 1,
      'totalSubmission': 0,
      'correctSubmission': 0,
      //'accurecy': null,
      'points': 0,
      'solvedQuestions': [],
      'todoQuestions': [],
      'profilePiclink': profilePiclink,
      'finishedQuizes': 0,
    });
  }

// user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      email: snapshot.data['email'],
      gender: snapshot.data['gender'],
      worldRank: snapshot.data['worldRank'],
      rating: snapshot.data['rating'],
      stars: snapshot.data['stars'],
      totalSubmission: snapshot.data['totalSubmission'],
      correctSubmission: snapshot.data['correctSubmission'],
      //accurecy: snapshot.data['accurecy'],
      points: snapshot.data['points'],
      solvedQuestions: snapshot.data['solvedQuestions'],
      todoQuestions: snapshot.data['todoQuestions'],
      profilePiclink: snapshot.data['profilePiclink'],
      finishedQuizes: snapshot.data['finishedQuizes'],
    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    return usersCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

// ******************************************************** Users - contest  ************************************************************************************ //

  final CollectionReference contestCollection =
      Firestore.instance.collection('contests');

  Future<void> updateLongResult(int score, String contest, String uidd) async {
    return await contestCollection
        .document(contest)
        .collection('students')
        .document(uidd)
        .setData({
      'score': score,
    });
  }
}
