// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import 'package:eswm/config/font.dart';
import 'package:eswm/config/palette.dart';

class SearchBoxWidget extends StatefulWidget {
  String? labelText;
  Function(dynamic)? searchedName;

  SearchBoxWidget({Key? key, this.labelText, this.searchedName})
      : super(key: key);

  @override
  State<SearchBoxWidget> createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  final TextEditingController _search = TextEditingController();
  IconData searchboxIcon = Icons.search;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _search,
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
        suffixIcon: InkWell(
            onTap: () {
              if (searchboxIcon == Icons.close) {
                setState(() {
                  widget.searchedName!("");
                  _search.text = "";
                  searchboxIcon = Icons.search;
                });
              }
            },
            child: Icon(
              searchboxIcon,
              size: 25,
              color: Colors.black87,
            )),
      ),
      onChanged: (value) {
        widget.searchedName!(value);
        setState(() {
          searchboxIcon = Icons.close;
        });
      },
    );
  }
}
