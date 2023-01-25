import 'package:eswm/models/vc/list/data/vc_data/vc_list_detail.dart';
import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import 'vehicle_checklist_list_details.dart';

class VehicleChecklistListTileDetail extends StatelessWidget {
  const VehicleChecklistListTileDetail({Key? key, required this.vcDetail})
      : super(key: key);
  final VCListDetail vcDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
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
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 36),
            child: VehicleChecklistListDetails(
              vcData: vcDetail,
            ),
          )),
    ); // Card
  }

  Padding buildTabletCard(redirect) {
    return Padding(
        padding: const EdgeInsets.all(10),
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
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: redirect)));
  }
}
