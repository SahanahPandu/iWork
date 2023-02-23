import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//import files
import '../../../config/palette.dart';
import '../../../models/vc/confirmation/vc_verification_list.dart';
import '../../../providers/vehicle_checklist/verification/vehicle_checklist_verification_api.dart';
import '../../../utils/calendar/date.dart';
import '../../../utils/icon/custom_icon.dart';
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
  @override
  void initState() {
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
              child: FutureBuilder<List<ChecklistList>?>(
                future: VehicleChecklistVerificationApi
                    .getVehicleChecklistVerificationList(
                        context,
                        Date.getTheDate(
                            DateTime.now(), '', "yyyy-MM-dd", 'ms')),
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
                            child: Text("Some errors occurred!"));
                      } else {
                        if (snapshot.hasData) {
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
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            child: VehicleChecklistApprovalTab(
                                                vcData: dataFuture[index])));
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 10),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            color: white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: cardShadowColor,
                                                  offset: const Offset(0, 2),
                                                  blurRadius: 10,
                                                  spreadRadius: 0.5)
                                            ],
                                          ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              child:
                                                  VehicleChecklistApprovalDetails(
                                                data: dataFuture[index],
                                                isDrawer: false,
                                              )))),
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
                        } else {
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
                        }
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

  //------------------------------------------------------
  // Build card details for report lists.
  //------------------------------------------------------
  SizedBox buildTabletCard(redirect) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: white,
              boxShadow: [
                BoxShadow(
                    color: cardListShadowColor.withOpacity(0.06),
                    offset: const Offset(0, 2),
                    blurRadius: 12,
                    spreadRadius: 0.5)
              ]),
          child: Padding(padding: const EdgeInsets.all(10), child: redirect),
        ),
      ),
    );
  }
}
