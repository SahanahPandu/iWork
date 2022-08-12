import 'package:eswm/providers/akbk_api.dart';
import 'package:eswm/screens/akbk/akbk_list_record_details.dart';
import 'package:flutter/material.dart';

import '../../config/palette.dart';

class AkbkListRecord extends StatefulWidget {
  const AkbkListRecord({Key? key}) : super(key: key);

  @override
  State<AkbkListRecord> createState() => _AkbkListRecordState();
}

class _AkbkListRecordState extends State<AkbkListRecord> {
  late Future<List> _loadAkbkData;

  @override
  void initState() {
    _loadAkbkData = AkbkApi.getAkbkData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text("Senarai Laporan AKBK",
                  style:
                      TextStyle(color: grey500, fontWeight: FontWeight.w700))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: FutureBuilder<List>(
              future: _loadAkbkData,
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
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                shadowColor: grey400,
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: AkbkListRecordDetails(
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
    );
  }
}
