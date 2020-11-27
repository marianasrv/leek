import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PlagueDetector extends StatefulWidget {


  @override
  _PlagueDetectorState createState() => _PlagueDetectorState();
}

class _PlagueDetectorState extends State<PlagueDetector> {
  File _image;
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _titleAndProfile(),
            _buildCard(),
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
        ), elevation: 8,
          child: Column(
            children:[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top:30, right: 10),
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.add_circle_outline_rounded, color: Color(0xFF3FAF73), size:30),
                            onPressed:() {
                          _imgFromGallery();
                          Navigator.of(context).pop();
                          },
                          ),
                        ],
                      ))
                ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Padding(padding: EdgeInsets.all(10),

                    child: Text(
                      "Upload your images",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                    ),
                  ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Padding(padding: EdgeInsets.only(left:10),

                      child: Text(
                        "Upload previously taken images",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      )
                  ),
                ],
              ),

            ],
          ),

    )
    );

  }

  Widget _titleAndProfile(){

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(padding: EdgeInsets.only(left: 30, top: 20, bottom:10, right: 20),

              child: Text(
                "Plague Detector",
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              )
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 30, 10),
              child: Column(children: [
                Image.asset(
                  'images/050-sun.png',
                  width: 40,
                  fit: BoxFit.fitWidth,
                ),
              ])),

      ],
    );

  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async{

    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }
}