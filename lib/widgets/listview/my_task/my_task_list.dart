import 'package:flutter/material.dart';

//import files
import 'package:eswm/widgets/cards/my_task/my_task_card.dart';

class MyTaskList extends StatefulWidget {
  final dynamic topCardStatus;
  const MyTaskList({
    Key? key,
    this.topCardStatus,
  }) : super(key: key);

  @override
  State<MyTaskList> createState() => _MyTaskListState();
}

class _MyTaskListState extends State<MyTaskList> {
  ScrollController controller = ScrollController();

  List<String> items = [
    'Laluan 1',
    'Laluan 2',
    'Laluan 3',
    'Laluan 4',
    'Laluan 5'
  ];

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      widget.topCardStatus(controller.offset > 50);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(12),
        child: ListView.builder(
            controller: controller,
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return const MyTaskCard();
            }),
      ),
    );
  }
}
