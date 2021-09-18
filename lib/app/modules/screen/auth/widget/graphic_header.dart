import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GraphicHeader extends StatelessWidget {
  GraphicHeader();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'App Logo',
      child: Image.asset(
        'assets/auth_graphic.jpg',
        fit: BoxFit.cover,
        // width: 120.0,
        // height: 120.0,
      ),
    );
  }
}
