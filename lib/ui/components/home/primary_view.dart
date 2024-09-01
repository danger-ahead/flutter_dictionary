import 'package:flutter/material.dart';
import 'package:flutter_dictionary/constants/strings.dart';
import 'package:flutter_dictionary/controllers/fetch_words_repository_controller.dart';
import 'package:flutter_dictionary/controllers/primary_view_controller.dart';
import 'package:flutter_dictionary/exceptions/word_not_found_exception.dart';
import 'package:flutter_dictionary/models/word_model.dart';
import 'package:flutter_dictionary/providers.dart';
import 'package:flutter_dictionary/ui/components/custom_drop_down_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimaryView extends StatelessWidget {
  PrimaryView({Key? key}) : super(key: key);

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

            // final dropDownChoice = ref.watch(customDropDownProvider);
            final primaryView = ref.watch(primaryViewProvider);

            return Form(
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
                        SizedBox(height: 10),
                        TextFormField(
                          controller: fetchWordsRepositoryCtrl.word,
                          textInputAction: TextInputAction.search,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a word';
                            }
                            var pattern = RegExp(
                                r'[\d+?@!#$%^&*()_+-=~`.,<>{}\[\]:;"\\|]+');
                            if (pattern.hasMatch(value)) {
                              return 'Please enter valid word';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              primaryView.setPrimaryViewState(
                                  showClearButton: true);
                            } else {
                              primaryView.setPrimaryViewState(
                                  showClearButton: false);
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter a word',
                            suffixIcon: ref
                                    .watch(primaryViewController)
                                    .showClearButton
                                ? IconButton(
                                    onPressed: () {
                                      fetchWordsRepositoryCtrl.word.text = "";
                                      primaryView.setPrimaryViewState(
                                          showClearButton: false);
                                    },
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      Icons.clear,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                  Builder(builder: (context) {
                    return ElevatedButton(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.search),
                            Text("Search"),
                          ],
                        ),
                        onPressed: () async {
                          if (Form.of(context).validate()) {
                            try {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(days: 365),
                                  content: Row(
                                    children: [
                                      CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text("Loading..."),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                              final List<WordModel> data =
                                  await Future.microtask(() =>
                                      fetchWordsRepositoryCtrl
                                          .fetchMeaning(ref)).then((data) {
                                ScaffoldMessenger.of(context)
                                    .removeCurrentSnackBar();

                                return data;
                              });

                              Navigator.pushNamed(
                                  context, StringConstants.resultRoute,
                                  arguments: data);
                            } on WordNotFoundException catch (_) {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Requried word was not found'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            } catch (_) {
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Something went wrong! Try again'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        });
                  }),
                ],
              ),
            );
          })),
        ),
      );
    });
  }
}
