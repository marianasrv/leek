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
                      ]),
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
}
