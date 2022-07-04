import 'package:flutter/material.dart';

//import files
import 'package:eswm/config/palette.dart';
import 'package:eswm/utils/device.dart';

class LeaveForm extends StatefulWidget {
  const LeaveForm({Key? key}) : super(key: key);

  @override
  State<LeaveForm> createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  final _formKey = GlobalKey<FormState>();
  final Devices _device = Devices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: SizedBox(
          width: 20,
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              padding: const EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 5.0,
            ),
            child: const Text(
              "Hantar",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(7),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Text(
                  "Lengkapkan maklumat di bawah:",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              //Jenis Cuti
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  width: _device.screenWidth(context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey.shade400,
                      style: BorderStyle.solid,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Pilih Jenis Cuti',
                            hintStyle: TextStyle(
                              color: grey500,
                            ),
                            contentPadding: const EdgeInsets.all(8),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
              //Tarikh Mula & Tarikh Tamat
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    width: _device.screenWidth(context) * 0.45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.shade400,
                        style: BorderStyle.solid,
                        width: 1.5,
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Tarikh Mula',
                                hintStyle: TextStyle(
                                  color: grey500,
                                ),
                                contentPadding: const EdgeInsets.all(8),
                              ),
                            ),
                          ),
                          VerticalDivider(
                            color: grey500,
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                            width: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.date_range,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    width: _device.screenWidth(context) * 0.45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.shade400,
                        style: BorderStyle.solid,
                        width: 1.5,
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Tarikh Tamat',
                                hintStyle: TextStyle(
                                  color: grey500,
                                ),
                                contentPadding: const EdgeInsets.all(8),
                              ),
                            ),
                          ),
                          VerticalDivider(
                            color: grey500,
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                            width: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.date_range,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              //Lampiran
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 5),
                child: SizedBox(
                  width: _device.screenWidth(context),
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.cloud_upload),
                    label: const Text(
                      "Muat Naik Lampiran",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade800,
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 5.0,
                    ),
                  ),
                ),
              ),
              Text(
                "*Maksimum 500kb.Format fail .jpeg & .png sahaja",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: grey500,
                  fontStyle: FontStyle.italic,
                ),
              ),
              //Catatan
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  width: _device.screenWidth(context),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey.shade400,
                      style: BorderStyle.solid,
                      width: 1.5,
                    ),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Catatan',
                      hintStyle: TextStyle(
                        color: grey500,
                        fontWeight: FontWeight.w400,
                      ),
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
