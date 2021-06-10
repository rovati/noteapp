import 'package:flutter/material.dart';

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
                Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
                Colors.black54
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          Positioned(
            child: AppBar(
              title: Text(
                'Notes',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
