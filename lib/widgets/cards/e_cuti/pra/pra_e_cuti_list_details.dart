import 'package:flutter/material.dart';

class PraECutiListDetails extends StatefulWidget {
  const PraECutiListDetails({Key? key}) : super(key: key);

  @override
  State<PraECutiListDetails> createState() => _PraECutiListDetailsState();
}

class _PraECutiListDetailsState extends State<PraECutiListDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          //Jenis dan Status Cuti
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Cuti Kecemasan",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      "Diluluskan Tanpa Lampiran",
                      style: TextStyle(
                          color: Colors.orange.shade700,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),

          //Tarikh Mula/Tamat
          Padding(
            padding: const EdgeInsets.only(
              top: 22,
              bottom: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tarikh Mula / Tamat",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  "20/05/2022",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),

          //Lampiran
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Lampiran",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                "mc20220520.jpg",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
