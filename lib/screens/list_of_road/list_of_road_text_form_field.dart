// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

//import files
import '../../config/font.dart';
import '../../config/palette.dart';
import 'package:eswm/providers/jalan_api.dart';

class ListOfRoadTextFormField extends StatefulWidget {
  String text;
  double fontSize;
  Color fillColor;
  int iconCondition;
  String data;

  ListOfRoadTextFormField(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.fillColor,
      required this.iconCondition,
      required this.data})
      : super(key: key);

  @override
  State<ListOfRoadTextFormField> createState() =>
      _ListOfRoadTextFormFieldState();
}

class _ListOfRoadTextFormFieldState extends State<ListOfRoadTextFormField> {
  final TextEditingController _namaJalan = TextEditingController();

  int totalJalan = 0;

  getTotalData() {
    JalanApi.getJalanData(context).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          totalJalan = value.length;
        });
      }
    });

    if (widget.data != "") {
      setState(() {
        _namaJalan.text = widget.data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getTotalData();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.iconCondition == 1) {
          showListOfRoads();
        }
      },
      child: TextFormField(
        controller: _namaJalan,
        readOnly: true,
        enabled: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor,
          contentPadding: const EdgeInsets.all(10),
          suffixIcon: widget.iconCondition == 1
              ? const Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                  color: Colors.black87,
                )
              : null,
          labelText: widget.iconCondition == 1 ? widget.text : null,
          labelStyle: widget.iconCondition == 1
              ? TextStyle(
                  fontSize: widget.fontSize,
                  color: labelTextColor,
                  fontWeight: textFormFieldLabelFontWeight,
                )
              : null,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: borderSideWidth,
              color: _namaJalan.text != '' && widget.iconCondition == 1
                  ? enabledBorderWithText
                  : enabledBorderWithoutText,
            ),
            borderRadius: BorderRadius.circular(borderRadiusCircular),
          ),
        ),
      ),
    );
  }

  Widget? showListOfRoads() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (builder) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                    left: 25,
                    bottom: 10,
                  ),
                  child: Text(
                    "${totalJalan.toString()} Senarai Jalan",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                FutureBuilder<List>(
                  future: JalanApi.getJalanData(context),
                  builder: (context, snapshot) {
                    final dataFuture = snapshot.data;

                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );

                      default:
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text("Some error occured!"),
                          );
                        } else {
                          return Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              padding: const EdgeInsets.all(6),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: dataFuture!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        _namaJalan.text =
                                            dataFuture[index].namaJalan;

                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide.none,
                                          bottom: BorderSide(
                                            color: grey400,
                                            width: 0.9,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        dataFuture[index].namaJalan,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                    }
                  },
                ),
              ],
            ),
          );
        });
    return null;
  }
}
