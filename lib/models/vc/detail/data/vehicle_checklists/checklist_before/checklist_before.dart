import '../vc_item/vc_item.dart';

class ChecklistBefore {
  ChecklistBefore({
    required this.vcItem,
  });

  VcItem vcItem;

  factory ChecklistBefore.fromJson(Map<String, dynamic> json) =>
      ChecklistBefore(
        vcItem: VcItem.fromJson(json["vcItem"]),
      );

  Map<String, dynamic> toJson() => {
        "vcItem": vcItem.toJson(),
      };
}
