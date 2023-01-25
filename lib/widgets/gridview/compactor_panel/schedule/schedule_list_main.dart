import 'package:eswm/widgets/gridview/compactor_panel/schedule/schedule_list_tile.dart';
import 'package:flutter/material.dart';

import '../../../../config/palette.dart';
import '../../../../models/schedule/compactor/list/schedule_list.dart';
import '../../../../providers/schedule/compactor_panel/compactor_schedule_api.dart';
import '../../../../utils/icon/custom_icon.dart';

class ScheduleListMain extends StatelessWidget {
  final Map<String, Object>? passData;

  const ScheduleListMain({Key? key, this.passData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ScheduleList>(
        future: CompactorScheduleApi.fetchCompactScheduleList(context, 1, passData),
        builder: (context, snapshots) {
          if (snapshots.hasError) {
            return const Center(
              child: Text("Some errors occurred!"),
            );
          }
          switch (snapshots.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshots.data!.data!.data == null) {
                return Center(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(CustomIcon.exclamation,
                            color: Colors.orange, size: 14),
                        const SizedBox(width: 10),
                        Text("Tiada rekod dijumpai",
                            style: TextStyle(color: grey500)),
                      ],
                    ),
                  ),
                );
              } else {
                return ScheduleListTile(
                    schedules: snapshots.data!, passData: passData);
              }

            default:
              return Container();
          }
        });
  }
}