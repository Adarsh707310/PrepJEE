import 'package:flutter/material.dart';
import 'package:jeeapp/screens/practice/labelwise.dart';

class PreLabelWise extends StatefulWidget {
  final String label;
  PreLabelWise({this.label});

  @override
  _PreLabelWiseState createState() => _PreLabelWiseState();
}

class _PreLabelWiseState extends State<PreLabelWise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[600],
        body: Stack(children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 40, left: 20, right: 20),
            child: LabelWisePractice(label: widget.label),
          )
        ]));
  }
}
