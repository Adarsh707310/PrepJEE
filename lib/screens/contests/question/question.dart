import 'package:flutter/material.dart';
import 'package:jeeapp/shared/constants.dart';
import 'package:jeeapp/services/database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:jeeapp/models/user.dart';

class Question extends StatefulWidget {
  final String qid;
  final bool likeButtonPressed;
  final int likes;
  final int point;
  final List answerMarked;
  final List options;
  final int pageCahnged;
  final String queText;
  final String queType;
  final String ansRemark;
  final List score;
  final Function updateEvalution;
  final String quePicturelink;
  final String solPicturelink;

  Question(
      {this.ansRemark,
      this.quePicturelink,
      this.solPicturelink,
      this.updateEvalution,
      this.score,
      this.options,
      this.queType,
      this.queText,
      this.answerMarked,
      this.point,
      this.qid,
      this.likeButtonPressed,
      this.likes,
      this.pageCahnged});

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  Color likeIconcolor = Colors.brown[100];
  Color reviewIconcolor = Colors.brown[100];
  bool likeButtonPressed = false;
  bool reviewButtonPressed = false;
  List optionShow = ['(a)', '(b)', '(c)', '(d)'];

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          sb10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Card(
                    elevation: 5.0,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.favorite),
                          color: likeIconcolor,
                          onPressed: () {
                            setState(() {
                              likeIconcolor = likeIconcolor == Colors.red
                                  ? Colors.brown[100]
                                  : Colors.red;

                              likeButtonPressed = !likeButtonPressed;
                            });

                            likeButtonPressed == true
                                ? DatabaseService().updateQuestionLike(
                                    widget.qid, widget.likes + 1)
                                : DatabaseService().updateQuestionLike(
                                    widget.qid, widget.likes - 1);
                          },
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(widget.likes.toString()),
                        sbw10,
                      ],
                    ),
                  ),
                  Card(
                    elevation: 5.0,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.check_box),
                          color: reviewIconcolor,
                          onPressed: () {
                            setState(() {
                              reviewIconcolor = reviewIconcolor == Colors.red
                                  ? Colors.brown[100]
                                  : Colors.red;
                            });
                            DatabaseService().updateUserContestTodoInsertions(
                                user.uid, widget.qid);
                          },
                        ),
                        Text('Todo'),
                        sbw10,
                      ],
                    ),
                  ),
                ],
              ),
              sb10,

              Row(children: <Widget>[
                Text(
                  widget.point.toString(),
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                ),
                sbw10,
                Icon(
                  FontAwesomeIcons.coins,
                  color: Colors.yellow[900],
                ),
                SizedBox(
                  width: 125,
                ),
                widget.answerMarked[widget.pageCahnged] != ''
                    ? CircleAvatar(
                        radius: 19,
                        backgroundColor: Colors.green,
                        child: Text(
                          widget.answerMarked[widget.pageCahnged].toUpperCase(),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : sbw20
              ]),

              sb10,
              widget.queText != ''
                  ? Text(
                      'Que: ' + widget.queText,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    )
                  : sb3,

              sb10,
              widget.quePicturelink == null
                  ? sb3
                  : Image.network(widget.quePicturelink),
              sb10,

              // show options orr intizers
              widget.queType == 'MCQ'
                  ? Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Options:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          sb15,
                          Text(
                            ' (a)  ' + widget.options[0],
                          ),
                          sb15,
                          Text(' (b)  ' + widget.options[1]),
                          sb15,
                          Text(' (c)  ' + widget.options[2]),
                          sb15,
                          Text(' (d)  ' + widget.options[3]),
                        ],
                      ))
                  : Container(
                      child: Column(
                      children: <Widget>[
                        Text('Integer Type Question: ' +
                            '( ' +
                            widget.ansRemark +
                            'hi' +
                            ' )'),
                        sb10,
                      ],
                    )),

              widget.score[widget.pageCahnged] != 0
                  ? Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5)),
                      margin: EdgeInsets.only(left: 220),
                      child: FlatButton(
                        child: Text(
                          'Reset',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        onPressed: () {
                          setState(() {
                            widget.answerMarked[widget.pageCahnged] = '';
                            widget.updateEvalution(widget.queType);
                          });
                        },
                      ),
                    )
                  : SizedBox(
                      height: 5,
                    ),
              sb3,
              widget.queType == 'MCQ'
                  ? widget.score[widget.pageCahnged] != 0
                      ? DropdownButtonFormField(
                          value: widget.answerMarked[widget.pageCahnged],
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Select option'),
                          items: optionShow.map((option) {
                            return DropdownMenuItem(
                              value: option,
                              child: Text('option $option'),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() =>
                                widget.answerMarked[widget.pageCahnged] = val);
                            widget.updateEvalution(widget.queType);
                          },
                        )
                      : DropdownButtonFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Select option'),
                          items: optionShow.map((option) {
                            return DropdownMenuItem(
                              value: option,
                              child: Text('option $option'),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() =>
                                widget.answerMarked[widget.pageCahnged] = val);
                            widget.updateEvalution(widget.queType);
                          },
                        )
                  : TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Write Answer Here'),
                      onChanged: (val) {
                        setState(() =>
                            widget.answerMarked[widget.pageCahnged] = val);
                        widget.updateEvalution(widget.queType);
                      },
                    ),
              sb3,
            ],
          ),
        ],
      ),
    );
  }
}
