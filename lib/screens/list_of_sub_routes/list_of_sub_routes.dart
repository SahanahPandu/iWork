import 'package:flutter/material.dart';

//import files
import '../../config/config.dart';
import '../../config/palette.dart';
import '../../providers/sub_laluan_api.dart';
import '../../utils/device/orientations.dart';
import '../../utils/device/sizes.dart';

Future<dynamic> showListOfSubRoutes(context) {
  return showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    constraints: userRole == 100
        ? (Orientations().isLandscape(context)
            ? const BoxConstraints(maxWidth: 500, maxHeight: 400)
            : const BoxConstraints(maxWidth: 500, maxHeight: 450))
        : null,
    context: context,
    builder: (builder) {
      return SizedBox(
        height: userRole == 100 ? null : Sizes().screenHeight(context) * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 2,
            ),
            const Divider(
              thickness: 1,
              color: Color(0xff969696),
              indent: 170,
              endIndent: 170,
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 24,
                left: 24,
                bottom: 16,
              ),
              child: Text(
                //"${totalSubLaluan.toString()} Senarai Sub Laluan",
                "Pilih Sub-Laluan",
                style: TextStyle(
                  color: Color(0xff969696),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              color: Color(0xffE5E5E5),
              indent: 25,
              endIndent: 25,
            ),
            FutureBuilder<List>(
              future: SubLaluanApi.getSubLaluanData(context),
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
                        child: Text("Some error occured!"),
                      );
                    } else {
                      if (dataFuture!.isEmpty) {
                        return Center(
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            child: const Text("Tiada data"),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: dataFuture.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pop(context,
                                        dataFuture[index].namaSubLaluan);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    child: Text(
                                      dataFuture[index].namaSubLaluan,
                                      style: TextStyle(
                                        color: blackCustom,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }
                    }
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
