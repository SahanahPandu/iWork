import 'package:flutter/material.dart';

import '../../../../config/palette.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../config/config.dart';
import '../../../models/vc/list/data/vc_data.dart';
import '../../../providers/vehicle_checklist/vehicle_checklist_api.dart';
import 'vehicle_checklist_list_tile.dart';

class VehicleChecklistList extends StatelessWidget {
  final Map<String, Object>? passData;

  const VehicleChecklistList({Key? key, this.passData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    refreshVcList.value = !refreshVcList.value;
    return ValueListenableBuilder(
        valueListenable: refreshVcList,
        builder: (BuildContext context, value, Widget? child) {
          if (value == refreshVcList.value) {
            return FutureBuilder<VCData>(
                future: VehicleChecklistApi.fetchVehicleChecklistList(
                    context, 1, passData),
                builder: (context, snapshots) {
                  if (snapshots.hasError) {
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(CustomIcon.exclamation,
                                color: Colors.redAccent, size: 14),
                            const SizedBox(width: 10),
                            Text(
                                "Terdapat masalah sambungan Internet. Sila cuba lagi.",
                                style: TextStyle(color: grey500)),
                          ],
                        ),
                      ),
                    );
                  }
                  switch (snapshots.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.done:
                      if (snapshots.data == null ||
                          snapshots.data!.data!.isEmpty) {
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
                        return VehicleChecklistListTile(
                            vcList: snapshots.data!, passData: passData);
                      }

                    default:
                      return Container();
                  }
                });
          }
          return Container();
        });
  }
}
