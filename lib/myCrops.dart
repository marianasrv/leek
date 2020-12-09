import 'package:flutter/material.dart';
import 'package:leek/data/Crop.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Crops extends StatefulWidget {
  @override
  _CropsState createState() => _CropsState();
}

class _CropsState extends State<Crops> {
  void generalInit() {
    Firestore.instance.collection('users').getDocuments().then((val) {
      if (val.documents.length > 0) {
        setState(() {
          crops = val.documents[0].data['myCrops'];
          user = val.documents[0].data;
          docId = 0;
        });
      } else {
        print("Not Found");
      }
      for (int i = 0; i < crops.length; i++) {
        if (crops[i]['type'] == 'fruit') {
          setState(() => fruits.add(crops[i]));
        } else if (crops[i]['type'] == 'herb') {
          setState(() => herbs.add(crops[i]));
        } else if (crops[i]['type'] == 'vegetable') {
          setState(() => vegetables.add(crops[i]));
        }
      }
    });
    Firestore.instance.collection('crops').getDocuments().then((val) {
      if (val.documents.length > 0) {
        setState(() {
          allCrops = val.documents.toList();
        });
      } else {
        print("Not Found");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    generalInit();
  }

  List<String> listHeader = ['Fruits', 'Vegetables', 'Herbs'];

  final _biggerFont = TextStyle(fontSize: 18.0);
  var vegetables = [];
  var fruits = [];
  var herbs = [];
  var crops = [];
  var allCrops = [];
  Map<String, dynamic> user;
  int docId;

  String dateFormat = DateFormat('EEEE').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add_rounded,
            color: Color(0xFF3FAF73),
            size: 40,
          ),
          onPressed: () {
            _addCrop();
          },
        ),
        body: Column(
          children: [
            _titleAndProfile(),
            Expanded(
              child: gridHeader(),
            ),
          ],
        ));
  }

  Widget gridHeader() {
    return new ListView.builder(
      itemCount: listHeader.length,
      itemBuilder: (context, index) {
        return new StickyHeader(
          header: Container(
            color: Color(0xFFFAFAFA),
            padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Divider(color: Color(0xFF1A633C)),
                  flex: 4,
                ),
                Expanded(
                  child: Text(listHeader[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1A633C),
                          fontSize: 13)),
                  flex: 3,
                ),
                Expanded(
                  child: Divider(color: Color(0xFF1A633C)),
                  flex: 4,
                ),
              ],
            ),
          ),
          content: Container(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: index == 0
                  ? fruits.length
                  : index == 1
                      ? vegetables.length
                      : herbs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                //childAspectRatio: 1,
                crossAxisSpacing: 30,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (contxt, indx) {
                return GestureDetector(
                    onTap: () {
                      Map<dynamic, dynamic> veg = index == 0
                          ? fruits[indx]
                          : index == 1
                              ? vegetables[indx]
                              : herbs[indx];
                      _openMyCrop(veg);
                    },
                    child: CircularPercentIndicator(
                        radius: 90,
                        percent: getPercentage(index == 0
                            ? fruits[indx]
                            : index == 1
                                ? vegetables[indx]
                                : herbs[indx]),
                        backgroundColor: Colors.transparent,
                        progressColor: Color(0xFF3FAF73),
                        center: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Color(0xFF1A633C)),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                index == 0
                                    ? fruits[indx]['imgPath']
                                    : index == 1
                                        ? vegetables[indx]['imgPath']
                                        : herbs[indx]['imgPath'],
                                // width: 10,
                              )),
                        )));
              },
            ),
          ),
        );
      },
      shrinkWrap: true,
    );
  }

  double getPercentage(Map<dynamic, dynamic> crop) {
    DateTime planted = crop['plant'].toDate();
    DateTime now = DateTime.now();
    int dif = now.difference(planted).inDays;

    if (dif == 0) {
      return 0.01;
    }
    if (dif / crop['timeToGrow'] > 1) {
      return 1.0;
    }
    return dif / crop['timeToGrow'];
  }

  void filterList() {
    setState(() => vegetables.removeRange(0, vegetables.length));
    Firestore.instance.collection('crops').getDocuments().then((val) {
      if (val.documents.length > 0) {
        setState(() => vegetables.add(val.documents[0].data));
      } else {
        print("Not Found");
      }
    });
  }

  void _openMyCrop(Map<dynamic, dynamic> veg) {
    showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          var width = MediaQuery.of(context).size.width;
          return new StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: new Container(
                  height: 210.0,
                  width: width - 10,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 12, 0, 0),
                                child: Text(veg['crop'],
                                    style: TextStyle(
                                        color: Color(0xFF1A633C),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                              ),
                              FlatButton(
                                padding: EdgeInsets.fromLTRB(80, 0, 0, 0),
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 30,
                                  color: Color(0xFF1A633C),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ]),
                        Row(children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: Column(children: [
                              CircularPercentIndicator(
                                  radius: 90,
                                  percent: getPercentage(veg),
                                  footer: getFooter(getPercentage(veg)),
                                  backgroundColor: Colors.transparent,
                                  progressColor: Color(0xFF3FAF73),
                                  center: Container(
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: Color(0xFF1A633C)),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.asset(
                                          veg['imgPath'],
                                          // width: 10,
                                        )),
                                  )),
                            ]),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Planted on: ' +
                                      DateFormat('dd/MM/yyyy')
                                          .format(veg['plant'].toDate()),
                                  style: TextStyle(
                                      color: Color(0xFF1A633C),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600)),
                              Text(
                                  'Estimated Harvest:\n' +
                                      DateFormat('dd MMMM yyyy').format(
                                          veg['plant'].toDate().add(
                                              new Duration(
                                                  days: veg['timeToGrow']))),
                                  style: TextStyle(
                                      color: Color(0xFF1A633C),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600))
                            ],
                          ),
                        ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RaisedButton(
                                  child: new Text('Remove',
                                      style: TextStyle(
                                          color: Color(0xFFA11F12),
                                          fontSize: 12)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side:
                                          BorderSide(color: Color(0xFFA11F12))),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _deleteCrop(veg);
                                    setState(() {
                                      crops = user['myCrops'];
                                    });
                                  })
                            ]),
                      ])),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
            );
          });
        });
  }

  Text getFooter(double val) {
    val = val * 100;
    return Text(val.round().toString() + "%",
        style: TextStyle(color: Color(0xFF1A633C), fontSize: 12));
  }

  void _deleteCrop(Map<dynamic, dynamic> veg) async {
    var tmp = [];
    for (int i = 0; i < user['myCrops'].length; i++) {
      if (user['myCrops'][i]['crop'] != veg['crop']) {
        tmp = tmp + [user['myCrops'][i]];
      }
    }
    user['myCrops'] = tmp;

    QuerySnapshot querySnapshot =
        await Firestore.instance.collection('users').getDocuments();
    querySnapshot.documents[docId].reference.updateData(user);

    setState(() => crops.removeRange(0, crops.length));
    setState(() => fruits.removeRange(0, fruits.length));
    setState(() => herbs.removeRange(0, herbs.length));
    setState(() => vegetables.removeRange(0, vegetables.length));
    generalInit();
  }

  Widget _titleAndProfile() {
    return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding:
                      EdgeInsets.only(left: 30, top: 20, bottom: 0, right: 20),
                  child: Image.asset(
                    'images/brand/logo.png',
                    //width: 120,
                    height: 50,
                    fit: BoxFit.fitHeight,
                  )),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
                child: Image.asset(
                  'images/users/carolina.png',
                  width: 70,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 6.0,
                      child: Row(children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(18, 10, 0, 10),
                            child: Text(dateFormat + ",",
                                style: TextStyle(
                                    color: Color(0xFF1A633C),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600))),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          child: Image.asset(
                            'images/weather/050-sun.png',
                            width: 20,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Text("10°",
                                style: TextStyle(
                                    color: Color(0xFF1A633C),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600))),
                      ]),
                    ),
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, top: 0, bottom: 10, right: 0),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                "My Crops",
                style: TextStyle(
                    color: Color(0xFF1A633C),
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              )
            ]),
          )
        ]));
  }

  void _addCrop() {
    showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          var width = MediaQuery.of(context).size.width;
          return new StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: new Container(
                  height: 290.0,
                  width: width - 10,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 40, 10),
                                    child: Text(
                                      "Add crop",
                                      style: TextStyle(
                                          color: Color(0xFF1A633C),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )),
                              ),
                              FlatButton(
                                padding: EdgeInsets.fromLTRB(80, 0, 0, 10),
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 30,
                                  color: Color(0xFF1A633C),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ]),

                        Expanded(
                            child: MyDialogContent(crops: allCrops), flex: 2)

                        //),
                      ])),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
            );
          });
        });
  }
}

