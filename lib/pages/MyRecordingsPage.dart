import 'package:flutter/material.dart';

class MyRecordingsPage extends StatelessWidget {
  const MyRecordingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("MyRecordingsPage"),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, "RecordPage");
          },
          icon: const Padding(
            padding: EdgeInsets.fromLTRB(13, 3, 3, 3),
            child: Icon(Icons.mic),
          ),
          label: Text(""),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
