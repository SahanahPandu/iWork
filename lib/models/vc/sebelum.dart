import 'items/vc_item.dart';

class Sebelum {
  Sebelum({
    required this.vcItem,
  });

  VcItem vcItem;

  static Sebelum fromJson(json) => Sebelum(
        vcItem: VcItem.fromJson(json["vcItem"]),
      );

  Map<String, dynamic> toJson() => {
        "vcItem": vcItem.toJson(),
      };
}
