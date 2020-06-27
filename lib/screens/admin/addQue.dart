//import 'dart:html';
import 'dart:io';
//import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeeapp/shared/loading.dart';
import 'package:jeeapp/shared/constants.dart';
import 'package:jeeapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:jeeapp/models/user.dart';
//import 'package:flutter_image_compress/flutter_image_compress.dart';

class AddQue extends StatefulWidget {
  @override
  _AddQueState createState() => _AddQueState();
}

class _AddQueState extends State<AddQue> {
  //final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String error = '';
  bool loading = false;

  String qid;
  String subject;
  List subjectList = [
    'Mathematics',
    'Physics',
    'Physical Chemistry',
    'Organic Chemistry',
    'Inorganic Chemistry'
  ];
  String queText;
  String queType = 'Integer';
  List queTypeList = ['MCQ', 'Integer'];
  int timeSecond;
  List timereqList = [100, 115, 130, 145, 160];
  String label;
  List labelList = ['Easy', 'Medium', 'Hard'];

  List options = ['(a)', '(b)', '(c)', '(d)'];
  int points;
  List pointList = [100, 250, 500];
  double accurecy;
  String ansRemark;
  String answer;
  List ansOptions = ['(a)', '(b)', '(c)', '(d)'];
  String quePicturelink;
  String solPicturelink;

