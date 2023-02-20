// import 'package:eswm/models/penyelia_checkbox.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../providers/pekerja_api.dart';
import '../../widgets/cards/cards.dart';
import 'list_of_employee_details.dart';

class ListOfEmployees extends StatefulWidget {
  final String? type;
  final dynamic idPekerja;
  final List<dynamic>? idSv;
  final int? idStatus;
  final String? searchedName;
  final Function(dynamic)? assignedEmployee;
  final int? scMainId;

  const ListOfEmployees({
    Key? key,
    this.type,
    this.idPekerja,
    this.idSv,
    this.idStatus,
    this.searchedName,
    this.assignedEmployee,
    this.scMainId,
  }) : super(key: key);

  @override
  State<ListOfEmployees> createState() => _ListOfEmployeesState();
}

class _ListOfEmployeesState extends State<ListOfEmployees> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 3,
        ),
        Expanded(
          child: FutureBuilder<List>(
              future: PekerjaApi.getDataSenaraiPekerja({
                "scMainId": widget.scMainId,
                "svIdList": widget.idSv,
              }),
              builder: (context, snapshot) {
                var dataFuture = snapshot.data;
                //List<dynamic> newList = [];
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );

                  default:
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Some error occurred!"),
                      );
                    } else {
                      //checking if there is idPekerja is passed, else show all
                      if (widget.idPekerja != null) {
                        dataFuture!.removeWhere(
                            (item) => !widget.idPekerja.contains(item.id));
                      }

                      //checking if there is idSv is passed, else show all, list of selected sv
                      if (widget.idSv != null && widget.idSv!.isNotEmpty) {
                        dataFuture!.removeWhere(
                            (item) => !widget.idSv!.contains(item.idSv));
                      }

                      //checking attendance id status, Hadir/Tidak Hadir
                      // if (widget.idStatus != null) {
                      //   dataFuture!.removeWhere(
                      //       (item) => item.idAttStatus != widget.idStatus);
                      // }

                      //checking searching string , from searching box
                      if (widget.searchedName != null) {
                        // print("Searching name: ${widget.searchedName}");
                        dataFuture = dataFuture!
                            .where((item) => item.userDetail.name
                                .toLowerCase()
                                .contains(widget.searchedName!.toLowerCase()))
                            .toList();
                      }

                      return widget.type != null
                          ? ListView.separated(
                              // physics: const NeverScrollableScrollPhysics(),
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              separatorBuilder: (context, index) {
                                return Divider(
                                  thickness: 0.5,
                                  color: dividerColor,
                                );
                              },
                              itemCount: dataFuture!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 24),
                                  child: ListOfEmployeeDetails(
                                    type: widget.type,
                                    dataPekerja: dataFuture![index],
                                    assignedEmployee: widget.assignedEmployee,
                                  ),
                                );
                              },
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              // physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: dataFuture!.length,
                              itemBuilder: (context, index) {
                                return Cards(
                                  type: "Senarai Pekerja",
                                  data: dataFuture![index],
                                  assignedEmployee: widget.assignedEmployee,
                                );
                              });
                    }
                }
              }),
        ),
      ],
    );
  }
}
