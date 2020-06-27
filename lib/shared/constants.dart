import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  //border: ,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 2.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pink, width: 2.0)),
);

const SizedBox sb20 = SizedBox(height: 20);
const SizedBox sb15 = SizedBox(height: 15);
const SizedBox sb10 = SizedBox(height: 10);
const SizedBox sb5 = SizedBox(height: 5);
const SizedBox sb3 = SizedBox(height: 3);

const SizedBox sbw20 = SizedBox(width: 20);
const SizedBox sbw10 = SizedBox(width: 10);
const SizedBox sbw15 = SizedBox(width: 15);

const TextStyle tsl =
    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22);

const TextStyle tsr =
    TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);
