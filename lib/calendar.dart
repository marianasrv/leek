import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  TextEditingController editingController = TextEditingController();
  final _suggestions = <WordPair>[];
  final _months = [
    'JAN',
    'FEV',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];
  var _currentMonth = 'NOV';
  final _saved = Set<WordPair>();
  final _biggerFont = TextStyle(fontSize: 18.0);
  var selectedRange = RangeValues(3, 6);
  bool _typeHerbs = false;
  bool _typeVegetable = false;
  bool _typeFruit = false;
  bool _isDisabled = true;
  bool _isEasy = false;
  bool _isMedium = false;
  bool _isHard = false;
  bool _isMonthsOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child:
              // _isMonthsOpen
              //     ? Center(
              //         child: Icon(
              //         Icons.close_rounded,
              //         color: Color(0xFF3FAF73),
              //         size: 40,
              //       ))
              //     :
              Column(children: [
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
            _monthsWindow();
            setState(() => _isMonthsOpen = !_isMonthsOpen);
          },
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
    return GestureDetector(
        onTap: () {
        _showVegetablePage();
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
        )));
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
                      return _buildMonth(_months[index], context);}
                      ),
                ),
                margin: EdgeInsets.fromLTRB(width - 80, height - 660, 10, 80),
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

  void _showVegetablePage(){

    showDialog(
        context: context, barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
      var width = MediaQuery.of(context).size.width;
      return new StatefulBuilder(builder: (context, setState)
      {
        return AlertDialog(
            content: new Container(
                height: 350.0,
                width: width - 10,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                         Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Column(children: [
                                  Image.asset(
                                    'images/050-sun.png',
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
                    ]

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 40, 0),
                            child: Text(
                              "Crop Name",
                              style: TextStyle(
                                  color: Color(0xFF1A633C),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )),
                      ),
                    ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 2, 40, 0),
                              child: Text(
                                "Estimated time:",
                                style: TextStyle(
                                    color: Color(0xFF1A633C),
                                    fontSize: 12),
                              )),
                        ),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 2, 0, 10),
                              child: Text(
                                "time",
                                style: TextStyle(
                                    color: Color(0xFF1A633C),
                                    fontSize: 12),
                              )),
                        ),
                      ]
                  ),
                  Divider(
                    height:1,
                    thickness:1,
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
                                "Description",
                                style: TextStyle(
                                    color: Color(0xFF1A633C),
                                    fontSize: 12),
                              )),
                        ),
                      ]
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: new RaisedButton(
                            child: new Text('Add to my Crops',
                                style: TextStyle(
                                    color:  Colors.white,
                                    fontSize: 12)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    color:  Color(0xFF1A633C))),
                            color:  Color(0xFF1A633C),
                            onPressed: () {
                            Navigator.of(context).pop();

                            }),
                  ))
                  ]
            )),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        );
      }
      );}
      );}

  Widget _buildMonth(String month, context) {
      return ListTile(
        dense: true,
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        title: Text(month,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: TextStyle(
            color: Color(0xFF3FAF73),
            fontSize: 16,
            fontWeight:
                _currentMonth == month ? FontWeight.w900 : FontWeight.w500,
          )),
      onTap: () {
        setState(() => _currentMonth = month);
      },
    );
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
                                      if (!_isEasy &&
                                          !_isMedium &&
                                          !_isHard &&
                                          !_typeFruit &&
                                          !_typeHerbs &&
                                          !_typeVegetable)
                                        {_isDisabled = true}
                                      else
                                        {_isDisabled = false}
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
                                      if (!_isEasy &&
                                          !_isMedium &&
                                          !_isHard &&
                                          !_typeFruit &&
                                          !_typeHerbs &&
                                          !_typeVegetable)
                                        {_isDisabled = true}
                                      else
                                        {_isDisabled = false}
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
                                      if (!_isEasy &&
                                          !_isMedium &&
                                          !_isHard &&
                                          !_typeFruit &&
                                          !_typeHerbs &&
                                          !_typeVegetable)
                                        {_isDisabled = true}
                                      else
                                        {_isDisabled = false}
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
                                  if (!_isEasy &&
                                      !_isMedium &&
                                      !_isHard &&
                                      !_typeFruit &&
                                      !_typeHerbs &&
                                      !_typeVegetable)
                                    {_isDisabled = true}
                                  else
                                    {_isDisabled = false}
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
                                      if (!_isEasy &&
                                          !_isMedium &&
                                          !_isHard &&
                                          !_typeFruit &&
                                          !_typeHerbs &&
                                          !_typeVegetable)
                                        {_isDisabled = true}
                                      else
                                        {_isDisabled = false}
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
                                        if (!_isEasy &&
                                            !_isMedium &&
                                            !_isHard &&
                                            !_typeFruit &&
                                            !_typeHerbs &&
                                            !_typeVegetable)
                                          {_isDisabled = true}
                                        else
                                          {_isDisabled = false}
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
                        side: BorderSide(
                            color: _isDisabled
                                ? Color(0x803FAF73)
                                : Color(0xFF3FAF73))),
                    color: Color(0xFF3FAF73),
                    disabledColor: Color(0x803FAF73),
                    onPressed: _isDisabled
                        ? null
                        : () {
                            Navigator.of(context).pop();
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
