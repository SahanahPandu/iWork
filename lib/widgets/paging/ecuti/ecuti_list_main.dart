import 'package:flutter/material.dart';

//import files
import '../../../../config/palette.dart';
import '../../../../utils/icon/custom_icon.dart';
import '../../../models/ecuti/ecuti_paging.dart';
import '../../../providers/cuti_api.dart';
import 'ecuti_list_tile.dart';

class ECutiListMain extends StatelessWidget {
  final Map<String, Object?>? passData;

  const ECutiListMain({Key? key, this.passData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EcutiPaging>(
        future: CutiApi.fetchECutiList(context, 1, passData),
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
                    Text("Terdapat masalah sambungan Internet. Sila cuba lagi.",
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
              if (snapshots.data == null || snapshots.data!.data.isEmpty) {
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
                return ECutiListTile(
                    eCutis: snapshots.data!, passData: passData);
              }

            default:
              return Container();
          }
        });
  }
}
