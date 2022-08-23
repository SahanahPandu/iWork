import 'package:flutter/material.dart';

import '../../../config/palette.dart';
import '../../../providers/vehicle_checklist_api.dart';
import '../../../utils/custom_icon.dart';
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
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: barShadowColor,
              offset: const Offset(0, 3),
              blurRadius: 8,
            )
          ]),
          child: AppBar(
            backgroundColor: white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(CustomIcon.arrowBack,
                  color: blackCustom, size: 22),
            ),
            title: Center(
              child: Text(
                "Semakan Kenderaan",
                style: TextStyle(
                  fontSize: 15,
                  color: blackCustom,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  CustomIcon.filter,
                  color: blackCustom,
                  size: 13,
                ),
              ),
            ],
          ),
        ),
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
                    color: blackCustom,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
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
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: white,
                                      border: Border.all(color: borderColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(.3),
                                            blurRadius: 3,
                                            spreadRadius: 0.5,
                                            offset: const Offset(0, 2))
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: VehicleChecklistApprovalDetails(
                                        data: dataFuture[index],
                                      ),
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
