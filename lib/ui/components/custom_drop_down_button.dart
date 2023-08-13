import 'package:flutter/material.dart';
import 'package:flutter_dictionary/controllers/custom_drop_down_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final dropDownChoice = ref.watch(customDropDownProvider);

      return DropdownButtonFormField<String>(
        value: ref.watch(customDropDownController),
        isDense: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: widget.labelText,
        ),
        onChanged: (String? newValue) {
          if (newValue != null) {
            dropDownChoice.setValue(newValue);
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
