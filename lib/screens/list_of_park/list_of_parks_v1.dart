import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/dimen.dart';
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../providers/taman_api.dart';
import '../../utils/device/orientations.dart';
import '../../utils/device/sizes.dart';

class ListOfParks extends StatefulWidget {
  final Function(dynamic, dynamic)? showSenaraiJalan;
  final String hintText;
  final double fontSize;
  final int borderCondition;
  final Color fillColor;
  final int iconCondition;
  final String data;

  const ListOfParks(
      {Key? key,
      required this.showSenaraiJalan,
      required this.hintText,
      required this.fontSize,
      required this.borderCondition,
      required this.fillColor,
      required this.iconCondition,
      required this.data})
      : super(key: key);

  @override
  State<ListOfParks> createState() => _ListOfParksState();
}

class _ListOfParksState extends State<ListOfParks> {
  final TextEditingController _namaTaman = TextEditingController();

  int totalTaman = 0;

  getTotalData() {
    TamanApi.getTamanData(context).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          totalTaman = value.length;
        });
      }
    });

    if (widget.data != "") {
      setState(() {
        _namaTaman.text = widget.data;
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
          userRole == 200 ? null : BorderRadius.circular(borderRadiusCircular),
      onTap: () {
        if (widget.iconCondition == 1) {
          showListOfParks();
        }
      },
      child: TextFormField(
        controller: _namaTaman,
        readOnly: true,
        enabled: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor,
          contentPadding: userRole == 200
              ? const EdgeInsets.all(8)
              : const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
          labelText: widget.borderCondition == 1 && widget.iconCondition == 1
              ? widget.hintText
              : null,
          labelStyle: widget.borderCondition == 1 && widget.iconCondition == 1
              ? TextStyle(
                  fontSize: widget.fontSize,
                  color: labelTextColor,
                  fontWeight: textFormFieldLabelFontWeight,
                )
              : null,
          disabledBorder: OutlineInputBorder(
            borderSide: widget.borderCondition == 0
                ? BorderSide.none
                : BorderSide(
                    width: borderSideWidth,
                    color: _namaTaman.text != '' && widget.iconCondition == 1
                        ? (userRole == 200 ? enabledBorderWithText : grey100)
                        : (userRole == 200
                            ? enabledBorderWithoutText
                            : grey100),
                  ),
            borderRadius: BorderRadius.circular(borderRadiusCircular),
          ),
        ),
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
            : null,
        context: context,
        builder: (builder) {
          return SizedBox(
            height:
                userRole == 100 ? null : Sizes().screenHeight(context) * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: userRole == 200 ? 25 : 30,
                    left: userRole == 200 ? 25 : 30,
                    bottom: 10,
                  ),
                  child: Text(
                    "${totalTaman.toString()} Senarai Taman",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: userRole == 100 || userRole == 200 ? 16 : 14,
                      fontWeight: userRole == 100 || userRole == 200
                          ? FontWeight.w500
                          : FontWeight.w600,
                    ),
                  ),
                ),
                FutureBuilder<List>(
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
                          return Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              padding: userRole == 200
                                  ? const EdgeInsets.all(6)
                                  : const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                              child: ListView.builder(
                                physics: userRole == 200
                                    ? const ScrollPhysics()
                                    : const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: dataFuture!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      if (widget.showSenaraiJalan != null) {
                                        widget.showSenaraiJalan!(
                                            dataFuture[index].id,
                                            dataFuture[index].namaTaman);
                                      }

                                      setState(() {
                                        _namaTaman.text =
                                            dataFuture[index].namaTaman;

                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Container(
                                      margin: userRole == 200
                                          ? const EdgeInsets.symmetric(
                                              vertical: 12)
                                          : null,
                                      padding: userRole == 200
                                          ? const EdgeInsets.all(6)
                                          : (userRole == 100
                                              ? const EdgeInsets.symmetric(
                                                  vertical: 23, horizontal: 5)
                                              : (const EdgeInsets.symmetric(
                                                  vertical: 18,
                                                  horizontal: 4))),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide.none,
                                          bottom: BorderSide(
                                            color: grey400,
                                            width: userRole == 200 ? 0.9 : 0.3,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        dataFuture[index].namaTaman,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize:
                                              userRole == 100 || userRole == 200
                                                  ? 16
                                                  : 14,
                                          fontWeight:
                                              userRole == 100 || userRole == 200
                                                  ? FontWeight.w500
                                                  : FontWeight.w600,
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
