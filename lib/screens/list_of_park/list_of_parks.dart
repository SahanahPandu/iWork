import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../providers/taman_api.dart';
import '../../utils/icon/custom_icon.dart';
import '../../utils/device/orientations.dart';
import '../../widgets/custom_scroll/custom_scroll.dart';

class ListOfParks extends StatefulWidget {
  final int? subRoutesId;
  final Function(dynamic, dynamic)? showSenaraiJalan;
  final String hintText;
  final double fontSize;
  final Color fillColor;
  final int iconCondition;
  final String data;
  final String? screen;

  const ListOfParks(
      {Key? key,
      this.subRoutesId,
      required this.showSenaraiJalan,
      required this.hintText,
      required this.fontSize,
      required this.fillColor,
      required this.iconCondition,
      required this.data,
      this.screen})
      : super(key: key);

  @override
  ListOfParksState createState() => ListOfParksState();
}

class ListOfParksState extends State<ListOfParks> {
  final TextEditingController namaTaman = TextEditingController();
  int selectedIndex = -2;

  getTotalData() {
    if (widget.data != "") {
      setState(() {
        namaTaman.text = widget.data;
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
          showListOfParks();
        }
      },
      child: TextFormField(
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xff2B2B2B),
          fontWeight: FontWeight.w400,
        ),
        controller: namaTaman,
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
            child: const Text('Taman'),
          ),
          labelStyle: TextStyle(
            fontSize: widget.fontSize,
            color: labelTextColor,
            fontWeight: textFormFieldLabelFontWeight,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: borderSideWidth,
              color: namaTaman.text != '' &&
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
          if (value == null || value.isEmpty) {
            return '';
          }

          return null;
        },
      ),
    );
  }

  Widget? showListOfParks() {
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
                              "Pilih Taman",
                              style: TextStyle(
                                color: greyCustom,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 26, right: 26, top: 8),
                            child: Divider(height: 0.5),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: FutureBuilder<List>(
                                  future: TamanApi.getTamanData(context),
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
                                          //checking if there is sub laluan id is passed, else show all
                                          if (widget.subRoutesId != null &&
                                              widget.subRoutesId != 0) {
                                            dataFuture!.removeWhere((item) =>
                                                item.idSubLaluan !=
                                                widget.subRoutesId);
                                          }
                                          if (dataFuture!.isEmpty) {
                                            return Center(
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.all(20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                        CustomIcon.exclamation,
                                                        color: Colors.orange,
                                                        size: 14),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                        "Tiada senarai taman dijumpai",
                                                        style: TextStyle(
                                                            color: grey500)),
                                                  ],
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: ListView.builder(
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        dataFuture.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return InkWell(
                                                          onTap: () {
                                                            if (widget
                                                                    .showSenaraiJalan !=
                                                                null) {
                                                              widget.showSenaraiJalan!(
                                                                  dataFuture[
                                                                          index]
                                                                      .id,
                                                                  dataFuture[
                                                                          index]
                                                                      .namaTaman);
                                                            }
                                                            setState(() {
                                                              namaTaman.text =
                                                                  dataFuture[
                                                                          index]
                                                                      .namaTaman;
                                                              if (namaTaman
                                                                      .text !=
                                                                  "") {
                                                                selectedIndex =
                                                                    index;
                                                              }
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          child: Container(
                                                              margin: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 16),
                                                              child: Row(
                                                                  children: [
                                                                    Icon(
                                                                        namaTaman.text != "" && selectedIndex == index
                                                                            ? Icons
                                                                                .check
                                                                            : null,
                                                                        color:
                                                                            green,
                                                                        size:
                                                                            18),
                                                                    const SizedBox(
                                                                        width:
                                                                            8),
                                                                    Text(
                                                                        dataFuture[index]
                                                                            .namaTaman,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              blackCustom,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight: namaTaman.text != "" && selectedIndex == index
                                                                              ? FontWeight.w600
                                                                              : FontWeight.w400,
                                                                        ))
                                                                  ])));
                                                    }));
                                          }
                                        }
                                    }
                                  }))
                        ])
                  ]))));
        });
    return null;
  }
}
