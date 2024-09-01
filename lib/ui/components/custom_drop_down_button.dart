import 'package:flutter/material.dart';
import 'package:flutter_dictionary/providers.dart';
import 'package:flutter_dictionary/utils/get_language_code.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton(
      {super.key,
      this.controller,
      this.validator,
      this.labelText,
      required this.items});

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? labelText;
  final List<String> items;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  static const languageKey = "language";
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final dropDownChoice = ref.watch(customDropDownProvider);

      return DropdownButtonFormField<String>(
        value: ref.watch(sharedPreference).when(
            data: (data) {
              var language = data.getString(languageKey);
              if (language != null) {
                widget.controller?.text = getLanguageCode(language)!;
              }
              return language;
            },
            error: (error, trace) => null,
            loading: () => null),
        isDense: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: widget.labelText,
        ),
        onChanged: (String? newValue) {
          if (newValue != null) {
            dropDownChoice.setValue(newValue);
            ref.watch(sharedPreference).when(
                data: (data) {
                  data.setString(languageKey, newValue);
                },
                error: (error, trace) => {},
                loading: () => {});
            if (widget.controller != null) {
              widget.controller?.text = getLanguageCode(newValue)!;
            }
          }
        },
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    });
  }
}
