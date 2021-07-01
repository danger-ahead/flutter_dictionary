import 'package:flutter/material.dart';

class Loading {
  Widget loading() {
    return Center(
      child: Image.asset(
        "images/search.gif",
        height: 200.0,
        width: 200.0,
      ),
    );
  }
}
