import 'package:flutter/material.dart';

import 'package:movie_ticket/global.dart' as g;


class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("404", style: TextStyle(fontSize: 100, fontWeight: FontWeight.w900, color: g.colorPallet[9])),
            Text("PAGE NOT FOUND", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400, color: g.colorPallet[9])),
          ],
        ),
      ),
    );
  }
}