import 'package:flutter/material.dart';
import 'package:note_app/widget/NoteTile.dart';

class MainPage extends StatefulWidget {
  MainPage({key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(0xFF, 0x33, 0x33, 0x32),
                Color.fromARGB(0xFF, 0x33, 0x33, 0x32) // 0x1D, 0x27, 0x2F
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
          ),
          Center(
              child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.90,
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
                itemCount: 15,
                itemBuilder: (context, index) => NoteTile()),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {}, child: Icon(Icons.keyboard_arrow_left_rounded)),
    );
  }
}
