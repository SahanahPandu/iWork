import 'package:eswm/models/schedule/filter/schedule_filter_status.dart';
import 'package:eswm/providers/jadual_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:multi_select_flutter/multi_select_flutter.dart';

//import files
import '../../config/config.dart';
import '../../config/dimen.dart';
import '../../config/palette.dart';
import '../../utils/device/sizes.dart';
import '../../utils/icon/custom_icon.dart';
import '../../widgets/custom_scroll/custom_scroll.dart';
import '../../widgets/gridview/compactor_panel/compactor_task_list.dart';
import '../../widgets/listview/card_list_view.dart';

class ScheduleAllMainScreen extends StatefulWidget {
  const ScheduleAllMainScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleAllMainScreen> createState() => _ScheduleIssueMainScreen();
}

class _ScheduleIssueMainScreen extends State<ScheduleAllMainScreen> {
  final TextEditingController _filteredDate = TextEditingController();
  DateTime filteredDate = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: barShadowColor,
              offset: const Offset(0, 3),
              blurRadius: 8,
            )
          ]),
          child: AppBar(
            backgroundColor: white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(CustomIcon.arrowBack, color: blackCustom, size: 22),
            ),
            title: Center(
              child: Text(
                "Jadual Tugasan",
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _filteredDate.text =
                        DateFormat('dd-MM-yyyy').format(filteredDate);
                  });
                  displayFilterBottomSheet(context);
                },
                icon: Icon(
                  CustomIcon.filter,
                  color: blackCustom,
                  size: 13,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: SingleChildScrollView(
            child: userRole == 100
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.fromLTRB(30, 30, 0, 15),
                          child: const Text("Senarai Jadual Tugasan :",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400))),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: CompactorTaskList(main: false),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 10),
                        child: Text(
                          "Senarai Laluan Tugasan :",
                          style: TextStyle(
                              color: blackCustom,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: CardListView(
                          type: "Laluan",
                          screens: "drawer",
                        ),
                      ),
                    ],
                  )),
      ),
    );
  }

  Future<dynamic> displayFilterBottomSheet(context) {
    // ignore: unused_local_variable
    List<MultiSelectItem<dynamic>> theStatusList = [];
    JadualApi.getDataStatusJadual()!.then((statusList) {
      setState(() {
        theStatusList = statusList!
            .map((status) =>
                MultiSelectItem<ScheduleFilterStatus>(status!, status.name))
            .toList();
      });

      // print('Status: $theStatusList');
    });
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        constraints: BoxConstraints(
          maxHeight: Sizes().screenHeight(context) * 0.6,
          maxWidth: Sizes().screenWidth(context),
        ),
        context: context,
        builder: (builder) {
          return Container(
            margin: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Tapisan',
                    style: TextStyle(
                      color: blackCustom,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Divider(
                  thickness: 0.5,
                  color: greyCustom,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Tarikh',
                  style: TextStyle(
                    color: blackCustom,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    displayCupertinoDatePicker(context);
                  },
                  child: TextFormField(
                    controller: _filteredDate,
                    style: TextStyle(
                      color: blackCustom,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    readOnly: true,
                    enabled: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: borderSideWidth,
                          color: enabledBorderWithoutText,
                        ),
                        borderRadius: BorderRadius.circular(
                          borderRadiusCircular,
                        ),
                      ),
                      hintText: 'Tarikh',
                      hintStyle: TextStyle(
                        color: greyCustom,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      suffixIcon: Icon(
                        CustomIcon.scheduleOutline,
                        size: 16,
                        color: blackCustom,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Status',
                  style: TextStyle(
                    color: blackCustom,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: MultiSelectChipField(
                    height: 100,
                    showHeader: false,
                    scroll: false,
                    decoration: BoxDecoration(
                      border: Border.all(color: transparent),
                    ),
                    chipShape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    chipColor: const Color(0xffEFEFEF),
                    textStyle: const TextStyle(
                      color: Color(0xff969696),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    selectedChipColor: const Color(0xffC0E4FF),
                    selectedTextStyle: const TextStyle(
                      color: Color(0xff005B9E),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    items: [
                      MultiSelectItem<String?>("1", "Semua"),
                      MultiSelectItem<String?>("2", "Belum Mula"),
                      MultiSelectItem<String?>("3", "Sedang Bertugas"),
                      MultiSelectItem<String?>("4", "Selesai"),
                      MultiSelectItem<String?>("5", "Dihentikan"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: Sizes().screenWidth(context) * 0.4,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            shadowColor: MaterialStateProperty.all(transparent),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Color(0xffE5E5E5),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Batal',
                              style: TextStyle(
                                color: greyCustom,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: Sizes().screenWidth(context) * 0.4,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            shadowColor: MaterialStateProperty.all(transparent),
                            backgroundColor:
                                MaterialStateProperty.all(greenCustom),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Pasti',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future<dynamic> displayCupertinoDatePicker(context) {
    DateTime todayDate = DateTime.now();
    DateTime getDate = todayDate;
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        constraints: BoxConstraints(
          maxHeight: Sizes().screenHeight(context) * 0.4,
          maxWidth: Sizes().screenWidth(context),
        ),
        context: context,
        builder: (builder) {
          return Container(
            margin: const EdgeInsets.all(28),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Kembali',
                          style: TextStyle(
                            color: Color(0xffA4A4A4),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        'Pilih Tarikh',
                        style: TextStyle(
                          color: blackCustom,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _filteredDate.text =
                                DateFormat('dd-MM-yyyy').format(getDate);
                            filteredDate = getDate;
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Pasti',
                          style: TextStyle(
                            color: greenCustom,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: greyCustom,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  height: Sizes().screenHeight(context) * 0.2,
                  child: CupertinoDatePicker(
                    backgroundColor: Colors.white,
                    dateOrder: DatePickerDateOrder.dmy,
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: filteredDate,
                    onDateTimeChanged: (theDate) {
                      getDate = theDate;
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
