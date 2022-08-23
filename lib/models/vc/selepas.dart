import 'items/vc_item.dart';

class Selepas {
  Selepas({
    required this.vcItem,
  });

  VcItem vcItem;

  static Selepas fromJson(json) => Selepas(
        vcItem: VcItem.fromJson(json["vcItem"]),
      );

  Map<String, dynamic> toJson() => {
        "vcItem": vcItem.toJson(),
      };
}
