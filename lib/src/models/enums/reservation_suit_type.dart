enum ReservationSuitType {
  weekly,
  monthly,
}

extension ToString on ReservationSuitType {
  String toDisplayString() {
    switch (this) {
      case ReservationSuitType.weekly:
        return "Weekly Subscription";
      case ReservationSuitType.monthly:
        return "Monthly Subscription";
    }
  }
}