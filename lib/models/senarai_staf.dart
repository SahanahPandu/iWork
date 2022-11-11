class SenaraiStaf {
  final String staf1Img;
  final String staf2Img;
  final String staf3Img;

  SenaraiStaf(
      {required this.staf1Img, required this.staf2Img, required this.staf3Img});

  static SenaraiStaf fromJson(json) => SenaraiStaf(
        staf1Img: json["staf1Img"],
        staf2Img: json["staf2Img"],
        staf3Img: json["staf3Img"],
      );
}
