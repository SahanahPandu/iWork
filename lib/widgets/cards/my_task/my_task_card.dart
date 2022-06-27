// ignore_for_file: file_names
import 'package:flutter/material.dart';

//import files
import 'package:eswm/widgets/cards/my_task/pra/pra_my_task_list_details.dart';
import '../../../utils/device.dart';
import 'compactor_panel/compactor_panel_my_task_list_details.dart';

class MyTaskCard extends StatefulWidget {
  const MyTaskCard({Key? key}) : super(key: key);

  @override
  State<MyTaskCard> createState() => _MyTaskCardState();
}

class _MyTaskCardState extends State<MyTaskCard> {

  final Devices _device = Devices();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: SizedBox(
        height: 180,
        child: Card(
          //Tugasan Card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadowColor: Colors.white,
          elevation: 14,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: _device.isPhone()
                ? const PraMyTaskListDetails()
                : const CompactorPanelMyTaskListDetails()
            ,
          ),
        ),
      ),
    );
  }
}
