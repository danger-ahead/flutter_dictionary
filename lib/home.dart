import 'package:flutter/material.dart';

dynamic homeLayout(int selected) {
    List<Widget> widgetArray = [
        Text('test1'),
        Text('test2')
    ];
    return widgetArray[selected];
}