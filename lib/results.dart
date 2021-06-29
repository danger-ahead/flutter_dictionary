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
            if (snapshot.data == null) {
              return Container(
                child: Text(snapshot.data.runtimeType.toString()),
              );
            }else{
              var data = (snapshot.data as List<Data>).toList();
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(data[i].partOfSpeech),
                      subtitle: Text(data[i].definition),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
