import 'package:eswm/providers/vehicle_checklist_api.dart';
import 'package:eswm/screens/vehicle_checklist/vehicle_checklist_list/vehicle_checklist_list_details.dart';
import 'package:flutter/material.dart';

//import files
import '../../../config/palette.dart';
import '../../../utils/icon/custom_icon.dart';
import '../../../widgets/custom_scroll/custom_scroll.dart';

class VehicleChecklistListMain extends StatefulWidget {
  const VehicleChecklistListMain({Key? key}) : super(key: key);

  @override
  State<VehicleChecklistListMain> createState() =>
      _VehicleChecklistListMainState();
}

class _VehicleChecklistListMainState extends State<VehicleChecklistListMain> {
  late Future<List> _loadVcData;

  @override
  void initState() {
    _loadVcData = VehicleChecklistApi.getVehicleChecklistData(context);
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
              icon: Icon(CustomIcon.arrowBack, color: blackCustom, size: 22),
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
            actions: const [SizedBox(width: 50)],
          ),
        ),
      ),
      body: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(30, 35, 0, 0),
                  child: Text("Senarai Semakan Kenderaan :",
                      style: TextStyle(
                          color: blackCustom,
                          fontSize: 16,
                          fontWeight: FontWeight.w400))),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                child: FutureBuilder<List>(
                  future: _loadVcData,
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
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: shadowColor,
                                              offset: const Offset(0, 2),
                                              blurRadius: 10,
                                              spreadRadius: 0.5)
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 40, horizontal: 36),
                                        child: VehicleChecklistListDetails(
                                          vcData: dataFuture[index],
                                        ),
                                      )),
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
      ),
    );
  }
}
