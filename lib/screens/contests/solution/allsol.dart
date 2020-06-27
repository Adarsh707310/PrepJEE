import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jeeapp/shared/constants.dart';

class Solution extends StatefulWidget {
  final List answerMarked;
  final String queBelongTo;

  Solution({this.answerMarked, this.queBelongTo});

  @override
  _SolutionState createState() => _SolutionState();
}

class _SolutionState extends State<Solution> {
  @override
  void initState() {
    super.initState();
    print(widget.answerMarked);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('questions')
            .where("queBelongTo", isEqualTo: widget.queBelongTo)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Scaffold(
              body: Center(
                child: Container(height: 600, child: Text('Loading')),
              ),
            );
          return Scaffold(
            appBar: AppBar(
                elevation: 5,
                title: Text('Soln: ' + widget.queBelongTo.toString())),
            body: SingleChildScrollView(
                child: Container(
              height: 550,
              child: ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '   Question: ${index + 1}',
                              style: TextStyle(
                                  color: Colors.red[600], fontSize: 20),
                            ),
                            Text(
                              snapshot.data.documents[index]['queType'] +
                                  ' Type',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(snapshot.data.documents[index]['subject'],
                                style: TextStyle(fontWeight: FontWeight.w700)),
                          ],
                        ),
                        sb5,
                        snapshot.data.documents[index]['queText'] != ''
                            ? Text(
                                snapshot.data.documents[index]['queText'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              )
                            : sb3,
                        sb10,
                        snapshot.data.documents[index]['quePicturelink'] == null
                            ? sb3
                            : Image.network(snapshot.data.documents[index]
                                ['quePicturelink']),
                        sb10,
                        snapshot.data.documents[index]['queType'] == 'MCQ'
                            ? Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Options:',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    sb15,
                                    Text(
                                      ' (a)  ' +
                                          snapshot.data.documents[index]
                                              ['options'][0],
                                    ),
                                    sb15,
                                    Text(' (b)  ' +
                                        snapshot.data.documents[index]
                                            ['options'][1]),
                                    sb15,
                                    Text(' (c)  ' +
                                        snapshot.data.documents[index]
                                            ['options'][2]),
                                    sb15,
                                    Text(' (d)  ' +
                                        snapshot.data.documents[index]
                                            ['options'][3]),
                                  ],
                                ))
                            : sb3,
                        sb10,
                        Text(
                          '   Solution: ${index + 1}',
                          style:
                              TextStyle(color: Colors.blue[600], fontSize: 20),
                        ),
                        sb10,
                        snapshot.data.documents[index]['solPicturelink'] == null
                            ? Text('   Solution not Required')
                            : Image.network(snapshot.data.documents[index]
                                ['solPicturelink']),
                        sb10,
                        Text('Correct Answer: ' +
                            snapshot.data.documents[index]['answer']),
                        sb5,
                        widget.answerMarked[index] != ''
                            ? Text('Answer Marked be You: ' +
                                widget.answerMarked[index])
                            : Text('Unattemted'),
                        sb10,
                        Divider(
                          height: 15,
                          indent: 0,
                          endIndent: 8,
                          thickness: 3,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  );
                },
              ),
            )),
          );
        });
  }
}
