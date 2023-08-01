import 'package:flutter/material.dart';
import 'package:flutter_dictionary/utils/get_language_code.dart';

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
  String? _choice;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _choice,
      isDense: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: widget.labelText,
      ),
      onChanged: (String? newValue) {
        setState(() {
          _choice = newValue!;
        });
        if (widget.controller != null) {
          widget.controller?.text = getLanguageCode(newValue!)!;
        }
      },
      validator: widget.validator,
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
