import 'package:flutter/material.dart';
import 'package:flasher/flasher.dart';

main() => runApp(FlasherExampleApp());

class FlasherExampleApp extends StatelessWidget {

  const FlasherExampleApp({super.key,});

  @override
  Widget build(context) => MaterialApp(
    home: Scaffold(
      body: Center(
        child: Flasher(
          child: Text(
            '00:00',
            style: TextStyle(
              fontFamily: 'Digital7',
              fontSize: 100.0,
              color: Colors.redAccent,
            ),
          ),
        ),
      ),
    ),
  );
}