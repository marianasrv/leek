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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
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
                padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Row(
                  children: [
                    Text(
                      "CropName",
                      style: TextStyle(
                          color: Colors.grey,
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
                    Text("26/11/2020", style: TextStyle(color: Colors.grey))
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildCrops() {
    return GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: List.generate(10, (index) {
          return _buildCard(index);
        }));
  }

  Widget _searchAndFilter() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(8),
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
        Expanded(child: Icon(Icons.filter_list_alt))
      ],
    );
  }
}
