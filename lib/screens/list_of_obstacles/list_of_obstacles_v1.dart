import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/dimen.dart';
import '../../config/font.dart';
import '../../config/palette.dart';
import '../../providers/halangan_api.dart';
import '../../utils/device/orientations.dart';
import '../../utils/device/sizes.dart';

class ListOfObstacles extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color fillColor;
  final int iconCondition;
  final String data;

  const ListOfObstacles(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.fillColor,
      required this.iconCondition,
      required this.data})
      : super(key: key);

  @override
  State<ListOfObstacles> createState() => _ListOfObstaclesState();
}

class _ListOfObstaclesState extends State<ListOfObstacles> {
  final TextEditingController _jenisHalangan = TextEditingController();

  int totalHalangan = 0;

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
        _jenisHalangan.text = widget.data;
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
          showListOfObstacles();
        }
      },
      child: TextFormField(
        controller: _jenisHalangan,
        readOnly: true,
        enabled: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor,
          contentPadding: userRole == 100
              ? const EdgeInsets.symmetric(vertical: 15, horizontal: 20)
              : const EdgeInsets.all(10),
          suffixIcon: widget.iconCondition == 1
              ? const Icon(
                  Icons.expand_more,
                  size: 20,
                  color: Color(0xff2B2B2B),
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
              color: _jenisHalangan.text != '' && widget.iconCondition == 1
                  ? (enabledBorderWithText)
                  : (enabledBorderWithoutText),
            ),
            borderRadius: BorderRadius.circular(borderRadiusCircular),
          ),
        ),
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
                    top: userRole == 100 ? 30 : 25,
                    left: userRole == 100 ? 30 : 25,
                    bottom: 10,
                  ),
                  child: Text(
                    "${totalHalangan.toString()} Senarai Jenis Halangan",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                FutureBuilder<List>(
                  future: HalanganApi.getHalanganData(context),
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
                                        _jenisHalangan.text =
                                            dataFuture[index].namaHalangan;

                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Container(
                                      margin: userRole == 100
                                          ? null
                                          : const EdgeInsets.symmetric(
                                              vertical: 12),
                                      padding: userRole == 100
                                          ? const EdgeInsets.symmetric(
                                              vertical: 23, horizontal: 5)
                                          : const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide.none,
                                          bottom: BorderSide(
                                            color: grey400,
                                            width: userRole == 100 ? 0.3 : 0.9,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        dataFuture[index].namaHalangan,
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
