import 'package:eswm/providers/vehicle_checklist_api.dart';
import 'package:flutter/material.dart';

import '../../../config/palette.dart';
import '../../../utils/custom_icon.dart';
import '../../../widgets/tabs/vehicle_checklist_tab/vehicle_checklist_approval_tab/vehicle_checklist_approval_tab.dart';
import 'vehicle_checklist_approval_details.dart';

class VehicleChecklistApprovalMain extends StatefulWidget {
  const VehicleChecklistApprovalMain({Key? key}) : super(key: key);

  @override
  State<VehicleChecklistApprovalMain> createState() =>
      _VehicleChecklistApprovalMainState();
}

class _VehicleChecklistApprovalMainState
    extends State<VehicleChecklistApprovalMain> {
  late Future<List> _loadVehicleChecklistData;

  @override
  void initState() {
    _loadVehicleChecklistData =
        VehicleChecklistApi.getVehicleChecklistData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBgColor,
        elevation: 1,
        shadowColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:
              Icon(CustomIcon.arrowBack, color: Colors.grey.shade900, size: 18),
        ),
        title: Center(
          child: Text(
            "Semakan Kenderaan",
            style: TextStyle(
              fontSize: 15,
              color: grey800,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: const [
          SizedBox(
            width: 50,
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 10),
              child: Text(
                "Senarai Semakan Kenderaan :",
                style: TextStyle(
                    color: grey500, fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: FutureBuilder<List>(
                future: _loadVehicleChecklistData,
                builder: (context, snapshot) {
                  final dataFuture = snapshot.data;

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    default:
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Some errors occurred!"),
                        );
                      } else {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: dataFuture!.length,
                          itemBuilder: (context, index) {
                            if (dataFuture.isNotEmpty) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return VehicleChecklistApprovalTab(
                                        data: dataFuture[index],
                                      );
                                    }),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  shadowColor: grey400,
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: VehicleChecklistApprovalDetails(
                                      data: dataFuture[index],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    "Tiada rekod dijumpai",
                                    style: TextStyle(
                                        color: grey500,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ));
                            }
                            return Container();
                          },
                        );
                      }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
