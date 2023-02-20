import 'package:flutter/material.dart';

//import files
import '../../config/dimen.dart';
import '../../config/palette.dart';
import '../../models/penyelia_checkbox.dart';
import '../../providers/penyelia_api.dart';
import '../../utils/device/sizes.dart';
import '../../utils/icon/custom_icon.dart';
import '../../widgets/app_bar/app_bar_widget.dart';
import '../../widgets/search_box/search_box.dart';
import '../list_of_employees/absent_employee_details.dart';

class EmployeeList extends StatefulWidget {
  final dynamic absentEmployee;
  final Function(dynamic)? assignedEmployee;

  const EmployeeList({
    Key? key,
    this.absentEmployee,
    this.assignedEmployee,
  }) : super(key: key);

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  String? searchName;
  List<dynamic> svNameList = [];
  List<dynamic> svIdList = [];
  List<PenyeliaCheckBox> allSVName = [];
  List<PenyeliaCheckBox> selectedSVName = [];
  Color collapseBgColor = const Color(0xff2b7fe8);

  void getSearchName(name) {
    setState(() {
      searchName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes().screenHeight(context),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff3298F8),
            Color(0xff4A39BE),
          ],
          begin: Alignment.topCenter,
          end: Alignment.center,
        ),
      ),
      child: Scaffold(
        backgroundColor: transparent,
        appBar: AppBarWidget(
          bgColor: Colors.white.withOpacity(0.5),
          leadingIcon: CustomIcon.arrowBack,
          title: "Pilih Pekerja",
          listOfWidget: [
            IconButton(
              onPressed: () {
                showListOfSupervisor();
              },
              icon: Icon(
                Icons.filter_alt_rounded,
                color: blackCustom,
                size: 22,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //absent employee section
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: AbsentEmployeeDetails(
                  data: widget.absentEmployee,
                ),
              ),
              //employee list
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
                width: Sizes().screenWidth(context),
                height: Sizes().screenHeight(context),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Search Box for Employee name
                    if (svNameList.isEmpty)
                      Expanded(
                        flex: 0,
                        child: SearchBoxWidget(
                          labelText: 'Carian',
                          searchedName: getSearchName,
                        ),
                      ),

                    //list of selected sv name
                    if (selectedSVName.isNotEmpty)
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            const Divider(
                              thickness: 1,
                              color: Color(0xffE5E5E5),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 35,
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedSVName.clear();
                                        svIdList.clear();
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
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    height: 30,
                                    padding: const EdgeInsets.only(left: 8),
                                    child: ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          width: 8,
                                        );
                                      },
                                      itemCount: selectedSVName.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {},
                                          child: _showSelectedSvName(
                                              selectedSVName[index]),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(
                      height: 16,
                    ),
                    //Employee List
                    // Expanded(
                    //   flex: 5,
                    //   child: ListOfEmployees(
                    //     type: "Senarai Hadir",
                    //     idStatus: 1, // Hadir
                    //     searchedName: searchName,
                    //     assignedEmployee: widget.assignedEmployee,
                    //     idSv: svIdList,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showListOfSupervisor() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.of(context).pop();
          },
          child: DraggableScrollableSheet(
            initialChildSize: 0.6,
            builder: (_, scrollController) => Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
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
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    "Pilih Penyelia",
                    style: TextStyle(
                      color: Color(0xff969696),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color(0xffE5E5E5),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    child: FutureBuilder<List>(
                        future: PenyeliaApi.getPenyeliaData(context),
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
                                allSVName = dataFuture!
                                    .map((data) => PenyeliaCheckBox(
                                        idPenyelia: data.id,
                                        namaPenyelia: data.name))
                                    .toList();

                                return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: allSVName.length,
                                    itemBuilder: (context, index) {
                                      return svCheckBoxList(allSVName[index]);
                                    });
                              }
                          }
                        }),
                  ),
                  Container(
                    width: Sizes().screenWidth(context),
                    margin: const EdgeInsets.all(10),
                    child: selectButton(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    return const SizedBox(
      width: 0,
      height: 0,
    );
  }

  Widget svCheckBoxList(PenyeliaCheckBox dataPenyelia) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(dataPenyelia.namaPenyelia),
          value: dataPenyelia.valueCheckbox,
          activeColor: const Color(0xff34A853),
          onChanged: (newValue) {
            setState(
              () => dataPenyelia.valueCheckbox = newValue!,
            );
          });
    });
  }

  Widget selectButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: const Color(0xff34A853),
          shadowColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusCircular),
          )),
      onPressed: () {
        setState(() {
          // use to show list of selected sv name under search box
          selectedSVName.clear();
          selectedSVName.addAll(
            allSVName.where((svName) => svName.valueCheckbox),
          );

          //use to pass into List of Employee page , to filtered list of employee based on selected sv only
          svIdList.clear();
          for (var id in selectedSVName) {
            svIdList.add(id.idPenyelia);
          }
        });

        Navigator.pop(context);
      },
      child: const Text(
        "Pilih",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _showSelectedSvName(svData) {
    return Container(
      // height: 30,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xffC0E4FF),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: [
          Text(
            "${svData.namaPenyelia}",
            style: const TextStyle(
              color: Color(0xff005B9E),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          InkWell(
            onTap: () {
              selectedSVName.removeWhere(
                  (name) => name.namaPenyelia == svData.namaPenyelia);
              svIdList.removeWhere((id) => id == svData.idPenyelia);

              setState(() {});
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
  }
}
