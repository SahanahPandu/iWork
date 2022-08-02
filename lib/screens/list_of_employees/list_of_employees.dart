import 'package:eswm/widgets/cards/cards.dart';
import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';

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
        Container(
          margin: const EdgeInsets.only(
            left: 10,
          ),
          child: Text(
            "Senarai Pekerja",
            style: TextStyle(
              fontSize: userRole == 100 && userRole == 200 ? 17 : 16,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Cards(
          type: "Senarai Pekerja",
          data: null,
        ),
      ],
    );
  }
}
