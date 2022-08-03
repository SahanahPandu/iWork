import 'package:eswm/widgets/cards/cards.dart';
import 'package:flutter/material.dart';

//import files

class ListOfEmployees extends StatefulWidget {
  const ListOfEmployees({Key? key}) : super(key: key);

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
        Cards(
          type: "Senarai Pekerja",
          data: null,
        ),
      ],
    );
  }
}
