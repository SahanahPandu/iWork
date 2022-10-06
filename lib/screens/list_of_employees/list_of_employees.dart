import 'package:flutter/material.dart';

//import files
import '../../config/palette.dart';
import '../../providers/pekerja_api.dart';
import '../../widgets/cards/cards.dart';
import 'list_of_employee_details.dart';

class ListOfEmployees extends StatefulWidget {
  final String? type;
  final dynamic idPekerja;
  final dynamic idSv;
  final int? idStatus;
  final String? searchedName;
  final Function(dynamic)? assignedEmployee;

  const ListOfEmployees({
    Key? key,
    this.type,
    this.idPekerja,
    this.idSv,
    this.idStatus,
    this.searchedName,
    this.assignedEmployee,
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
              future: PekerjaApi.getPekerjaData(context),
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

                      //checking if there is idSv is passed, else show all
                      if (widget.idSv != null && widget.idSv.isNotEmpty) {
                        dataFuture!.removeWhere(
                            (item) => !widget.idSv.contains(item.idSv));
                      }

                      //checking attendance id status
                      if (widget.idStatus != null) {
                        dataFuture!.removeWhere(
                            (item) => item.idAttStatus != widget.idStatus);
                      }

                      //checking searching string
                      if (widget.searchedName != null) {
                        dataFuture = dataFuture!
                            .where((item) => item.name
                                .toLowerCase()
                                .contains(widget.searchedName!.toLowerCase()))
                            .toList();
                      }

                      return widget.type != null
                          ? ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
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
                                    data: dataFuture![index],
                                    assignedEmployee: widget.assignedEmployee,
                                  ),
                                );
                              },
                            )
                          : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
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
