import 'package:flutter/material.dart';
import 'data.dart';

class Results extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: Container(
        child: FutureBuilder(
          future: getData('hello'),
          builder: (context, snapshot) {
            var count = snapshot.data;
            if (count == null) {
              return Container(
                child: Text("Loading"),
              );
            }
            return ListView.builder(
                itemCount: count.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: snapshot.data[i].partOfSpeech,
                  );
                });
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: snapshot.data[i].partOfSpeech,
                      );
                    });
              default:
                return Text("heyw2");
            }
          },
        ),
      ),
    );
  }
}
