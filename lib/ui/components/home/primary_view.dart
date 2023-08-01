import 'package:flutter/material.dart';
import 'package:flutter_dictionary/constants/strings.dart';
import 'package:flutter_dictionary/controllers/fetch_words_repository_controller.dart';
import 'package:flutter_dictionary/providers.dart';
import 'package:flutter_dictionary/ui/components/custom_drop_down_button.dart';
import 'package:flutter_dictionary/widgets/no_net.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimaryView extends StatelessWidget {
  PrimaryView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: viewportConstraints.copyWith(
            minHeight: viewportConstraints.maxHeight,
            maxHeight: double.infinity,
          ),
          child: Consumer(builder: ((context, ref, child) {
            final fetchWordsRepositoryCtrl =
                ref.watch(fetchWordsRepositoryController.notifier);

            final dropDownChoice = ref.watch(customDropDownProvider);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRect(
                  child: Image.asset(
                    "images/icon.png",
                    scale: 2,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                    child: Column(
                      children: [
                        CustomDropdownButton(
                            items: StringConstants.languages,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a language';
                              }
                              return null;
                            },
                            labelText: "Language",
                            controller: fetchWordsRepositoryCtrl.language),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: fetchWordsRepositoryCtrl.word,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a word';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter a word',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search),
                        Text("Search"),
                      ],
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        detectNetStatus(context);
                        final data =
                            await fetchWordsRepositoryCtrl.fetchMeaning(ref);
                        fetchWordsRepositoryCtrl.word.text = "";
                        fetchWordsRepositoryCtrl.language.text = "";
                        dropDownChoice.setValue(null);
                        Navigator.pushNamed(
                            context, StringConstants.resultRoute,
                            arguments: data);
                      }
                    }),
              ],
            );
          })),
        ),
      );
    });
  }
}
