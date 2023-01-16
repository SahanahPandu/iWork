import 'package:eswm/screens/list_of_park/list_of_parks2.dart';
import 'package:eswm/screens/list_of_sub_routes/list_of_sub_routes.dart';
import 'package:flutter/material.dart';

import '../../config/dimen.dart';
import '../../config/font.dart';
import '../../config/palette.dart';
// import '../../models/schedule/filter/schedule_filter_data.dart';
import '../../providers/schedule_filter_api.dart';
import '../list_of_routes/list_of_routes.dart';

class ScheduleFilterList extends StatefulWidget {
  const ScheduleFilterList({Key? key}) : super(key: key);

  @override
  ScheduleFilterListState createState() => ScheduleFilterListState();
}

class ScheduleFilterListState extends State<ScheduleFilterList> {
  //==================== UI default=============================================

  double spaceBetweenItem = 24;
  double spaceBetweenLabel = 16;
  TextStyle textFormFieldStyle = const TextStyle(
    fontSize: 15,
    color: Color(0xff2B2B2B),
    fontWeight: FontWeight.w400,
  );
  Color textFieldFillColor = Colors.white;
  TextStyle textLabelStyle = TextStyle(
    color: blackCustom,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  TextStyle hintTextStyle = TextStyle(
    fontSize: 15,
    color: labelTextColor,
    fontWeight: textFormFieldLabelFontWeight,
  );

  bool clickable = true;
  TextStyle textFormFieldLabelStyle = TextStyle(
    fontSize: 15,
    color: labelTextColor,
    fontWeight: textFormFieldLabelFontWeight,
  );

  InputBorder errorBorderStyle = OutlineInputBorder(
    borderSide: BorderSide(width: borderSideWidth, color: Colors.red),
    borderRadius: BorderRadius.circular(borderRadiusCircular),
  );

  InputBorder disableBorderStyle = OutlineInputBorder(
    borderSide: BorderSide(
      width: borderSideWidth,
      color: enabledBorderWithoutText,
    ),
    borderRadius: BorderRadius.circular(
      borderRadiusCircular,
    ),
  );
  //==================== end of UI default======================================

  //==================== variables =============================================
  final TextEditingController namaLaluan = TextEditingController();
  final TextEditingController namaSubLaluan = TextEditingController();
  final TextEditingController namaTaman = TextEditingController();

  int idTaman = 0;

  //==================== end of variables ======================================

  //==================== Methods ===============================================

  updateFilterItems(item, value) {
    if (item == "laluan") {
      setState(() {
        namaLaluan.text = value;
      });
    } else if (item == "sub-laluan") {
      setState(() {
        namaSubLaluan.text = value;
      });
    } else if (item == "taman") {
      setState(() {
        idTaman = value['id'];
        namaTaman.text = value['name'];
      });
    }
  }

  //==================== end of Methods ========================================

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ScheduleFilterApi.getDataScheduleFilter(
        namaLaluan.text,
        namaSubLaluan.text,
        idTaman,
      ),
      builder: (context, snapshot) {
        var listData = snapshot.data;

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );

          default:
            if (snapshot.hasError) {
              return const Center(
                child: Text('Some error while fetch the data!'),
              );
            } else {
              if (listData != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //============== Laluan ====================================
                    Text(
                      "Laluan",
                      style: textLabelStyle,
                    ),
                    SizedBox(
                      height: spaceBetweenLabel,
                    ),

                    ListOfRoutes(
                      uiData: {
                        "style": textFormFieldStyle,
                        "controller": namaLaluan,
                        "fillColor": textFieldFillColor,
                        "hintStyle": hintTextStyle,
                        "clickable": clickable,
                        "labelStyle": textFormFieldLabelStyle,
                        "errorBorder": errorBorderStyle,
                        "disableBorder": disableBorderStyle,
                      },
                      data: listData,
                      updateData: updateFilterItems,
                    ),

                    //============== end of Laluan =============================

                    SizedBox(
                      height: spaceBetweenItem,
                    ),

                    //============== Sub-Laluan ================================
                    Text(
                      "Sub-Laluan",
                      style: textLabelStyle,
                    ),
                    SizedBox(
                      height: spaceBetweenLabel,
                    ),

                    ListOfSubRoutes(
                      uiData: {
                        "style": textFormFieldStyle,
                        "controller": namaSubLaluan,
                        "fillColor": textFieldFillColor,
                        "hintStyle": hintTextStyle,
                        "clickable": clickable,
                        "labelStyle": textFormFieldLabelStyle,
                        "errorBorder": errorBorderStyle,
                        "disableBorder": disableBorderStyle,
                      },
                      data: listData,
                      updateData: updateFilterItems,
                    ),

                    //============== end of Sub-Laluan =========================
                    SizedBox(
                      height: spaceBetweenItem,
                    ),
                    //============== Taman ====================================
                    Text(
                      "Taman",
                      style: textLabelStyle,
                    ),
                    SizedBox(
                      height: spaceBetweenLabel,
                    ),

                    ListOfParks2(
                      uiData: {
                        "style": textFormFieldStyle,
                        "controller": namaTaman,
                        "fillColor": textFieldFillColor,
                        "hintStyle": hintTextStyle,
                        "clickable": clickable,
                        "labelStyle": textFormFieldLabelStyle,
                        "errorBorder": errorBorderStyle,
                        "disableBorder": disableBorderStyle,
                      },
                      data: listData,
                      updateData: updateFilterItems,
                    ),

                    //============== end of Taman =============================

                    SizedBox(
                      height: spaceBetweenItem,
                    ),
                  ],
                );
              } else {
                return const Text('No Data');
              }
            }
        }
      },
    );
  }
}
