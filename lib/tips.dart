import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  TextEditingController editingController = TextEditingController();
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = TextStyle(fontSize: 18.0);
  bool _typeHerbs = false;
  bool _typeVegetable = false;
  bool _typeFruit = false;
  bool _isDisabled = true;
  bool _isMostPopular = false;
  bool _isTrending = false;

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
          _addTip();
        },
      ),
      body: Column(children: [
        _titleAndProfile(),
        _searchAndFilter(),
        Expanded(
          flex: 8,
          child: _buildSuggestions(),
        ),
      ]),
    );
  }

  void _addTip(){
    showDialog(
        context: context, barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          var width = MediaQuery.of(context).size.width;
          return new StatefulBuilder(builder: (context, setState)
          {
            return AlertDialog(
              content: new Container(
                  height: 290.0,
                  width: width - 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Row (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Expanded(
                          flex: 6,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 40, 10),
                              child: Text(
                                "Add tip/trick",
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
                      ]
                    ),
                    Container(
                    height:180,
                    child: TextFormField(
                        expands:true,
                        maxLines: null,
                        textAlignVertical: TextAlignVertical.top,
                        decoration: new InputDecoration(
                            hintText: "Lettuce know your tips...",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(20.0),
                              borderSide: new BorderSide(
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Color(0xFF3FAF73),
                                width: 2.0,
                            ),
                        )
                    )
                    )),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: new RaisedButton(
                                child: new Text('Post',
                                    style: TextStyle(
                                        color:  Colors.white,
                                        fontSize: 12)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color:  Color(0xFF3FAF73))),
                                color:  Color(0xFF3FAF73),
                                onPressed: () {
                                  Navigator.of(context).pop();

                                }),
                          ))

                    ]
                  )
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
            );
          }
          );}
    );}


  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Card(
        margin: EdgeInsets.fromLTRB(4, 10, 4, 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5.0,
        child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text('MS'),
            ),
            title: Text(
              "This is the tip title.",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

            subtitle: Text("26/11/2020",
                style: TextStyle(color: Colors.grey, fontSize: 13)),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.grey, size: 30.0)),
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(16.0, 5, 16, 10),
        itemBuilder: /*1*/ (context, i) {
          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
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
                          onTap: () {
                            _showcontent();
                          },
                          child: Row(children: [
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
                          ])),
                    ),
                  )))
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 30, top: 10),
        child: Row(children: [
          Text("All",
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
              "Tips & Tricks",
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

  void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        var width = MediaQuery.of(context).size.width;
        return new StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: new Container(
                height: 230.0,
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
                                padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                                child: Text(
                                  "Type of Crop",
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
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                                      if (!_isMostPopular &&
                                          !_isTrending &&
                                          !_typeFruit &&
                                          !_typeHerbs &&
                                          !_typeVegetable)
                                        {_isDisabled = true}
                                      else
                                        {_isDisabled = false}
                                    }),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                                      if (!_isMostPopular &&
                                          !_isTrending &&
                                          !_typeFruit &&
                                          !_typeHerbs &&
                                          !_typeVegetable)
                                        {_isDisabled = true}
                                      else
                                        {_isDisabled = false}
                                    }),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                                      if (!_isMostPopular & !_isTrending &&
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
                              padding: EdgeInsets.fromLTRB(0, 20, 40, 0),
                              child: Text(
                                "Popularity",
                                style: TextStyle(
                                    color: Color(0xFF1A633C),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                              child: new RaisedButton(
                                child: new Text('Most Popular',
                                    style: TextStyle(
                                        color: _isMostPopular
                                            ? Colors.white
                                            : Color(0xFF707070),
                                        fontSize: 12)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: _isMostPopular
                                            ? Color(0xFF3FAF73)
                                            : Color(0xFF707070))),
                                color: _isMostPopular
                                    ? Color(0xFF3FAF73)
                                    : Colors.white,
                                onPressed: () => {
                                  setState(() => {
                                        _isMostPopular = !_isMostPopular,
                                        if (_isTrending)
                                          {
                                            _isTrending = !_isTrending,
                                          }
                                      }),
                                  if (!_isMostPopular &&
                                      !_isTrending &&
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
                                color: _isTrending
                                    ? Color(0xFF3FAF73)
                                    : Colors.white,
                                child: new Text('Trending',
                                    style: TextStyle(
                                        color: _isTrending
                                            ? Colors.white
                                            : Color(0xFF707070),
                                        fontSize: 12)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: _isTrending
                                            ? Color(0xFF3FAF73)
                                            : Color(0xFF707070))),
                                onPressed: () => {
                                      setState(() => {
                                            _isTrending = !_isTrending,
                                            if (_isMostPopular)
                                              {
                                                _isMostPopular =
                                                    !_isMostPopular,
                                              }
                                          }),
                                      if (!_isMostPopular &&
                                          !_isTrending &&
                                          !_typeFruit &&
                                          !_typeHerbs &&
                                          !_typeVegetable)
                                        {_isDisabled = true}
                                      else
                                        {_isDisabled = false}
                                    }),
                          ),
                        ],
                      )
                    ])),
            actions: [
              new Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
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
}
