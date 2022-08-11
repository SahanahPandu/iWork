// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../widgets/app_bar/app_bar_widget.dart';
import '../../widgets/search_box/search_box.dart';
import 'package:eswm/screens/list_of_employees/list_of_employees.dart';

class EmployeeList extends StatefulWidget {
  Function(dynamic)? assignedEmployee;
  EmployeeList({
    Key? key,
    this.assignedEmployee,
  }) : super(key: key);

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  String? searchName;

  void getSearchName(name) {
    setState(() {
      searchName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Pilih Pekerja",
        listOfWidget: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.filter_alt_rounded,
              color: grey800,
              size: 22,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBoxWidget(
                labelText: 'Cari Pekerja',
                searchedName: getSearchName,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Senarai Pekerja",
                  style: TextStyle(
                      color: grey500,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
              ListOfEmployees(
                idStatus: 1, // Hadir
                searchedName: searchName,
                assignedEmployee: widget.assignedEmployee,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
