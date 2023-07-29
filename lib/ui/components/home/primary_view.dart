import 'package:flutter/material.dart';
import 'package:flutter_dictionary/random_results.dart';
import 'package:flutter_dictionary/results.dart';
import 'package:flutter_dictionary/widgets/NoNet.dart';

class PrimaryView extends StatelessWidget {
  PrimaryView({Key? key}) : super(key: key);

  final TextEditingController _word = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String choice = 'English (US)';

    return LayoutBuilder(
      builder: (context, viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: viewportConstraints.copyWith(
              minHeight: viewportConstraints.maxHeight,
              maxHeight: double.infinity,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRect(
                  child: Image.asset(
                    "images/icon.png",
                    scale: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 30.0),
                  child: TextField(
                    controller: _word,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      suffixIcon: _word.text == ''
                          ? SizedBox()
                          : IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _word.text = '';
                              }),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: DropdownButton<String>(
                          value: choice,
                          elevation: 16,
                          onChanged: (String? newValue) {
                            choice = newValue!;
                          },
                          items: <String>[
                            'English (US)',
                            'English (UK)',
                            'Spanish',
                            'French',
                            'Russian',
                            'German',
                            'Italian',
                            'Hindi',
                            'Japanese',
                            'Arabic',
                            'Korean'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Enter a word',
                    ),
                  ),
                ),
                ElevatedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Search"),
                        Icon(Icons.search),
                      ],
                    ),
                    onPressed: () async {
                      detectNetStatus(context);
                      String word = _word.text;
                      _word.text = '';
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return word == ''
                            ? RandomResults()
                            : Results(word, choice);
                      }));
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
