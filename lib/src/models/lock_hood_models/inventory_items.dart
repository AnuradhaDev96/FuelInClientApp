class InventoryItems {
  int? id, inventoryId;
  String? name;
  double? alertMargin;
  double? availableQuantity;

  InventoryItems({this.id, this.inventoryId, this.name, this.alertMargin, this.availableQuantity});

  InventoryItems.fromMap(Map<String, dynamic> map):
        id = map["id"],
        inventoryId = map["inventoryId"],
        name = map["name"],
        alertMargin = map["alertMargin"],
        availableQuantity = map["availableQuantity"];

  Map<String, dynamic> toMap(){
    return {
      'inventoryId': inventoryId,
      'name': name,
      'alertMargin': alertMargin,
      'availableQuantity': availableQuantity,
    };

  }
}