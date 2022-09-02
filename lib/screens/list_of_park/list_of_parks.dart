import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../providers/taman_api.dart';
import '../../utils/device.dart';

class ListOfParks extends StatefulWidget {
  final int? subRoutesId;
  final Function(dynamic, dynamic)? showSenaraiJalan;
  final String hintText;
  final double fontSize;
  final int borderCondition;
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
      required this.borderCondition,
      required this.fillColor,
      required this.iconCondition,
      required this.data,
      this.screen})
      : super(key: key);

  @override
  State<ListOfParks> createState() => _ListOfParksState();
}

class _ListOfParksState extends State<ListOfParks> {
  final TextEditingController _namaTaman = TextEditingController();
  final Devices _device = Devices();

  // int totalTaman = 0;

  getTotalData() {
    // TamanApi.getTamanData(context).then((value) {
    //   if (value.isNotEmpty) {
    //     setState(() {
    //       totalTaman = value.length;
    //     });
    //   }
    // });

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
                    color: _namaTaman.text != '' &&
                            widget.iconCondition == 1 &&
                            widget.screen == null
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
            ? (_device.isLandscape(context)
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
                Padding(
                  padding: EdgeInsets.only(
                    top: userRole == 200 ? 24 : 30,
                    left: userRole == 200 ? 24 : 30,
                    bottom: userRole == 200 ? 16 : 10,
                  ),
                  child: Text(
                    //"${totalTaman.toString()} Senarai Taman",
                    "Pilih Taman",
                    style: TextStyle(
                      color: const Color(0xff969696),
                      fontSize: userRole == 100 || userRole == 200 ? 15 : 14,
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
                                item.idSubLaluan != widget.subRoutesId);
                          }

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
                                      child: Text(
                                        dataFuture[index].namaTaman,
                                        style: TextStyle(
                                          color: blackCustom,
                                          fontSize:
                                              userRole == 100 || userRole == 200
                                                  ? 15
                                                  : 14,
                                          fontWeight:
                                              userRole == 100 || userRole == 200
                                                  ? FontWeight.w400
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
