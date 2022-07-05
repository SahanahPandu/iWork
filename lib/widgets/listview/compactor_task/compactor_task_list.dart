import 'package:flutter/material.dart';

import '../../cards/my_task/compactor_task_card.dart';

class CompactorTaskList extends StatefulWidget {
  final dynamic topCardStatus;

  const CompactorTaskList({Key? key, this.topCardStatus}) : super(key: key);

  @override
  State<CompactorTaskList> createState() => _CompactorTaskListState();
}

class _CompactorTaskListState extends State<CompactorTaskList> {
  ScrollController controller = ScrollController();

  List<String> tabletItems = ['Tab Laluan 1'];

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
            margin: const EdgeInsets.all(10),
            child: ListView.builder(
                controller: controller,
                shrinkWrap: true,
                itemCount: tabletItems.length,
                itemBuilder: (context, index) {
                  return const CompactorTaskCard();
                })));
  }
}
