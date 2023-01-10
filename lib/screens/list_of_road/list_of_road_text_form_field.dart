import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/dimen.dart';
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../config/string.dart';
import '../../providers/jalan_api.dart';
import '../../utils/device/orientations.dart';
import '../../utils/device/sizes.dart';
import '../../utils/icon/custom_icon.dart';
import '../../widgets/custom_scroll/custom_scroll.dart';

class ListOfRoadTextFormField extends StatefulWidget {
  final String text;
  final String hintText;
  final double fontSize;
  final Color fillColor;
  final int iconCondition;
  final String data;
  final String? screen;
  final int? scMainId;
  final String? namaTaman;

  const ListOfRoadTextFormField({
    Key? key,
    required this.text,
    required this.hintText,
    required this.fontSize,
    required this.fillColor,
    required this.iconCondition,
    required this.data,
    this.screen,
    this.scMainId,
    this.namaTaman,
  }) : super(key: key);

  @override
  ListOfRoadTextFormFieldState createState() => ListOfRoadTextFormFieldState();
}

class ListOfRoadTextFormFieldState extends State<ListOfRoadTextFormField> {
  final TextEditingController namaJalan = TextEditingController();
  late int idJalan = 0;
  int selectedIndex = -1;

  int totalJalan = 0;

  // getTotalData() {
  //   JalanApi.getJalanData(context).then((value) {
  //     if (value.isNotEmpty) {
  //       setState(() {
  //         totalJalan = value.length;
  //       });
  //     }
  //   });

  //   if (widget.data != "") {
  //     setState(() {
  //       namaJalan.text = widget.data;
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getTotalData();
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
          label: const Text('Jalan'),
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
                  ? (enabledBorderWithText)
                  : (enabledBorderWithoutText),
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
          if ((value == null || value.isEmpty) && widget.screen != "4") {
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
            : const BoxConstraints(maxHeight: 380),
        context: context,
        builder: (builder) {
          return Container(
            padding: const EdgeInsets.only(top: 5),
            child: ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(
                          thickness: 0.5,
                          color: Color(0xff969696),
                          indent: 160,
                          endIndent: 160,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 30,
                            bottom: 10,
                          ),
                          child: Text(
                            "Pilih Jalan",
                            style: TextStyle(
                              color: greyCustom,
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
                            future: JalanApi.getDataJalan(widget.scMainId!),
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(CustomIcon.exclamation,
                                                  color: Colors.orange,
                                                  size: 14),
                                              const SizedBox(width: 10),
                                              Text(
                                                  "Tiada senarai jalan dijumpai",
                                                  style: TextStyle(
                                                      color: grey500)),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      //checking if there is nama taman id is passed, else show all
                                      List<dynamic> newList = [];
                                      for (int i = 0;
                                          i < dataFuture.length;
                                          i++) {
                                        if (dataFuture[i].parkName ==
                                            widget.namaTaman) {
                                          newList.add(dataFuture[i]);
                                        }
                                      }

                                      if (newList.isEmpty) {
                                        return Container(
                                          color: white,
                                          height: userRole == 200
                                              ? Sizes().screenHeight(context) *
                                                  0.24
                                              : Sizes().screenHeight(context) *
                                                  0.18,
                                          child: Container(
                                            margin: userRole == 100 &&
                                                    Orientations()
                                                        .isTabletPortrait(
                                                            context)
                                                ? const EdgeInsets.symmetric(
                                                    horizontal: 60,
                                                    vertical: 40)
                                                : const EdgeInsets.symmetric(
                                                    horizontal: 25,
                                                    vertical: 15),
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              children: [
                                                const Icon(
                                                    CustomIcon.exclamation,
                                                    color: Colors.orange,
                                                    size: 14),
                                                const SizedBox(width: 10),
                                                Text(
                                                  notFoundStreet,
                                                  style:
                                                      TextStyle(color: grey400),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }

                                      return Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: newList.length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      namaJalan.text =
                                                          newList[index]
                                                              .streetName;

                                                      selectedIndex = index;
                                                      idJalan = newList[index]
                                                          .streetId;

                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 16),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                            namaJalan.text !=
                                                                        "" &&
                                                                    selectedIndex ==
                                                                        index
                                                                ? Icons.check
                                                                : null,
                                                            color: green,
                                                            size: 18),
                                                        const SizedBox(
                                                            width: 8),
                                                        Text(
                                                            newList[index]
                                                                .streetName,
                                                            style: TextStyle(
                                                              color:
                                                                  blackCustom,
                                                              fontSize: 15,
                                                              fontWeight: namaJalan
                                                                              .text !=
                                                                          "" &&
                                                                      selectedIndex ==
                                                                          index
                                                                  ? FontWeight
                                                                      .w600
                                                                  : FontWeight
                                                                      .w400,
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }));
                                    }
                                  }
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
    return null;
  }
}
