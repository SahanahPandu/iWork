class SenaraiStaf {
  final String staf_1_img;
  final String staf_2_img;
  final String staf_3_img;

  SenaraiStaf(
      {required this.staf_1_img, required this.staf_2_img, required this.staf_3_img});

  static SenaraiStaf fromJson(json) => SenaraiStaf(
        staf_1_img: json["staf_1_img"],
        staf_2_img: json["staf_2_img"],
        staf_3_img: json["staf_3_img"],
      );
}
