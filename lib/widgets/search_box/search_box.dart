// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import 'package:eswm/config/font.dart';
import 'package:eswm/config/palette.dart';

class SearchBoxWidget extends StatefulWidget {
  String? labelText;
  SearchBoxWidget({Key? key, this.labelText}) : super(key: key);

  @override
  State<SearchBoxWidget> createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: textFormFieldFillColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: Colors.grey.shade500,
          ),
          borderRadius: BorderRadius.circular(
            10,
          ),
          gapPadding: 6.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: Colors.grey.shade500,
          ),
          borderRadius: BorderRadius.circular(
            10,
          ),
          gapPadding: 6.0,
        ),
        contentPadding: const EdgeInsets.all(8),
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: 15,
          color: labelTextColor,
          fontWeight: textFormFieldLabelFontWeight,
        ),
        suffixIcon: const Icon(
          Icons.search,
          size: 25,
          color: Colors.black87,
        ),
      ),
      onChanged: (value) {},
    );
  }
}
