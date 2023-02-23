import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

//import files
import '../../../config/config.dart';
import '../../../config/dimen.dart';
import '../../../config/palette.dart';
import '../../../models/vc/status/vc_filter_status.dart';
import '../../../providers/vehicle_checklist/vehicle_checklist_api.dart';
import '../../../utils/calendar/date.dart';
import '../../../utils/device/sizes.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/custom_scroll/custom_scroll.dart';
import 'vehicle_checklist_list.dart';

class VehicleChecklistListMain extends StatefulWidget {
  const VehicleChecklistListMain({Key? key}) : super(key: key);

  @override
  State<VehicleChecklistListMain> createState() =>
      _VehicleChecklistListMainState();
}

class _VehicleChecklistListMainState extends State<VehicleChecklistListMain> {
  final TextEditingController _filteredDate = TextEditingController();
  String selectedDate = "";
  DateTime filteredDate = DateTime.now();
  List<VcStatus> preSelectStatus = [];
  List<VcStatus> selectedStatus = [];
  bool displayFilterSection = false;
  bool changeIcon = false;

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
                "Semakan Kenderaan",
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            actions: const [SizedBox(width: 50)],
          ),
        ),
      ),
      body: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: Stack(children: [
          Padding(
            padding: userRole == 100
                ? const EdgeInsets.only(left: 30, right: 30, top: 50)
                : EdgeInsets.only(
                    left: 8, right: 8, top: displayFilterSection ? 85 : 45),
            child: userRole == 100
                ? const VehicleChecklistList()
                : displayFilterSection
                    ? VehicleChecklistList(passData: {
                        "filteredDate": selectedDate,
                        "selectedStatus": selectedStatus,
                      })
                    : const VehicleChecklistList(),
          ),
          Container(
            color: white,
            padding: userRole == 100
                ? const EdgeInsets.fromLTRB(40, 20, 30, 5)
                : const EdgeInsets.fromLTRB(16, 0, 4, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Senarai Semakan Kenderaan :",
                    style: TextStyle(
                        color: blackCustom,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
                userRole != 100
                    ? IconButton(
                        tooltip: "Pilih untuk buat tapisan semakan kenderaan",
                        splashColor: transparent,
                        highlightColor: transparent,
                        onPressed: () {
                          setState(() {
                            preSelectStatus = List.from(selectedStatus);
                          });

                          displayFilterBottomSheet(context);
                        },
                        icon: Icon(
                          CustomIcon.filter,
                          color: blackCustom,
                          size: 13,
                        ),
                      )
                    : const SizedBox(width: 50)
              ],
            ),
          ),
          if (displayFilterSection) filteredSection(),
        ]),
      ),
    );
  }

  Future<dynamic> displayFilterBottomSheet(context) async {
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
          maxHeight: Sizes().screenHeight(context) * 0.61,
          maxWidth: Sizes().screenWidth(context),
        ),
        context: context,
        builder: (builder) {
          return Stack(
            children: [
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setModalState) {
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
                        height: 16,
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: Color(0xffd7d7d7),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Expanded(
                        child: ListView(
                          children: [
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
                            TextFormField(
                              onTap: () {
                                displayCupertinoDatePicker(
                                    context, setModalState);
                              },
                              controller: _filteredDate,
                              style: TextStyle(
                                color: blackCustom,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                              readOnly: true,
                              // enabled: false,
                              decoration: InputDecoration(
                                enabled: true,
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: borderSideWidth,
                                    color: const Color(0xffd7d7d7),
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    borderRadiusCircular,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: borderSideWidth,
                                    color: const Color(0xffd7d7d7),
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    borderRadiusCircular,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: borderSideWidth,
                                    color: const Color(0xffd7d7d7),
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    borderRadiusCircular,
                                  ),
                                ),
                                hintText: 'dd/mm/yyyy',
                                hintStyle: TextStyle(
                                  color: greyCustom,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                                suffixIcon: changeIcon
                                    ? InkWell(
                                        onTap: () {
                                          setModalState(() {
                                            changeIcon = false;
                                            _filteredDate.text = "";
                                            filteredDate = DateTime.now();
                                          });
                                        },
                                        child: Icon(
                                          CustomIcon.cross,
                                          size: 16,
                                          color: blackCustom,
                                        ),
                                      )
                                    : Icon(
                                        CustomIcon.scheduleOutline,
                                        size: 16,
                                        color: blackCustom,
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
                              height: 14,
                            ),
                            FutureBuilder<List<VcStatus?>?>(
                              future: VehicleChecklistApi.getVcStatus(context),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );

                                  default:
                                    final statusData = snapshot.data;
                                    if (snapshot.hasData) {
                                      return StatefulBuilder(builder:
                                          (BuildContext context,
                                              StateSetter setState) {
                                        return Wrap(
                                          runSpacing: 2,
                                          spacing: 14,
                                          children: statusData!
                                              .map(
                                                (status) => FilterChip(
                                                  label: Text(
                                                    status!.name,
                                                  ),
                                                  labelStyle: TextStyle(
                                                    color: preSelectStatus
                                                            .where((theStatus) =>
                                                                theStatus.code
                                                                    .contains(
                                                                        status
                                                                            .code))
                                                            .isNotEmpty
                                                        ? const Color(
                                                            0xff005B9E)
                                                        : const Color(
                                                            0xff969696),
                                                    // Color(0xff969696),
                                                  ),
                                                  backgroundColor:
                                                      const Color(0xffEFEFEF),
                                                  showCheckmark: false,
                                                  selected: preSelectStatus
                                                          .where((theStatus) =>
                                                              theStatus.code
                                                                  .contains(
                                                                      status
                                                                          .code))
                                                          .isNotEmpty
                                                      ? true
                                                      : false,
                                                  selectedColor:
                                                      const Color(0xffC0E4FF),
                                                  onSelected: (clicked) {
                                                    setState(() {
                                                      if (clicked) {
                                                        var data = preSelectStatus
                                                            .where((theStatus) =>
                                                                theStatus.code
                                                                    .contains(status
                                                                        .code));

                                                        if (data.isEmpty) {
                                                          //if not exist then add
                                                          preSelectStatus
                                                              .add(status);
                                                        } else {
                                                          preSelectStatus
                                                              .remove(status);
                                                        }
                                                      } else {
                                                        preSelectStatus
                                                            .removeWhere(
                                                                (theStatus) =>
                                                                    theStatus
                                                                        .code ==
                                                                    status
                                                                        .code);
                                                      }
                                                    });
                                                  },
                                                ),
                                              )
                                              .toList(),
                                        );
                                      });
                                    } else {
                                      return Center(
                                          child: Container(
                                        margin: const EdgeInsets.all(20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(CustomIcon.exclamation,
                                                color: Colors.orange, size: 14),
                                            const SizedBox(width: 10),
                                            Text("Tiada rekod dijumpai",
                                                style:
                                                    TextStyle(color: grey500)),
                                          ],
                                        ),
                                      ));
                                    }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  height: Sizes().screenHeight(context) * 0.1,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 20,
                        offset: Offset(10, 20),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: Sizes().screenWidth(context) * 0.4,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shadowColor:
                                  MaterialStateProperty.all(transparent),
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
                      SizedBox(
                        width: Sizes().screenWidth(context) * 0.4,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              selectedDate = _filteredDate.text;
                              selectedStatus = preSelectStatus;
                              displayFilterSection = true;
                            });
                          },
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
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<dynamic> displayCupertinoDatePicker(
      context, StateSetter setModalState) {
    DateTime getDate = DateTime.now();
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
                          setModalState(() {
                            changeIcon = true;
                          });
                          setState(() {
                            _filteredDate.text = Date.getTheDate(
                                getDate, '', 'dd/MM/yyyy', 'ms');

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
                const Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: Color(0xffd7d7d7),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  height: Sizes().screenHeight(context) * 0.2,
                  child: Localizations.override(
                    delegates: const [
                      GlobalMaterialLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      DefaultWidgetsLocalizations.delegate,
                    ],
                    context: context,
                    locale: const Locale('ms'),
                    child: CupertinoDatePicker(
                      backgroundColor: Colors.white,
                      dateOrder: DatePickerDateOrder.dmy,
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: filteredDate,
                      maximumYear: 2024,
                      minimumYear: 2022,
                      onDateTimeChanged: (theDate) {
                        getDate = theDate;
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget filteredSection() {
    return Container(
      padding: const EdgeInsets.only(left: 14, top: 30, right: 14, bottom: 5),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 35,
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _filteredDate.text = "";
                      filteredDate = DateTime.now();
                      selectedStatus.clear();
                      displayFilterSection = false;
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xffD9D9D9),
                      ),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        "Reset",
                        style: TextStyle(
                          color: blackCustom,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                if (selectedDate != "")
                  Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xffE7F5FF),
                          border: Border.all(
                            color: const Color(0xffC0E4FF),
                          ),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Row(
                          children: [
                            Text(
                              selectedDate,
                              style: const TextStyle(
                                color: Color(0xff005B9E),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              radius: 20,
                              onTap: () {
                                setState(() {
                                  changeIcon = false;
                                  _filteredDate.text = "";
                                  selectedDate = "";
                                  filteredDate = DateTime.now();
                                  if (selectedStatus.isEmpty) {
                                    displayFilterSection = false;
                                  }
                                });
                              },
                              child: const Icon(
                                Icons.close,
                                color: Color(0xff005B9E),
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 8,
                      );
                    },
                    itemCount: selectedStatus.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xffE7F5FF),
                          border: Border.all(
                            color: const Color(0xffC0E4FF),
                          ),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Row(
                          children: [
                            Text(
                              selectedStatus[index].name,
                              style: const TextStyle(
                                color: Color(0xff005B9E),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                              radius: 20,
                              onTap: () {
                                setState(() {
                                  selectedStatus.remove(selectedStatus[index]);
                                  if (selectedStatus.isEmpty &&
                                      _filteredDate.text == "") {
                                    displayFilterSection = false;
                                  }
                                });
                              },
                              child: const Icon(
                                Icons.close,
                                color: Color(0xff005B9E),
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