  File _image, _image1;
  final picker = ImagePicker();
/*
  // 2. compress file and get file.
  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: 30,
      //rotate: 180,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  Future getImageForQuePicture() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    final result =
        await testCompressAndGetFile(File(pickedFile.path), pickedFile.path);

    setState(() {
      loading = true;
      _image = result;
    });

    FirebaseStorage fs = FirebaseStorage.instance;
    StorageReference rootReference = fs.ref();
    StorageReference pictureFolderRef =
        rootReference.child("quepicture").child(DateTime.now().toString());
    pictureFolderRef.putFile(_image).onComplete.then((storageTask) async {
      String link = await storageTask.ref.getDownloadURL();

      setState(() {
        quePicturelink = link;
        loading = false;
      });
    });
  }
*/
  Future getImageForSolPicture(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      _image = File(pickedFile.path);
    });

    FirebaseStorage fs = FirebaseStorage.instance;
    StorageReference rootReference = fs.ref();
    StorageReference pictureFolderRef =
        rootReference.child("solpicture").child(DateTime.now().toString());
    pictureFolderRef.putFile(_image).onComplete.then((storageTask) async {
      String link = await storageTask.ref.getDownloadURL();

      setState(() {
        solPicturelink = link;
      });
    });
  }

  Future getImageForQuePicture(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      _image1 = File(pickedFile.path);
    });

    FirebaseStorage fs = FirebaseStorage.instance;
    StorageReference rootReference = fs.ref();
    StorageReference pictureFolderRef =
        rootReference.child("quepicture").child(DateTime.now().toString());
    pictureFolderRef.putFile(_image1).onComplete.then((storageTask) async {
      String link = await storageTask.ref.getDownloadURL();

      setState(() {
        quePicturelink = link;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blue[100],
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              elevation: 0.0,
              title: Text('Add question'),
            ),
            body: SingleChildScrollView(
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        // Subject
                        /*  SizedBox(height: 20.0),
                        DropdownButtonFormField(
                          value: subject,
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Subject'),
                          items: subjectList.map((subject) {
                            return DropdownMenuItem(
                              value: subject,
                              child: Text('$subject'),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => subject = val),
                        ),*/

                        // Question Type
                        /*SizedBox(height: 20.0),
                        DropdownButtonFormField(
                          value: queType,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Question Type'),
                          items: queTypeList.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text('$type'),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => queType = val),
                        ),*/

                        // Questions Statment
                        /*SizedBox(height: 20.0),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Question Statment'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an Statment' : null,
                          onChanged: (val) {
                            setState(() => queText = val);
                          },
                        ),*/

                        // Question Image
                        SizedBox(height: 20.0),
                        FloatingActionButton(
                          heroTag: "btn1",
                          onPressed: () =>
                              getImageForQuePicture(ImageSource.gallery),
                          tooltip: 'Pick Image',
                          child: Icon(Icons.add_a_photo),
                        ),

                        quePicturelink == null
                            ? Text('No image selected yet')
                            : Image.network(quePicturelink),

                        // options
                        queType == 'MCQ'
                            ? Container(
                                margin: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 20.0),
                                    Text('Enter options'),
                                    SizedBox(height: 8.0),
                                    TextFormField(
                                        decoration: textInputDecoration
                                            .copyWith(hintText: 'option (a)'),
                                        onChanged: (val) {
                                          setState(() => options[0] = val);
                                        }),
                                    SizedBox(height: 20.0),
                                    TextFormField(
                                        decoration: textInputDecoration
                                            .copyWith(hintText: 'option (b)'),
                                        onChanged: (val) {
                                          setState(() => options[1] = val);
                                        }),
                                    SizedBox(height: 20.0),
                                    TextFormField(
                                        decoration: textInputDecoration
                                            .copyWith(hintText: 'option (c)'),
                                        onChanged: (val) {
                                          setState(() => options[2] = val);
                                        }),
                                    SizedBox(height: 20.0),
                                    TextFormField(
                                        decoration: textInputDecoration
                                            .copyWith(hintText: 'option (d)'),
                                        onChanged: (val) {
                                          setState(() => options[3] = val);
                                        }),
                                  ],
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 20.0),
                                    TextFormField(
                                        decoration:
                                            textInputDecoration.copyWith(
                                                hintText: 'Answer Remark'),
                                        onChanged: (val) {
                                          setState(() => ansRemark = val);
                                        }),
                                  ],
                                )),

                        // Label
                        /* SizedBox(height: 20.0),
                        DropdownButtonFormField(
                          value: label,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Difficulty Label'),
                          items: labelList.map((label) {
                            return DropdownMenuItem(
                              value: label,
                              child: Text('$label'),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => label = val),
                        ),*/

                        // Time Required
                        /* SizedBox(height: 20.0),
                        DropdownButtonFormField(
                          value: timeSecond,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Time Required (in Sec)'),
                          items: timereqList.map((time) {
                            return DropdownMenuItem(
                              value: time,
                              child: Text('$time Seconds'),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => timeSecond = val),
                        ),*/

                        // Points
                        SizedBox(height: 20.0),
                        DropdownButtonFormField(
                          value: points,
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Points'),
                          items: pointList.map((point) {
                            return DropdownMenuItem(
                              value: point,
                              child: Text('$point points'),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => points = val),
                        ),

                        SizedBox(height: 30.0),
                        Text('Answers: '),
                        SizedBox(height: 8.0),

                        queType == 'MCQ'
                            ? Container(
                                child: DropdownButtonFormField(
                                  value: null,
                                  decoration: textInputDecoration.copyWith(
                                      hintText: 'Points'),
                                  items: ansOptions.map((option) {
                                    return DropdownMenuItem(
                                      value: option,
                                      child: Text('option $option'),
                                    );
                                  }).toList(),
                                  onChanged: (val) =>
                                      setState(() => answer = val),
                                ),
                              )
                            : Container(
                                child: TextFormField(
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'Answer'),
                                    onChanged: (val) {
                                      setState(() => answer = val);
                                    }),
                              ),

                        // Solution Image
                        SizedBox(height: 20.0),
                        FloatingActionButton(
                          heroTag: "btn2",
                          onPressed: () =>
                              getImageForSolPicture(ImageSource.gallery),
                          tooltip: 'Pick Image',
                          child: Icon(Icons.add_a_photo),
                        ),

                        solPicturelink == null
                            ? Text('No image selected yet')
                            : Image.network(solPicturelink),

                        SizedBox(height: 20.0),
                        RaisedButton(
                          color: Colors.pink[400],
                          child: Text(
                            'Add to collections',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              //setState(() => loading = true);

                              await DatabaseService(uid: user.uid)
                                  .addQuestionTodataDase(
                                      answer.toString(),
                                      'Chemistry',
                                      'Integer',
                                      '',
                                      '',
                                      'Medium',
                                      quePicturelink,
                                      solPicturelink,
                                      'C_Long01_contest',
                                      options,
                                      points,
                                      130);

                              if (true) {
                                setState(() {
                                  loading = false;
                                  error = 'so far so good ';
                                });
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddQue()));
                              }
                            }
                          },
                        ),
                        error == ''
                            ? Text(
                                'error',
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0),
                              )
                            : Text(
                                error,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 14.0),
                              ),
                      ],
                    ),
                  )),
            ),
          );
  }
}
