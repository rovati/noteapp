import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.scale(
          scale: 3.0,
          child: CircularProgressIndicator(
            color: Color.fromARGB(0xFF, 0xE1, 0x55, 0x54),
            strokeWidth: 2.0,
          ),
        ),
      ),
    );
  }
}
