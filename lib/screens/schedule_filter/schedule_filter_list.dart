import 'package:eswm/models/schedule/filter/schedule_filter_main_routes.dart';
import 'package:eswm/models/schedule/filter/schedule_filter_parks.dart';
import 'package:eswm/models/schedule/filter/schedule_filter_sub_routes.dart';
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
  List<ScheduleFilterMainRoutes> dataLaluan = [];
  List<ScheduleFilterSubRoutes> dataSubLaluan = [];
  List<ScheduleFilterParks> dataTaman = [];

  List<ScheduleFilterMainRoutes>? senaraiLaluan = [];
  List<ScheduleFilterSubRoutes>? senaraiSubLaluan = [];
  List<ScheduleFilterParks>? senaraiTaman = [];

  //==================== end of variables ======================================

  //==================== Methods ===============================================

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    // ignore: unused_local_variable
    var fetchData =
        await ScheduleFilterApi.getDataScheduleFilter().then((theData) {
      setState(() {
        if (theData.mainRoute != null || theData.mainRoute != []) {
          dataLaluan.addAll(theData.mainRoute);
        }

        if (theData.subRoutes != null || theData.subRoutes != []) {
          dataSubLaluan.addAll(theData.subRoutes);
        }

        if (theData.parks != null || theData.parks != []) {
          dataTaman.addAll(theData.parks);
        }

        senaraiLaluan!.addAll(dataLaluan);
        senaraiSubLaluan!.addAll(dataSubLaluan);
        senaraiTaman!.addAll(dataTaman);
      });
    });
  }

  updateFilterItems(item, value) async {
    // ignore: unused_local_variable
    // var fetchData =
    //     await ScheduleFilterApi.getDataScheduleFilter().then((theData) {
    //   senaraiLaluan!.clear();
    //   senaraiSubLaluan!.clear();
    //   senaraiTaman!.clear();

    //   if (theData.mainRoute != null || theData.mainRoute != []) {
    //     dataLaluan.addAll(theData.mainRoute);
    //   }

    //   if (theData.subRoutes != null || theData.subRoutes != []) {
    //     dataSubLaluan.addAll(theData.subRoutes);
    //   }

    //   if (theData.parks != null || theData.parks != []) {
    //     dataTaman.addAll(theData.parks);
    //   }

    // });
    if (item == "laluan") {
      //filter sublaluan dropdown based on selected laluan
      dataSubLaluan.removeWhere((item) => item.mainRoute != value);

      //filter taman dropdown based on selected laluan
      if (namaSubLaluan.text != "") {
        //this is for case , laluan and sub laluan are selected
        dataTaman.removeWhere((item) =>
            item.mainRoute != value && item.subRoute == namaSubLaluan.text);
      } else {
        //this for if only laluan is selected
        dataTaman.removeWhere((item) => item.mainRoute != value);
      }

      setState(() {
        namaLaluan.text = value;
        senaraiLaluan!.addAll(dataLaluan);
        senaraiSubLaluan!.addAll(dataSubLaluan);
        senaraiTaman!.addAll(dataTaman);
      });
    } else if (item == "sub-laluan") {
      dataTaman.removeWhere((item) =>
          item.mainRoute != namaLaluan.text && item.subRoute != value);
      setState(() {
        namaSubLaluan.text = value;
        senaraiLaluan!.addAll(dataLaluan);
        senaraiSubLaluan!.addAll(dataSubLaluan);
        senaraiTaman!.addAll(dataTaman);
      });
    } else if (item == "taman") {
      setState(() {
        idTaman = value['id'];
        namaTaman.text = value['name'];
        senaraiLaluan!.addAll(dataLaluan);
        senaraiSubLaluan!.addAll(dataSubLaluan);
        senaraiTaman!.addAll(dataTaman);
      });
    }
  }

  //==================== end of Methods ========================================

  @override
  Widget build(BuildContext context) {
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
          data: senaraiLaluan,
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
          data: senaraiSubLaluan,
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
          data: senaraiTaman,
          updateData: updateFilterItems,
        ),

        //============== end of Taman =============================

        SizedBox(
          height: spaceBetweenItem,
        ),
      ],
    );
  }
}
