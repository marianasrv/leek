import 'package:flutter/material.dart';

//import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PlagueDetector extends StatefulWidget {
  @override
  _PlagueDetectorState createState() => _PlagueDetectorState();
}

class _PlagueDetectorState extends State<PlagueDetector> {
  PickedFile _image;
  bool _isLoading = false;
  bool _pressed = false;
  var _popUpTitle;

  @override
  void initState() {
    super.initState();
    setState(() {
      _popUpTitle = 'Waiting for results...';
    });
    // final directory = await getApplicationDocumentsDirectory();
    // final path = directory.path;
    // print(path);
    // _image = File('$path/images/brand/folha_test.png');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.camera_alt_rounded,
            color: Color(0xFF3FAF73),
            size: 35,
          ),
          onPressed: () {
            _imgFromCamera();
            Navigator.of(context).pop();
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _titleAndProfile(),
            _buildCard(),
            _image == null
                ? Container()
                : Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin:
                            EdgeInsets.only(left: 40, right: 30, bottom: 50),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            File(_image.path),
                            width: 200,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      //_output != null ? Text("${_output}") : Container(),
                      //Spacer(),
                      _pressed
                          ? (_isLoading
                              ? Container(
                                  child: SpinKitRotatingCircle(
                                    color: Color(0xFF1A633C),
                                    size: 50.0,
                                    // controller: AnimationController(
                                    //   duration: const Duration(milliseconds: 3000),
                                  ),
                                )
                              : Padding(
                                  child: Text(
                                    'Your crops seems to be affected by "Common Rust"!',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  padding: EdgeInsets.fromLTRB(60, 5, 60, 5),
                                ))
                          : Container(),

                      _image == null
                          ? Container()
                          : Container(
                              margin: EdgeInsets.only(top: 235),
                              alignment: Alignment.bottomCenter,
                              child: FlatButton(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    color: Color(0xFF1A633C),
                                    padding:
                                        EdgeInsets.fromLTRB(15, 10, 15, 10),
                                    child: Text(
                                      'Start detection',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isLoading = true;
                                    _pressed = true;
                                  });

                                  Future.delayed(Duration(seconds: 3))
                                      .then((_) {
                                    setState(() {
                                      _isLoading = false;
                                      _popUpTitle = 'Done !';
                                    });
                                  });
                                },
                              ),
                            ),
                    ],
                  )
          ],
        ));
  }

  Widget _buildCard() {
    return Container(
        height: 150,
        width: 350,
        margin: const EdgeInsets.all(20.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8,
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Padding(
                    padding: EdgeInsets.only(top: 20, right: 10),
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(Icons.add_circle_outline_rounded,
                              color: Color(0xFF3FAF73), size: 30),
                          onPressed: () {
                            _imgFromGallery();
                          },
                        ),
                      ],
                    ))
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                      child: Text(
                        "Upload your images",
                        style: TextStyle(
                            color: Color(0xFF1A633C),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 11),
                      child: Text(
                        "Upload your previously\ntaken images",
                        style: TextStyle(
                            color: Color(0xFF1A633C),
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      )),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _titleAndProfile() {
    return Container(
        margin: EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding:
                    EdgeInsets.only(left: 30, top: 20, bottom: 10, right: 20),
                child: Text(
                  "Plague Detector",
                  style: TextStyle(
                      color: Color(0xFF1A633C),
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
                child: Column(children: [
                  Image.asset(
                    'images/users/carolina.png',
                    width: 70,
                    fit: BoxFit.fitWidth,
                  ),
                ])),
          ],
        ));
  }

  Future _imgFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = PickedFile(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    print(image.path);

    setState(() {
      //  _isLoading = true;
      _image = image;
    });
  }
}
