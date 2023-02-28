import 'package:eswm/models/schedule/filter/schedule_filter_main_routes.dart';
import 'package:flutter/material.dart';

//imported files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../utils/device/orientations.dart';
import '../../widgets/custom_scroll/custom_scroll.dart';

class ListOfRoutes extends StatefulWidget {
  final Map<String, dynamic>? uiData;
  final List<ScheduleFilterMainRoutes>? data;
  final Function(String, dynamic)? updateData;
  final Function()? resetSelection;

  const ListOfRoutes({
    Key? key,
    this.uiData,
    this.data,
    this.updateData,
    this.resetSelection,
  }) : super(key: key);

  @override
  ListOfRoutesState createState() => ListOfRoutesState();
}

class ListOfRoutesState extends State<ListOfRoutes> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showListOfRoutes();
      },
      child: TextFormField(
        style: widget.uiData?['style'],
        controller: widget.uiData?['controller'],
        readOnly: true,
        enabled: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.uiData?['fillColor'],
          contentPadding: const EdgeInsets.all(8),
          hintText: 'Semua',
          hintStyle: widget.uiData?['hintStyle'],
          suffixIcon: widget.uiData?['clickable']
              ? const Icon(
                  Icons.expand_more,
                  size: 20,
                  color: Color(0xff2B2B2B),
                )
              : null,
          //removed label to display hint text "Semua"
          label: widget.uiData?['labelVisibility'] == true
              ? null
              : const Text('Laluan'),
          labelStyle: widget.uiData?['labelVisibility'] == true
              ? null
              : widget.uiData?['labelStyle'],
          errorStyle: const TextStyle(height: 0),
          errorBorder: widget.uiData?['errorBorder'],
          disabledBorder: widget.uiData?['disableBorder'],
        ),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return '';
        //   }

        //   return null;
        // },
      ),
    );
  }

  Widget? showListOfRoutes() {
    //check existing selection
    String? currSelLaluan = widget.uiData?['controller'].text;

    if (currSelLaluan != null && currSelLaluan != "") {
      if (widget.data != null && widget.data != []) {
        List<ScheduleFilterMainRoutes>? listOfLaluan = widget.data;

        var getIndex = listOfLaluan!
            .indexWhere((route) => route.mainRouteName == currSelLaluan);

        if (getIndex != -1) {
          //indexWhere will return -1 if there is no item found in the list
          setState(() {
            selectedIndex = getIndex;
          });
        }
      }
    }

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
          padding: const EdgeInsets.only(
            top: 5,
          ),
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: Stack(
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
                        right: 30,
                        bottom: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Kembali",
                              style: TextStyle(
                                color: Color(0xffA4A4A4),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "Pilih Laluan",
                            style: TextStyle(
                              color: blackCustom,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (widget.updateData != null) {
                                  widget.updateData!('reset', "");
                                }
                              });

                              widget.resetSelection!();
                              selectedIndex = -1;
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Reset",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 26, right: 26, top: 8),
                      child: Divider(height: 0.5),
                    ),
                    if (widget.data != null)
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.data!.length,
                            itemBuilder: (context, index) {
                              var theData = widget.data;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (widget.updateData != null) {
                                      widget.updateData!('laluan',
                                          theData![index].mainRouteName);
                                    }
                                  });
                                  selectedIndex = index;
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                          selectedIndex == index
                                              ? Icons.check
                                              : null,
                                          color: green,
                                          size: 18),
                                      const SizedBox(width: 8),
                                      Text(theData![index].mainRouteName,
                                          style: TextStyle(
                                            color: blackCustom,
                                            fontSize: 15,
                                            fontWeight: selectedIndex == index
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    return null;
  }
}
