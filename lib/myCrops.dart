import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Crops extends StatefulWidget {
  @override
  _CropsState createState() => _CropsState();
}

class _CropsState extends State<Crops> {
  TextEditingController editingController = TextEditingController();
  List<String> listHeader = ['Fruits', 'Vegetables', 'Herbs'];

  final _biggerFont = TextStyle(fontSize: 18.0);

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
              flex: 6,
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
            padding: EdgeInsets.fromLTRB(20, 5, 10, 20),
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
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                //childAspectRatio: 1,
                crossAxisSpacing: 30,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (contxt, indx) {
                return CircularPercentIndicator(
                    radius: 90,
                    percent: 0.4,
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
                            'images/050-sun.png',
                            // width: 10,
                          )),
                    ));
              },
            ),
          ),
        );
      },
      shrinkWrap: true,
    );
  }

  Widget _titleAndProfile() {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding:
                  EdgeInsets.only(left: 30, top: 20, bottom: 10, right: 20),
              child: Image.asset(
                'images/logo.png',
                //width: 120,
                height: 40,
                fit: BoxFit.fitHeight,
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
            child: Image.asset(
              'images/050-sun.png',
              width: 40,
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
                        child: Text("Saturday,",
                            style: TextStyle(
                                color: Color(0xFF1A633C),
                                fontSize: 15,
                                fontWeight: FontWeight.w600))),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Image.asset(
                        'images/050-sun.png',
                        width: 20,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                        child: Text("35°",
                            style: TextStyle(
                                color: Color(0xFF1A633C),
                                fontSize: 15,
                                fontWeight: FontWeight.w600))),
                  ]),
                ),
              ))
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 30, top: 5, bottom: 10, right: 20),
              child: Text(
                "My Crops",
                style: TextStyle(
                    color: Color(0xFF1A633C),
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ))
        ],
      )
    ]);
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
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                            child: TextField(
                              onChanged: (value) {
                                //filterSearchResults(value);
                              },
                              controller: editingController,
                              decoration: InputDecoration(
                                  isDense: true,
                                  hintText: "Search...",
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0)))),
                            ),
                          ),
                        ),
                        //Expanded(
                        // flex: 3,
                        _resultCrop(),
                        //),
                      ])),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
            );
          });
        });
  }

  Widget _resultCrop() {
    return Card(
        elevation: 5,
        margin: const EdgeInsets.fromLTRB(4, 10, 4, 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          dense: true,
          contentPadding: const EdgeInsets.all(4),
          leading: Image.asset(
            'images/050-sun.png',
            width: 40,
            fit: BoxFit.fitWidth,
          ),
          title: Text('Parsley',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A633C),
                fontSize: 16,
              )),
          subtitle: Text(
            '3 months',
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
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
            onPressed: () {},
          ),
        ));
  }
}
