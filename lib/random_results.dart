import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'widgets/loading.dart';

import 'random.dart';

class RandomResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Results")),
        body: FutureBuilder(
            future: getRandomWord(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return loading; //Center
              } else {
                var data = (snapshot.data as Random);
                return ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 24),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          gradient: LinearGradient(
                              colors: [Colors.blue, Colors.lightBlueAccent],
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft)),
                      child: Column(
                        children: [
                          Text(
                            "UGHH! You didn't enter any word\n",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            "But here's a word for you, \"" + data.word + "\".",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          Text(
                            "It means \"" + data.definition + "\".",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          Text(
                            "Wondering about the pronunciation? \"" +
                                data.pronunciation +
                                "\".",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )
                        ],
                      ),
                    )
                  ],
                );
              }
            }));
  }
}
