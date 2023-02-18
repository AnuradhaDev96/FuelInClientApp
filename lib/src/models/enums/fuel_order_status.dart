enum FuelOrderStatus {
  paymentDone,
  deliveryConfirmed
}

extension ToString on FuelOrderStatus {
  String toDisplayString() {
    switch (this) {
      case FuelOrderStatus.paymentDone:
        return "Payment Done";
      case FuelOrderStatus.deliveryConfirmed:
        return "Delivery Confirmed";
    }
  }
  String? toDTOString() {
    switch (this) {
      case FuelOrderStatus.paymentDone:
        return "PaymentDone";
      case FuelOrderStatus.deliveryConfirmed:
        return "DeliveryConfirmed";
      default: return null;
    }
  }
}