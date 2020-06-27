class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String profilePiclink;
  final String uid;
  final String name;
  final String email;
  final String gender;
  final int worldRank;
  final int rating;
  final int stars;
  final int totalSubmission;
  final int correctSubmission;
  // final double accurecy;
  final int points;
  final List solvedQuestions;
  final List todoQuestions;
  final int finishedQuizes;

  UserData(
      {this.uid,
      this.email,
      this.name,
      this.gender,
      this.worldRank,
      this.rating,
      this.stars,
      this.totalSubmission,
      this.correctSubmission,
      //this.accurecy,
      this.points,
      this.solvedQuestions,
      this.todoQuestions,
      this.profilePiclink,
      this.finishedQuizes});
}
