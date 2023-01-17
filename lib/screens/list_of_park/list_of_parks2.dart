import 'package:eswm/models/schedule/filter/schedule_filter_parks.dart';
import 'package:flutter/material.dart';

import '../../config/config.dart';
import '../../config/palette.dart';
import '../../utils/device/orientations.dart';
import '../../widgets/custom_scroll/custom_scroll.dart';

class ListOfParks2 extends StatefulWidget {
  final Map<String, dynamic>? uiData;
  final List<ScheduleFilterParks>? data;

  final Function(String, dynamic)? updateData;

  const ListOfParks2({
    Key? key,
    this.uiData,
    this.data,
    this.updateData,
  }) : super(key: key);

  @override
  State<ListOfParks2> createState() => _ListOfParks2State();
}

class _ListOfParks2State extends State<ListOfParks2> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showListOfParks();
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
          label: const Text('Semua'),
          labelStyle: widget.uiData?['labelStyle'],
          errorStyle: const TextStyle(height: 0),
          errorBorder: widget.uiData?['errorBorder'],
          disabledBorder: widget.uiData?['disableBorder'],
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
          padding: const EdgeInsets.only(
            top: 5,
          ),
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
                        "Pilih Taman",
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
                                    widget.updateData!('taman', {
                                      'id': theData![index].parkId,
                                      'name': theData[index].parkName,
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
                                    Text(theData![index].parkName,
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
                ),
              ]),
            ),
          ),
        );
      },
    );
    return null;
  }
}
