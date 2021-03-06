import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AlertDialog dialog = AlertDialog(
      title: Text('Confirm'),
      content:
      Text('Stop the trip?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('No'),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Trip'),
        centerTitle: true,
        backgroundColor: Colors.black45,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
            onPressed: () {
              showDialog<void>(context: context, builder: (context) => dialog);
            },
              child: Text(
                "STOP TRIP",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                ),
              )
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Respond to button press
              },
              icon: Icon(Icons.report, size: 20),
              label: Text("Report Emergency"),
            )
          ]
        ),
      ),
    );
  }
}