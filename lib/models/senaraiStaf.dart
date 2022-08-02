class SenaraiStaf {
  final String staf_1;
  final String staf_2;
  final String staf_3;

  SenaraiStaf(
      {required this.staf_1, required this.staf_2, required this.staf_3});

  static SenaraiStaf fromJson(json) => SenaraiStaf(
        staf_1: json["staf_1"],
        staf_2: json["staf_2"],
        staf_3: json["staf_3"],
      );
}
