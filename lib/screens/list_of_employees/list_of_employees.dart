// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

//import files
import 'package:eswm/providers/pekerja_api.dart';
import 'package:eswm/widgets/cards/cards.dart';

class ListOfEmployees extends StatefulWidget {
  dynamic idPekerja;
  dynamic idSv;
  int? idStatus;
  String? searchedName;
  Function(dynamic)? assignedEmployee;

  ListOfEmployees({
    Key? key,
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
        FutureBuilder<List>(
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

                    return ListView.builder(
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
      ],
    );
  }
}
