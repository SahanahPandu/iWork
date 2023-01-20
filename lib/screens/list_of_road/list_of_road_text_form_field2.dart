import 'package:eswm/models/schedule/filter/schedule_filter_streets.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../utils/device/orientations.dart';
import '../../widgets/custom_scroll/custom_scroll.dart';

class ListOfRoadTextFormField2 extends StatefulWidget {
  final Map<String, dynamic>? uiData;
  final List<ScheduleFilterStreets>? data;
  final Function(String, dynamic)? updateData;

  const ListOfRoadTextFormField2({
    Key? key,
    this.uiData,
    this.data,
    this.updateData,
  }) : super(key: key);

  @override
  ListOfRoadTextFormField2State createState() =>
      ListOfRoadTextFormField2State();
}

class ListOfRoadTextFormField2State extends State<ListOfRoadTextFormField2> {
  final TextEditingController namaJalan = TextEditingController();
  late int idJalan = 0;
  int selectedIndex = -1;

  int totalJalan = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showListOfRoads();
      },
      child: TextFormField(
        style: widget.uiData?['style'],
        controller: widget.uiData?['controller'],
        readOnly: true,
        enabled: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.uiData?['fillColor'],
          contentPadding: userRole == 100
              ? const EdgeInsets.symmetric(vertical: 15, horizontal: 20)
              : const EdgeInsets.all(8),
          hintText: "Semua",
          hintStyle: widget.uiData?['hintStyle'],
          suffixIcon: widget.uiData?['clickable']
              ? const Icon(
                  Icons.expand_more,
                  size: 20,
                  color: Color(0xff2B2B2B),
                )
              : null,
          label: const Text('Jalan'),
          labelStyle: widget.uiData?['labelStyle'],
          disabledBorder: widget.uiData?['disableBorder'],
          errorStyle: const TextStyle(height: 0),
          errorBorder: widget.uiData?['errorBorder'],
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
                            right: 30,
                            bottom: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Pilih Jalan",
                                style: TextStyle(
                                  color: greyCustom,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (widget.updateData != null) {
                                      widget.updateData!('reset', "");
                                    }
                                  });
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Reset",
                                  style: TextStyle(
                                    color: Color(0xff969696),
                                    fontSize: 15,
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
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.data!.length,
                              itemBuilder: (context, index) {
                                var theData = widget.data;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (widget.updateData != null) {
                                        widget.updateData!('jalan', {
                                          'id': theData![index].streetId,
                                          'name': theData[index].streetName,
                                        });
                                      }
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    child: Row(
                                      children: [
                                        // Icon(selectedIndex == index ? Icons.check : null,
                                        //     color: green, size: 18),
                                        const SizedBox(width: 8),
                                        Text(theData![index].streetName,
                                            style: TextStyle(
                                              color: blackCustom,
                                              fontSize: 15,
                                              fontWeight:
                                                  //selectedIndex == index
                                                  //     ? FontWeight.w600
                                                  FontWeight.w400,
                                            )),
                                      ],
                                    ),
                                  ),
                                );
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
