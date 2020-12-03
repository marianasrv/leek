import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  TextEditingController editingController = TextEditingController();
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = TextStyle(fontSize: 18.0);
  bool  _typeHerbs = false;
  bool  _typeVegetable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Column(children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Icon(
                  Icons.calendar_today_rounded,
                  color: Color(0xFF3FAF73),
                  size: 25,
                )),
            Text('NOV',
                style: TextStyle(
                    color: Color(0xFF3FAF73),
                    fontSize: 12,
                    fontWeight: FontWeight.w600))
          ]),
          onPressed: () {},
        ),
        body: Column(
          children: [
            _titleAndProfile(),
            _searchAndFilter(),
            Expanded(
              flex: 8,
              child: _buildCrops(),
            ),
          ],
        ));
  }

  Widget _buildCard(int index) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8.0,
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: Column(children: [
                      Image.asset(
                        'images/050-sun.png',
                        width: 40,
                        fit: BoxFit.fitWidth,
                      ),
                    ])),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Icon(
                          Icons.add_circle_outline_rounded,
                          color: Color(0xFF3FAF73),
                          size: 30,
                        )
                      ],
                    )),
              ]),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  children: [
                    Text(
                      "CropName",
                      style: TextStyle(
                          color: Color(0xFF1A633C),
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                child: Row(
                  children: [
                    Text("26/11/2020",
                        style:
                            TextStyle(color: Color(0xFF1A633C), fontSize: 13))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildCrops() {
    return GridView.count(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: List.generate(10, (index) {
          return _buildCard(index);
        }));
  }

    void _showcontent() {
    showDialog(
        context: context, barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          var width = MediaQuery.of(context).size.width;
          return new StatefulBuilder(
            builder: (context, setState) {
            return AlertDialog(
            content: new Container(
                height: 230.0,
                width: width - 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              "Type of Crop",
                              style: TextStyle(
                                  color: Color(0xFF1A633C),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                          )),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                              child: new RaisedButton(
                                  child: new Text('Herbs',
                                      style: TextStyle(
                                          color:  _typeHerbs? Colors.white : Color(0xFF1A633C),
                                          fontSize: 12)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Color(0xFF1A633C))
                                  ),
                                  color: _typeHerbs? Color(0xFF1A633C): Colors.white ,
                                  onPressed: () => setState(() => _typeHerbs = !_typeHerbs),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                              child: new RaisedButton(
                                color: _typeVegetable? Color(0xFF1A633C): Colors.white ,
                                child: new Text('Vegetable',
                                        style: TextStyle(
                                        color:  _typeVegetable? Colors.white : Color(0xFF1A633C) ,
                                        fontSize: 12)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Color(0xFF1A633C))
                                ),
                                onPressed: () => setState(() => _typeVegetable = !_typeVegetable),
                              ),
                            )
                          ],

                        )

                      ]
                    )
                  ],
                )
              ),
            actions: [
              new FlatButton(
                child: new Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          );
          }
        );
        },
      );
    }

    void _changeFilter(filter){

      setState(() {
        _typeVegetable = !_typeVegetable;
      });


    }

    Widget _searchAndFilter() {
    return Column(children: [
      Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
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
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
          ),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 6.0,
                      child: GestureDetector(
                          onTap: (){ _showcontent();},
                          child: Row(children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(12, 10, 0, 10),
                            child: Text("Filters",
                                style: TextStyle(
                                    color: Color(0xFF1A633C), fontSize: 13))),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            child: Icon(
                              Icons.filter_list_alt,
                              color: Color(0xFF1A633C),
                              size: 25,
                            ))
                      ],
                      )),
                    ),
                  )))
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 25, top: 10, bottom: 10),
        child: Row(children: [
          Text("Most popular in ",
              style: TextStyle(color: Color(0xFF1A633C), fontSize: 14)),
          Text("November",
              style: TextStyle(
                  color: Color(0xFF1A633C),
                  fontSize: 14,
                  fontWeight: FontWeight.w700)),
        ]),
      )
    ]);
  }

  Widget _titleAndProfile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 30, top: 20, bottom: 10, right: 20),
            child: Text(
              "Crops Calendar",
              style: TextStyle(
                  color: Color(0xFF1A633C),
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            )),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 20, 10),
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
}
