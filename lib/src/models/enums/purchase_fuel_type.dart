enum PurchaseFuelType {
  petrol95,
  petrol92,
  autoDiesel,
  superDiesel
}

extension ToString on PurchaseFuelType {
  String toDisplayString() {
    switch (this) {
      case PurchaseFuelType.petrol95:
        return "Petrol 95";
      case PurchaseFuelType.petrol92:
        return "Petrol 92";
      case PurchaseFuelType.autoDiesel:
        return "Auto Diesel";
      case PurchaseFuelType.superDiesel:
        return "Super Diesel";
    }
  }

  String? toDTOString() {
    switch (this) {
      case PurchaseFuelType.petrol95:
        return "Petrol95";
      case PurchaseFuelType.petrol92:
        return "Petrol92";
      case PurchaseFuelType.autoDiesel:
        return "AutoDiesel";
      case PurchaseFuelType.superDiesel:
        return "SuperDiesel";
      default: return null;
    }
  }
}