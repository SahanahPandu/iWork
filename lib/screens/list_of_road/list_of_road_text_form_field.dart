import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../providers/jalan_api.dart';
import '../../utils/device/orientations.dart';

class ListOfRoadTextFormField extends StatefulWidget {
  final String text;
  final String hintText;
  final double fontSize;
  final Color fillColor;
  final int iconCondition;
  final String data;
  final String? screen;

  const ListOfRoadTextFormField(
      {Key? key,
      required this.text,
      required this.hintText,
      required this.fontSize,
      required this.fillColor,
      required this.iconCondition,
      required this.data,
      this.screen})
      : super(key: key);

  @override
  ListOfRoadTextFormFieldState createState() => ListOfRoadTextFormFieldState();
}

class ListOfRoadTextFormFieldState extends State<ListOfRoadTextFormField> {
  final TextEditingController namaJalan = TextEditingController();

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
        namaJalan.text = widget.data;
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
          showListOfRoads();
        }
      },
      child: TextFormField(
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xff2B2B2B),
          fontWeight: FontWeight.w400,
        ),
        controller: namaJalan,
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
          label: Container(
            color: Colors.white,
            child: const Text('Jalan'),
          ),
          labelStyle: TextStyle(
            fontSize: widget.fontSize,
            color: labelTextColor,
            fontWeight: textFormFieldLabelFontWeight,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: borderSideWidth,
              color: namaJalan.text != '' &&
                      widget.iconCondition == 1 &&
                      widget.screen == null
                  ? (userRole == 100 ? grey100 : enabledBorderWithText)
                  : (userRole == 100 ? grey100 : enabledBorderWithoutText),
            ),
            borderRadius: BorderRadius.circular(borderRadiusCircular),
            gapPadding: 6.0,
          ),
          errorStyle: const TextStyle(height: 0),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: borderSideWidth, color: Colors.red),
            borderRadius: BorderRadius.circular(borderRadiusCircular),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }

          return null;
        },
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
        constraints: userRole == 100
            ? (Orientations().isLandscape(context)
                ? const BoxConstraints(maxWidth: 500, maxHeight: 400)
                : const BoxConstraints(maxWidth: 500, maxHeight: 450))
            : null,
        context: context,
        builder: (builder) {
          return SizedBox(
            height: userRole == 100
                ? null
                : MediaQuery.of(context).size.height * 0.5,
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
                const Padding(
                  padding: EdgeInsets.only(
                    top: 24,
                    left: 24,
                    bottom: 16,
                  ),
                  child: Text(
                    "Pilih Jalan",
                    style: TextStyle(
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
                          if (dataFuture!.isEmpty) {
                            return Center(
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                child: const Text("Tiada data"),
                              ),
                            );
                          } else {
                            return Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: dataFuture.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          namaJalan.text =
                                              dataFuture[index].namaJalan;

                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        child: Text(
                                          dataFuture[index].namaJalan,
                                          style: TextStyle(
                                            color: blackCustom,
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
