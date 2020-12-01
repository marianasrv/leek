import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

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
          onPressed: () {},
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
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(20, 5, 10, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Divider(color: Color(0xFF1A633C)),
                  flex: 2,
                ),
                Expanded(
                  child: Text(listHeader[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1A633C),
                          fontSize: 13)),
                  flex: 1,
                ),
                Expanded(
                  child: Divider(color: Color(0xFF1A633C)),
                  flex: 2,
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
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF1A633C)),
                  ),
                  //elevation: 8.0,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: Image.asset(
                        'images/050-sun.png',
                        // width: 10,
                      )),
                );
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
}
