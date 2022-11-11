// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/dimen.dart';
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../providers/jenis_cuti_api.dart';
import '../../utils/device/orientations.dart';
import '../../utils/device/sizes.dart';

class ListOfLeaveType extends StatefulWidget {
  String hintText;
  double fontSize;
  int borderCondition;
  Color fillColor;
  int iconCondition;
  String data;

  ListOfLeaveType(
      {Key? key,
      required this.hintText,
      required this.fontSize,
      required this.borderCondition,
      required this.fillColor,
      required this.iconCondition,
      required this.data})
      : super(key: key);

  @override
  State<ListOfLeaveType> createState() => _ListOfLeaveTypeState();
}

class _ListOfLeaveTypeState extends State<ListOfLeaveType> {
  final TextEditingController _jenisCuti = TextEditingController();
  int totalJenisCuti = 0;

  getTotalData() {
    JenisCutiApi.getJenisCutiData(context).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          totalJenisCuti = value.length;
        });
      }
    });

    if (widget.data != "") {
      setState(() {
        _jenisCuti.text = widget.data;
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
      borderRadius:
          userRole == 100 ? BorderRadius.circular(borderRadiusCircular) : null,
      onTap: () {
        if (widget.iconCondition == 1) {
          showListOfLeaveType();
        }
      },
      child: TextFormField(
        controller: _jenisCuti,
        readOnly: true,
        enabled: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor,
          contentPadding: userRole == 100
              ? const EdgeInsets.symmetric(vertical: 15, horizontal: 20)
              : const EdgeInsets.all(8),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: widget.fontSize,
            color: labelTextColor,
            fontWeight: textFormFieldLabelFontWeight,
          ),
          suffixIcon: widget.iconCondition == 1
              ? const Icon(
                  Icons.expand_more,
                  size: 20,
                  color: Color(0xff2B2B2B),
                )
              : null,
          label: Text(widget.hintText),
          labelStyle: TextStyle(
            fontSize: widget.fontSize,
            color: labelTextColor,
            fontWeight: textFormFieldLabelFontWeight,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: widget.borderCondition == 0
                ? BorderSide.none
                : BorderSide(
                    width: borderSideWidth,
                    color: _jenisCuti.text != '' && widget.iconCondition == 1
                        ? (enabledBorderWithText)
                        : (enabledBorderWithoutText),
                  ),
            borderRadius: BorderRadius.circular(borderRadiusCircular),
          ),
        ),
      ),
    );
  }

  Widget? showListOfLeaveType() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        constraints: userRole == 100
            ? (Orientations().isLandscape(context)
                ? const BoxConstraints(maxWidth: 500, maxHeight: 400)
                : const BoxConstraints(
                    maxWidth: 500,
                    minHeight: 200,
                    maxHeight: 450,
                  ))
            : null,
        context: context,
        builder: (builder) {
          return SizedBox(
            height: Sizes().screenHeight(context) * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 2,
                ),
                const Divider(
                  thickness: 1,
                  color: Color(0xff969696),
                  indent: 170,
                  endIndent: 170,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 25,
                    top: 25,
                    right: 25,
                    bottom: 8,
                  ),
                  child: Text(
                    "${totalJenisCuti.toString()} Jenis Cuti",
                    style: const TextStyle(
                      color: Color(0xff969696),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Color(0xffE5E5E5),
                  indent: 25,
                  endIndent: 25,
                ),
                FutureBuilder<List>(
                  future: JenisCutiApi.getJenisCutiData(context),
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
                              padding: userRole == 100
                                  ? const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10)
                                  : const EdgeInsets.all(6),
                              child: ListView.builder(
                                physics: userRole == 100
                                    ? const BouncingScrollPhysics()
                                    : const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: dataFuture!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        _jenisCuti.text =
                                            dataFuture[index].jenisCuti;

                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Container(
                                      margin: userRole == 100
                                          ? null
                                          : const EdgeInsets.symmetric(
                                              vertical: 5),
                                      padding: userRole == 100
                                          ? const EdgeInsets.symmetric(
                                              vertical: 23, horizontal: 5)
                                          : const EdgeInsets.all(6),
                                      /* decoration: BoxDecoration(
                                         border: Border(
                                           top: BorderSide.none,
                                           bottom: BorderSide(
                                             color: grey400,
                                             width: userRole == 100 ? 0.3 : 0.9,
                                             style: BorderStyle.solid,
                                           ),
                                         ),
                                       ),*/
                                      child: Text(
                                        dataFuture[index].jenisCuti,
                                        style: const TextStyle(
                                          color: Color(0xff2B2B2B),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
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
