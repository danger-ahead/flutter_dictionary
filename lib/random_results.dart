import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'widgets/loading.dart';

import 'random.dart';

class RandomResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Error :(")),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: FutureBuilder(
                future: getRandomWord(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return loading; //Center
                  } else {
                    var data = (snapshot.data as Random);
                    return Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: "UGHH! You didn't enter any word!\n",
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                      TextSpan(
                        text: "But here's a word for you, \"" +
                            data.word +
                            "\".\n",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      TextSpan(
                        text: "It means \"" + data.definition + "\".\n",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      TextSpan(
                        text: "Wondering about the pronunciation? It's \"" +
                            data.pronunciation +
                            "\".",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      )
                    ]));
                  }
                }),
          ),
        ));
  }
}
