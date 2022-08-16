import 'package:eswm/providers/workshop_vehicle_api.dart';
import 'package:eswm/screens/workshop_vehicle/workshop_vehicle_details.dart';
import 'package:flutter/material.dart';

import '../../config/palette.dart';
import '../../utils/custom_icon.dart';

class WorkshopVehicleMain extends StatefulWidget {
  const WorkshopVehicleMain({Key? key}) : super(key: key);

  @override
  State<WorkshopVehicleMain> createState() => _WorkshopVehicleMainState();
}

class _WorkshopVehicleMainState extends State<WorkshopVehicleMain> {
  late Future<List> _loadWorkshopVehicle;

  @override
  void initState() {
    _loadWorkshopVehicle = WorkshopVehicleApi.getWorkshopVehicleData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: appBarBgColor,
          elevation: 1,
          shadowColor: white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CustomIcon.arrowBack,
                color: Colors.grey.shade900, size: 15),
          ),
          title: Center(
            child: Text(
              "Bengkel/Penyelenggaraan",
              style: TextStyle(
                fontSize: 16,
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
                    "Senarai Kenderaan dalam penyelenggaraan :",
                    style: TextStyle(
                        color: grey500,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: FutureBuilder<List>(
                    future: _loadWorkshopVehicle,
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
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: white,
                                          border:
                                              Border.all(color: borderColor),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                    Colors.grey.withOpacity(.3),
                                                blurRadius: 8,
                                                spreadRadius: 0.5,
                                                offset: const Offset(0, 2))
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: WorkshopVehicleDetails(
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
            )));
  }
}