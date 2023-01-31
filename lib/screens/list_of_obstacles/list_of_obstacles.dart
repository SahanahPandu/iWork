import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/dimen.dart';
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../providers/halangan_api.dart';
import '../../utils/device/orientations.dart';
import '../../utils/icon/custom_icon.dart';
import '../../widgets/custom_scroll/custom_scroll.dart';

class ListOfObstacles extends StatefulWidget {
  final String text;
  final String hintText;
  final double fontSize;
  final Color fillColor;
  final int iconCondition;
  final String data;
  final String? screen;

  const ListOfObstacles(
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
  ListOfObstaclesState createState() => ListOfObstaclesState();
}

class ListOfObstaclesState extends State<ListOfObstacles> {
  final TextEditingController jenisHalangan = TextEditingController();
  late int idJenisHalangan = 0;

  int totalHalangan = 0;
  int selectedIndex = -1;

  getTotalData() {
    HalanganApi.getHalanganData(context).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          totalHalangan = value.length;
        });
      }
    });

    if (widget.data != "") {
      // this is for get data from list and pass to form , to show pass data in text field
      setState(() {
        jenisHalangan.text = widget.data;
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
          showListOfObstacles();
        }
      },
      child: TextFormField(
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xff2B2B2B),
          fontWeight: FontWeight.w400,
        ),
        controller: jenisHalangan,
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
          label: const Text('Jenis Halangan'),
          labelStyle: TextStyle(
            fontSize: widget.fontSize,
            color: labelTextColor,
            fontWeight: textFormFieldLabelFontWeight,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: borderSideWidth,
              color: jenisHalangan.text != '' &&
                      widget.iconCondition == 1 &&
                      widget.screen == null
                  ? (enabledBorderWithText)
                  : (enabledBorderWithoutText),
            ),
            borderRadius: BorderRadius.circular(borderRadiusCircular),
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

  Widget? showListOfObstacles() {
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
                        Divider(
                          thickness: 0.5,
                          color: const Color(0xff969696),
                          indent: userRole == 100 ? 220 : 160,
                          endIndent: userRole == 100 ? 220 : 160,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 30,
                            bottom: 10,
                          ),
                          child: Text(
                            "Pilih Jenis Halangan",
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
                          child: FutureBuilder<List<dynamic>?>(
                            future: HalanganApi.getDataJenisHalangan(),
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
                                                  "Tiada senarai jenis halangan dijumpai",
                                                  style: TextStyle(
                                                      color: grey500)),
                                            ],
                                          ),
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
                                                  jenisHalangan.text =
                                                      dataFuture[index].name;
                                                  selectedIndex = index;
                                                  idJenisHalangan =
                                                      dataFuture[index].id;

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
                                                        jenisHalangan.text !=
                                                                    "" &&
                                                                selectedIndex ==
                                                                    index
                                                            ? Icons.check
                                                            : null,
                                                        color: green,
                                                        size: 18),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      dataFuture[index].name,
                                                      style: TextStyle(
                                                        color: blackCustom,
                                                        fontSize: 15,
                                                        fontWeight: jenisHalangan
                                                                        .text !=
                                                                    "" &&
                                                                selectedIndex ==
                                                                    index
                                                            ? FontWeight.w600
                                                            : FontWeight.w400,
                                                      ),
                                                    ),
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
