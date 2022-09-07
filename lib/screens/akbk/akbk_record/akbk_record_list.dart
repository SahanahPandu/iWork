import 'package:flutter/material.dart';

//import files
import '../../../config/palette.dart';
import '../../../providers/akbk_api.dart';
import 'akbk_record_list_details.dart';

class AkbkRecordList extends StatefulWidget {
  const AkbkRecordList({Key? key}) : super(key: key);

  @override
  State<AkbkRecordList> createState() => _AkbkRecordListState();
}

class _AkbkRecordListState extends State<AkbkRecordList> {
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
                  style: TextStyle(
                      color: blackCustom,
                      fontSize: 15,
                      fontWeight: FontWeight.w400))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: AkbkRecordListDetails(
                                          data: dataFuture[index],
                                        ),
                                      )),
                                ));
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
