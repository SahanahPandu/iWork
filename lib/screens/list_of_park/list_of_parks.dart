import 'package:eswm/providers/taman_api.dart';
import 'package:flutter/material.dart';

import '../../config/palette.dart';

class ListOfParks extends StatefulWidget {
  const ListOfParks({Key? key}) : super(key: key);

  @override
  State<ListOfParks> createState() => _ListOfParksState();
}

class _ListOfParksState extends State<ListOfParks> {
  final TextEditingController _namaTaman = TextEditingController();

  int totalTaman = 0;

  getTotalData() {
    final getList = TamanApi.getTamanData(context).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          totalTaman = value.length;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getTotalData();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showListOfParks();
      },
      child: Card(
        elevation: 5,
        shadowColor: Colors.grey.shade50,
        child: TextFormField(
          controller: _namaTaman,
          readOnly: true,
          enabled: false,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            hintText: 'Senarai Taman',
            hintStyle: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: const Icon(
              Icons.arrow_drop_down,
              size: 30,
              color: Colors.black87,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50),
              gapPadding: 6.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget? showListOfParks() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (builder) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                    left: 25,
                    bottom: 10,
                  ),
                  child: Text(
                    "${totalTaman.toString()} Senarai Taman",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                FutureBuilder<List>(
                  future: TamanApi.getTamanData(context),
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
                          return Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              padding: const EdgeInsets.all(6),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: dataFuture!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        _namaTaman.text =
                                            dataFuture[index].namaTaman;
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide.none,
                                          bottom: BorderSide(
                                            color: grey400,
                                            width: 0.9,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        dataFuture[index].namaTaman,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
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
                  },
                ),
              ],
            ),
          );
        });
    return null;
  }
}
