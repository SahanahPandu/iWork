import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../utils/device/sizes.dart';
import '../../widgets/app_bar/app_bar_widget.dart';
import '../../widgets/search_box/search_box.dart';
import '../list_of_employees/absent_employee_details.dart';
import '../list_of_employees/list_of_employees.dart';
import '../list_of_supervisor/list_of_supervisor.dart';

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
  Color collapseBgColor = const Color(0xff2b7fe8);

  void getSearchName(name) {
    setState(() {
      searchName = name;
    });
  }

  void getSearchSVName(svData) {
    setState(() {
      svNameList.add(svData);
      svIdList.add(svData.id);
    });
  }

  @override
  void dispose() {
    super.dispose();
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
          title: "Pilih Pekerja",
          listOfWidget: [
            IconButton(
              onPressed: () {
                showListOfSupervisor(context, getSearchSVName);
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
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Search Box for Employee name
                    if (svNameList.isEmpty)
                      Expanded(
                        child: SearchBoxWidget(
                          labelText: 'Carian',
                          searchedName: getSearchName,
                        ),
                      ),

                    //Selected Sv Names
                    if (svNameList.isNotEmpty)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 25,
                        padding: const EdgeInsets.only(left: 8),
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 8,
                            );
                          },
                          itemCount: svNameList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                if (svNameList.isNotEmpty) {
                                  setState(() {
                                    svNameList.remove(svNameList[index]);
                                    svIdList.remove(svIdList[index]);
                                  });
                                }
                              },
                              child: _showSelectedSvName(svNameList[index]),
                            );
                          },
                        ),
                      ),
                    if (svNameList.isNotEmpty)
                      const SizedBox(
                        height: 10,
                      ),

                    const SizedBox(
                      height: 24,
                    ),
                    //Employee List
                    ListOfEmployees(
                      type: "Senarai Hadir",
                      idStatus: 1, // Hadir
                      searchedName: searchName,
                      assignedEmployee: widget.assignedEmployee,
                      idSv: svIdList,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showSelectedSvName(svData) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xffC0E4FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            "Penyelia ${svData.name}",
            style: const TextStyle(
              color: Color(0xff005B9E),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          const Icon(
            Icons.close,
            color: Color(0xff005B9E),
            size: 12,
          ),
        ],
      ),
    );
  }
}