class MyDialogContent extends StatefulWidget {
  MyDialogContent({this.crops});

  final crops;

  @override
  _MyDialogContentState createState() => new _MyDialogContentState();
}

class _MyDialogContentState extends State<MyDialogContent> {
  TextEditingController editingController = TextEditingController();
  var items = [];
  @override
  void initState() {
    super.initState();
  }

  String convertGrowthTime(int days) {
    if (days < 30) {
      return days.toString() + " days";
    } else if (days < 365) {
      var month = days ~/ 30;
      return month == 1
          ? month.toString() + " month"
          : (days ~/ 30).toString() + " months";
    } else {
      return "over 1 year";
    }
  }

  void filterSearchResults(value) {
    print(value);

    setState(() => items = []);

    for (int i = 0; i < widget.crops.length; i++) {
      if (value.isEmpty) {
        break;
      }
      if (widget.crops[i].data['name']
          .toString()
          .toLowerCase()
          .startsWith(value.toString())) {
        setState(() => items.add(widget.crops[i].data));
      }
    }
    print("items");
    print(items);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: TextField(
          onChanged: (value) {
            filterSearchResults(value);
          },
          controller: editingController,
          decoration: InputDecoration(
            isDense: true,
            hintText: "Search...",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
          ),
        ),
      ),
      items.isEmpty
          ? Container()
          : Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Card(
                        elevation: 5,
                        margin: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.all(4),
                          leading: Image.asset(
                            items[index]['imgPath'],
                            width: 40,
                            fit: BoxFit.fitWidth,
                          ),
                          title: Text(items[index]['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A633C),
                                fontSize: 15,
                              )),
                          subtitle: Text(
                            convertGrowthTime(items[index]['timeToGrow']),
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF1A633C),
                                fontSize: 12),
                          ),
                          trailing: FlatButton(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: Color(0xFF1A633C),
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  'Add to my crops',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ));
                  }),
              flex: 3,
            )
    ]);
  }
}
