import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'data/Month.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('crops').getDocuments().then((val) {
      if (val.documents.length > 0) {
        for (int i = 0; i < val.documents.length; i++) {
          if (_months[_currentMonth].toLowerCase() ==
              val.documents[i].data['bestMonth']) {
            setState(() => vegetables.add(val.documents[i].data));
          }
        }
      } else {
        print("Not Found");
      }
    });

    Firestore.instance.collection('users').getDocuments().then((val) {
      if (val.documents.length > 0) {
        for (int i = 0; i < val.documents.length; i++) {
          if (val.documents[i].data['name'] == 'Carolina')
            setState(() {
              user = (val.documents[i].data);
              docId = i;
            });
        }
      } else {
        print("Not Found");
      }
    });
  }

  TextEditingController editingController = TextEditingController();
  final _suggestions = <WordPair>[];
  final Map<String, String> _months = {
    'JAN': 'January',
    'FEV': 'February',
    'MAR': 'March',
    'APR': 'April',
    'MAY': 'May',
    'JUN': 'June',
    'JUL': 'July',
    'AUG': 'August',
    'SEP': 'September',
    'OCT': 'October',
    'NOV': 'November',
    'DEC': 'December'
  };
  var _currentMonth = DateFormat('MMM').format(DateTime.now()).toUpperCase();
  String monthFormat = DateFormat('MMMM').format(DateTime.now());
  var vegetables = [];

  final _saved = Set<WordPair>();
  final _biggerFont = TextStyle(fontSize: 18.0);
  var selectedRange = RangeValues(0, 24);
  bool _typeHerbs = false;
  bool _typeVegetable = false;
  bool _typeFruit = false;
  bool _isEasy = false;
  bool _isMedium = false;
  bool _isHard = false;
  bool _isMonthsOpen = false;
  String name;
  Map<String, dynamic> user;
  int docId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: _isMonthsOpen
              ? Center(
                  child: Icon(
                  Icons.close_rounded,
                  color: Color(0xFF3FAF73),
                  size: 40,
                ))
              : Column(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Icon(
                        Icons.calendar_today_rounded,
                        color: Color(0xFF3FAF73),
                        size: 25,
                      )),
                  Text(_currentMonth,
                      style: TextStyle(
                          color: Color(0xFF3FAF73),
                          fontSize: 12,
                          fontWeight: FontWeight.w600))
                ]),
          onPressed: () {
            //_isMonthsOpen ? Navigator.of(context).pop() :
            //_monthsWindow();
            setState(() => _isMonthsOpen = !_isMonthsOpen);
          },
        ),
        body: Stack(
          children: [
            Column(children: [
              _titleAndProfile(),
              _searchAndFilter(),
              Expanded(
                flex: 8,
                child: _buildCrops(),
              ),
            ]),
            _isMonthsOpen
                ? Container(
                    margin: EdgeInsets.fromLTRB(320, 320, 10, 70),
                    width: 110,
                    height: 410,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Card(
                        elevation: 2.0,
                        //margin: EdgeInsets.fromLTRB(1, 0, 1, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  itemCount: 12,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _buildMonth(
                                        _months.entries.toList()[index].key,
                                        context);
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                    alignment: Alignment.centerRight,
                  )
                : Container()
          ],
        ));
  }

  Widget _buildCard(int index) {
    return GestureDetector(
        onTap: () {
          _showVegetablePage(vegetables[index]);
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Card(
              margin: EdgeInsets.fromLTRB(4, 0, 4, 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5.0,
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                            child: Column(children: [
                              Image.asset(
                                //'images/crops/chili.png',
                                vegetables[index]['imgPath'],
                                //snapshot.data.documents[index]['imgPath'],
                                width: 50,
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
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Row(
                      children: [
                        Text(
                          vegetables[index]['name'],
                          style: TextStyle(
                              color: Color(0xFF1A633C),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: Row(
                      children: [
                        Text(
                            "Estimated time:\n" +
                                convertGrowthTime(
                                        vegetables[index]['timeToGrow'])
                                    .toString(),
                            style: TextStyle(
                                color: Color(0xFF1A633C), fontSize: 13)),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  Widget _buildCrops() {
    return GridView.count(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: List.generate(vegetables.length, (index) {
          return _buildCard(index);
        }));
  }

  void filterList() {
    setState(() => vegetables.removeRange(0, vegetables.length));
    Firestore.instance.collection('crops').getDocuments().then((val) {
      if (val.documents.length > 0) {
        for (int i = 0; i < val.documents.length; i++) {
          if (_months[_currentMonth].toLowerCase() ==
              val.documents[i].data['bestMonth']) {
            if (_typeVegetable &&
                    val.documents[i].data['type'] == 'vegetable' ||
                _typeFruit && val.documents[i].data['type'] == 'fruit' ||
                _typeHerbs && val.documents[i].data['type'] == 'herb' ||
                (!_typeHerbs && !_typeVegetable && !_typeFruit)) {
              if (_isEasy && val.documents[i].data['difficulty'] == 'easy' ||
                  _isMedium &&
                      val.documents[i].data['difficulty'] == 'medium' ||
                  _isHard && val.documents[i].data['difficulty'] == 'hard' ||
                  (!_isHard && !_isMedium && !_isEasy)) {
                if (val.documents[i].data['timeToGrow'] / 30 >
                        selectedRange.start &&
                    val.documents[i].data['timeToGrow'] / 30 <
                        selectedRange.end) {
                  setState(() => vegetables.add(val.documents[i].data));
                }
              }
            }
          }
        }
      } else {
        print("Not Found");
      }
    });
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

  void _monthsWindow() {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.all(0),
              content: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      itemCount: 12,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildMonth(_months[index], context);
                      }),
                ),
                margin: EdgeInsets.fromLTRB(width - 80, height - 600, 10, 80),
                height: 400,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
              ),
            );
          });
        });
  }

  Widget _buildMonth(String month, context) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      title: Text(month,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF3FAF73),
            fontSize: 16,
            fontWeight:
                _currentMonth == month ? FontWeight.w900 : FontWeight.w500,
          )),
      onTap: () {
        setState(() => _currentMonth = month);
        filterList();
        changeMonth();
      },
    );
  }

  void _showVegetablePage(Map<String, dynamic> veg) {
    showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          var width = MediaQuery.of(context).size.width;
          return new StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: new Container(
                  height: 350.0,
                  width: width - 10,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Column(children: [
                                    Image.asset(
                                      veg['imgPath'],
                                      width: 50,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ])),
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
                              )
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 40, 0),
                                    child: Text(
                                      veg['name'],
                                      style: TextStyle(
                                          color: Color(0xFF1A633C),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 2, 40, 5),
                                    child: Text(
                                      "Estimated time:\n" +
                                          convertGrowthTime(veg['timeToGrow'])
                                              .toString(),
                                      style: TextStyle(
                                          color: Color(0xFF1A633C),
                                          fontSize: 12),
                                    )),
                              ),
                            ]),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFF1A633C),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Text(
                                      veg['description'],
                                      style: TextStyle(
                                          color: Color(0xFF1A633C),
                                          fontSize: 12),
                                    )),
                              ),
                            ]),
                        Spacer(),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: new RaisedButton(
                                  child: new Text('Add to my Crops',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  color: Color(0xFF1A633C)
                                      .withOpacity(getOpacity(veg['name'])),
                                  onPressed: () {
                                    if (getOpacity(veg['name']) == 1) {
                                      _addToMyCrops(veg);
                                      Navigator.of(context).pop();
                                    }
                                  }),
                            ))
                      ])),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
            );
          });
        });
  }

  void _addToMyCrops(Map<String, dynamic> veg) async {
    Map<String, dynamic> tmp = {};
    tmp['crop'] = veg['name'];
    tmp['imgPath'] = veg['imgPath'];
    tmp['timeToGrow'] = veg['timeToGrow'];
    tmp['type'] = veg['type'];
    tmp['plant'] = DateTime.now();

    user['myCrops'] = user['myCrops'] + [tmp];

    QuerySnapshot querySnapshot =
        await Firestore.instance.collection('users').getDocuments();
    querySnapshot.documents[docId].reference.updateData(user);
  }

  double getOpacity(String crop) {
    for (int i = 0; i < user['myCrops'].length; i++) {
      if (user['myCrops'][i]['crop'] == crop) return 0.3;
    }
    return 1;
  }

  void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 6,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                                  child: Text(
                                    "Harvest time",
                                    style: TextStyle(
                                        color: Color(0xFF1A633C),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )),
                            ),
                            FlatButton(
                              padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Text(
                                  '${selectedRange.start.round()} - ${selectedRange.end.round()} months',
                                  style: TextStyle(
                                      color: Color(0xFF707070),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400)))
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              flex: 6,
                              child: SliderTheme(
                                  data: SliderThemeData(
                                    trackHeight: 1,
                                  ),
                                  child: RangeSlider(
                                      values: selectedRange,
                                      onChanged: (RangeValues newRange) {
                                        setState(
                                            () => selectedRange = newRange);
                                      },
                                      activeColor: Color(0xFF3FAF73),
                                      inactiveColor: Color(0xFF707070),
                                      min: 0,
                                      max: 24,
                                      //   labels: RangeLabels(
                                      //      '${selectedRange.start}',
                                      //       '${selectedRange.end}'),
                                      divisions: 24)))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              "Type of Crop",
                              style: TextStyle(
                                  color: Color(0xFF1A633C),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: new RaisedButton(
                                child: new Text('Herb',
                                    style: TextStyle(
                                        color: _typeHerbs
                                            ? Colors.white
                                            : Color(0xFF707070),
                                        fontSize: 12)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: _typeHerbs
                                            ? Color(0xFF3FAF73)
                                            : Color(0xFF707070))),
                                color: _typeHerbs
                                    ? Color(0xFF3FAF73)
                                    : Colors.white,
                                onPressed: () => {
                                      setState(() => _typeHerbs = !_typeHerbs),
                                    }),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: new RaisedButton(
                                color: _typeVegetable
                                    ? Color(0xFF3FAF73)
                                    : Colors.white,
                                child: new Text('Vegetable',
                                    style: TextStyle(
                                        color: _typeVegetable
                                            ? Colors.white
                                            : Color(0xFF707070),
                                        fontSize: 12)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: _typeVegetable
                                            ? Color(0xFF3FAF73)
                                            : Color(0xFF707070))),
                                onPressed: () => {
                                      setState(() =>
                                          _typeVegetable = !_typeVegetable),
                                    }),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: new RaisedButton(
                                color: _typeFruit
                                    ? Color(0xFF3FAF73)
                                    : Colors.white,
                                child: new Text('Fruit',
                                    style: TextStyle(
                                        color: _typeFruit
                                            ? Colors.white
                                            : Color(0xFF707070),
                                        fontSize: 12)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: _typeFruit
                                            ? Color(0xFF3FAF73)
                                            : Color(0xFF707070))),
                                onPressed: () => {
                                      setState(() => _typeFruit = !_typeFruit),
                                    }),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                "Difficulty",
                                style: TextStyle(
                                    color: Color(0xFF1A633C),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: new RaisedButton(
                                child: new Text('Easy',
                                    style: TextStyle(
                                        color: _isEasy
                                            ? Colors.white
                                            : Color(0xFF707070),
                                        fontSize: 12)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: _isEasy
                                            ? Color(0xFF3FAF73)
                                            : Color(0xFF707070))),
                                color:
                                    _isEasy ? Color(0xFF3FAF73) : Colors.white,
                                onPressed: () => {
                                  setState(() => {
                                        _isEasy = !_isEasy,
                                        if (_isMedium)
                                          {
                                            _isMedium = !_isMedium,
                                          }
                                        else if (_isHard)
                                          {
                                            _isHard = !_isHard,
                                          }
                                      }),
                                },
                              )),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: new RaisedButton(
                                color: _isMedium
                                    ? Color(0xFF3FAF73)
                                    : Colors.white,
                                child: new Text('Medium',
                                    style: TextStyle(
                                        color: _isMedium
                                            ? Colors.white
                                            : Color(0xFF707070),
                                        fontSize: 12)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: _isMedium
                                            ? Color(0xFF3FAF73)
                                            : Color(0xFF707070))),
                                onPressed: () => {
                                      setState(() => {
                                            _isMedium = !_isMedium,
                                            if (_isEasy)
                                              {
                                                _isEasy = !_isEasy,
                                              }
                                            else if (_isHard)
                                              {
                                                _isHard = !_isHard,
                                              }
                                          }),
                                    }),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: new RaisedButton(
                                  color: _isHard
                                      ? Color(0xFF3FAF73)
                                      : Colors.white,
                                  child: new Text('Hard',
                                      style: TextStyle(
                                          color: _isHard
                                              ? Colors.white
                                              : Color(0xFF707070),
                                          fontSize: 12)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: _isHard
                                              ? Color(0xFF3FAF73)
                                              : Color(0xFF707070))),
                                  onPressed: () => {
                                        setState(() => {
                                              _isHard = !_isHard,
                                              if (_isEasy)
                                                {
                                                  _isEasy = !_isEasy,
                                                }
                                              else if (_isMedium)
                                                {
                                                  _isMedium = !_isMedium,
                                                }
                                            }),
                                      }))
                        ],
                      )
                    ])),
            actions: [
              new Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
                  child: RaisedButton(
                    child: Text('Apply',
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Color(0xFF3FAF73))),
                    color: Color(0xFF3FAF73),
                    disabledColor: Color(0x803FAF73),
                    onPressed: () {
                      Navigator.of(context).pop();
                      filterList();
                    },
                  )),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          );
        });
      },
    );
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
                          onTap: () {
                            _showcontent();
                          },
                          child: Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(12, 10, 0, 10),
                                  child: Text("Filters",
                                      style: TextStyle(
                                          color: Color(0xFF1A633C),
                                          fontSize: 13))),
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
          Text(monthFormat,
              style: TextStyle(
                  color: Color(0xFF1A633C),
                  fontSize: 14,
                  fontWeight: FontWeight.w700)),
        ]),
      )
    ]);
  }

  void changeMonth() {
    monthFormat = _months[_currentMonth];
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
                'Crops Calendar',
                style: TextStyle(
                    color: Color(0xFF1A633C),
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
            ),
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
}
