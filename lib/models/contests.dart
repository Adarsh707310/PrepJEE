class Contest {
  final String queBelongTo;
  final int duration;
  final int totalQue;
  int attemtedQue = 0;
  int unattemtedQue = 0;
  int correctAns = 0;
  int maximumMarks = 28;
  int incorrectAns = 0;
  int negetiveMarks = 0;
  int totalmarksScored = 0;
  String accuracy;
  List queStatus = ['', '', '', '', '', '', ''];
  int indexofmaparray = -1;

  Contest({this.queBelongTo, this.totalQue, this.duration});
}
