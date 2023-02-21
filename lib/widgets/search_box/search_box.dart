import 'package:flutter/material.dart';

//import files
import '../../config/font.dart';
import '../../config/palette.dart';

class SearchBoxWidget extends StatefulWidget {
  final String? labelText;
  final Function(dynamic)? searchedName;

  const SearchBoxWidget({Key? key, this.labelText, this.searchedName})
      : super(key: key);

  @override
  SearchBoxWidgetState createState() => SearchBoxWidgetState();
}

class SearchBoxWidgetState extends State<SearchBoxWidget> {
  final TextEditingController searchBox = TextEditingController();
  IconData searchboxIcon = Icons.search;
  Color borderColor = const Color(0xffDDDFE2);

  @override
  void initState() {
    searchBox.addListener(() {
      widget.searchedName!(searchBox.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    searchBox.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchBox,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(
            4,
          ),
          gapPadding: 6.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(
            4,
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
        prefixIcon: searchboxIcon == Icons.search
            ? const Icon(
                Icons.search,
                size: 25,
                color: Color(0xffA4A4A4),
              )
            : null,
        suffixIcon: searchboxIcon == Icons.close
            ? InkWell(
                onTap: () {
                  setState(() {
                    widget.searchedName!("");
                    searchBox.text = "";
                    searchboxIcon = Icons.search;
                  });
                },
                child: Icon(
                  searchboxIcon,
                  size: 25,
                  color: const Color(0xffA4A4A4),
                ),
              )
            : null,
      ),
      onChanged: (value) {
        // widget.searchedName!(value);
        setState(() {
          // searchBox.text = value;
          searchboxIcon = Icons.close;
        });
      },
    );
  }
}
