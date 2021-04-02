
import 'package:flutter/material.dart';
import 'package:nid_scanner_app/main.dart';

class Details extends StatefulWidget {
  final String text;

  Details(this.text);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text('Details'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MyApp()));
              },
            );
          },
        ),
      ),
      body: Container(
        color: Colors.blueGrey.shade700,
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.topCenter,
        height: double.infinity,
        width: double.infinity,
        child: SelectableText(
            widget.text.isEmpty ? 'No Text Available' : widget.text),
      ),
    );
  }
}
