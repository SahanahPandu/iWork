import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../providers/sub_laluan_api.dart';
import '../../utils/device/orientations.dart';
import '../../widgets/custom_scroll/custom_scroll.dart';

class ListOfSubRoutesTextFormField extends StatefulWidget {
  final String hintText;
  final double fontSize;
  final Color fillColor;
  final int iconCondition;
  final String data;
  final String? screen;
  final Function(dynamic, dynamic)? getSubLaluanId;

  const ListOfSubRoutesTextFormField({
    Key? key,
    required this.hintText,
    required this.fontSize,
    required this.fillColor,
    required this.iconCondition,
    required this.data,
    this.screen,
    this.getSubLaluanId,
  }) : super(key: key);

  @override
  ListOfSubRoutesTextFormFieldState createState() =>
      ListOfSubRoutesTextFormFieldState();
}

class ListOfSubRoutesTextFormFieldState
    extends State<ListOfSubRoutesTextFormField> {
  final TextEditingController namaSubLaluan = TextEditingController();
  int selectedIndex = -1;

  getTotalData() {
    if (widget.data != "") {
      setState(() {
        namaSubLaluan.text = widget.data;
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
          showListOfSubRoutes();
        }
      },
      child: TextFormField(
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xff2B2B2B),
          fontWeight: FontWeight.w400,
        ),
        controller: namaSubLaluan,
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
          label: const Text('Sub-Laluan'),
          labelStyle: TextStyle(
            fontSize: widget.fontSize,
            color: labelTextColor,
            fontWeight: textFormFieldLabelFontWeight,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: borderSideWidth,
              color: namaSubLaluan.text != '' &&
                      widget.iconCondition == 1 &&
                      widget.screen == null
                  ? (enabledBorderWithText)
                  : (enabledBorderWithoutText),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          errorStyle: const TextStyle(height: 0),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: borderSideWidth, color: Colors.red),
            borderRadius: BorderRadius.circular(4),
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

  Widget? showListOfSubRoutes() {
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
            : const BoxConstraints(maxHeight: 380),
        context: context,
        builder: (builder) {
          return Container(
            padding: const EdgeInsets.only(top: 5),
            child: ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: SingleChildScrollView(
                child: Wrap(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        thickness: 1,
                        color: Color(0xff969696),
                        indent: 160,
                        endIndent: 160,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                          left: 30,
                          bottom: 10,
                        ),
                        child: Text(
                          "Pilih Sub-Laluan",
                          style: TextStyle(
                            color: Color(0xff969696),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 26, right: 26, top: 8),
                        child: Divider(height: 0.5),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: FutureBuilder<List>(
                          future: SubLaluanApi.getSubLaluanData(context),
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
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: dataFuture.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                widget.getSubLaluanId != null
                                                    ? widget.getSubLaluanId!(
                                                        dataFuture[index].id,
                                                        dataFuture[index]
                                                            .namaSubLaluan)
                                                    : null;
                                                namaSubLaluan.text =
                                                    dataFuture[index]
                                                        .namaSubLaluan;
                                                selectedIndex = index;
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                      selectedIndex == index
                                                          ? Icons.check
                                                          : null,
                                                      color: green,
                                                      size: 18),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                      dataFuture[index]
                                                          .namaSubLaluan,
                                                      style: TextStyle(
                                                        color: blackCustom,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            selectedIndex ==
                                                                    index
                                                                ? FontWeight
                                                                    .w600
                                                                : FontWeight
                                                                    .w400,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          );
        });
    return null;
  }
}
