import 'package:eswm/widgets/slivers/expand_collapse_header/expand_collapse_header.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../utils/device/sizes.dart';
import '../../widgets/app_bar/app_bar_widget.dart';
// import '../../widgets/search_box/search_box.dart';
import '../../widgets/search_box/search_box.dart';
import '../list_of_employees/absent_employee_details.dart';
// import '../list_of_employees/list_of_employee_details.dart';
// import '../list_of_employees/list_of_employees.dart';
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
          title: "Pilih Pekerja",
          listOfWidget: [
            IconButton(
              onPressed: () {
                showListOfSupervisor(context, getSearchSVName);
              },
              icon: Icon(
                Icons.filter_alt_rounded,
                color: grey800,
                size: 22,
              ),
            ),
          ],
        ),
        body: ScrollConfiguration(
          behavior: const MaterialScrollBehavior().copyWith(
            overscroll: false,
          ),
          child: ExpandCollapseHeader(
            centerTitle: false,
            title: AbsentEmployeeDetails(
              data: widget.absentEmployee!,
            ),
            headerExpandedHeight: 0.3, // size to display the header
            headerWidget: _header(context),
            fullyStretchable: true,
            body: [
              _scrollBody(),
            ],
            curvedBodyRadius:
                24, // radius for container body part (white background)
            collapseFade: 10,
            backgroundColor: transparent,
            appBarColor: collapseBgColor,
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Center(
          child: AbsentEmployeeDetails(
            data: widget.absentEmployee,
          ),
        ),
      ),
    );
  }

  SafeArea _scrollBody() {
    return SafeArea(
      child: Container(
        color: white,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Search Box for Employee name
              if (svNameList.isEmpty)
                SearchBoxWidget(
                  labelText: 'Cari Pekerja',
                  searchedName: getSearchName,
                ),
              if (svNameList.isEmpty)
                const SizedBox(
                  height: 20,
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
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  "Senarai Pekerja",
                  style: TextStyle(
                    color: Color(0xff8A92A6),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(
                height: 8,
              ),
              //Employee List
              ListOfEmployees(
                idStatus: 1, // Hadir
                searchedName: searchName,
                assignedEmployee: widget.assignedEmployee,
                idSv: svIdList,
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