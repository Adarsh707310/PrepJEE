//import 'dart:io';
//import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:jeeapp/services/auth.dart';
import 'package:jeeapp/shared/loading.dart';
import 'package:jeeapp/shared/constants.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:firebase_storage/firebase_storage.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String name = '';
  String gender = 'Male';

  List genderInput = ['Male', 'Female', 'Prefere not to tell'];
  String password = '';
  String instaImagelink =
      'https://firebasestorage.googleapis.com/v0/b/jeeapp-2a139.appspot.com/o/picture%2Fbjvcxrchvb?alt=media&token=a108bc7b-5fc0-4a1f-a306-fd970a26866a';
  String profilePiclink;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blue[100],
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              elevation: 0.0,
              title: Text('Register'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Login')),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Name'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an name' : null,
                          onChanged: (val) {
                            setState(() => name = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        DropdownButtonFormField(
                          value: gender,
                          decoration: textInputDecoration,
                          items: genderInput.map((gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: Text('$gender'),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => gender = val),
                        ),
                        SizedBox(height: 20.0),
                        //Text(email),
                        TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) =>
                                val.isEmpty ? 'Enter an Email' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            }),
                        SizedBox(height: 10.0),
                        SizedBox(height: 10.0),
                        TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            obscureText: true,
                            validator: (val) => val.length < 6
                                ? 'Enter a password atleast 6 digit'
                                : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            }),

                        // Question Image
                        SizedBox(height: 20.0),
                        RaisedButton(
                          color: Colors.pink[400],
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email,
                                      password,
                                      name,
                                      gender,
                                      instaImagelink,
                                      1500);

                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                      'invalid email (maybe end-Space error)';
                                });
                              }
                            }
                          },
                        ),
                        error == ''
                            ? SizedBox(
                                height: 20.0,
                              )
                            : Text(
                                error,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0),
                              ),
                      ],
                    ),
                  )),
            ));
  }
}
