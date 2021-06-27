import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

dynamic homeLayout(int selected) {

    TextEditingController _word = TextEditingController();

    List<Widget> widgetArray = [
        Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
            child: Column(
                children: [
                    TextField(
                        controller: _word,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter word',
                            suffixIcon: Icon(Icons.search)
                        ),  //InputDecoration
                    ),  //TextField
                    ElevatedButton(
                        onPressed: (){
                            print(_word.text);
                        },
                        child: Text('Find meaning!')
                    )
                ],  //Column-children
            )   //Column
        ),  //Padding
        Text('test2')
    ];
    return widgetArray[selected];
}