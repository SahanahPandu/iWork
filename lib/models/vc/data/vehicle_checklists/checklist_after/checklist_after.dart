import '../vc_item/vc_item.dart';

class ChecklistAfter {
  ChecklistAfter({
    required this.vcItem,
  });

  VcItem vcItem;

  factory ChecklistAfter.fromJson(Map<String, dynamic> json) => ChecklistAfter(
        vcItem: VcItem.fromJson(json["vcItem"]),
      );

  Map<String, dynamic> toJson() => {
        "vcItem": vcItem.toJson(),
      };
}
