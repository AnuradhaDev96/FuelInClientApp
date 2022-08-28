enum AdminScreenBuckets {
  employeeManagement,
  roomManagement,
  reservationManagement,
}

extension ToString on AdminScreenBuckets {
  String toDisplayString() {
    switch (this) {
      case AdminScreenBuckets.employeeManagement:
        return "Employee Management";
      case AdminScreenBuckets.roomManagement:
        return "Room Management";
      case AdminScreenBuckets.reservationManagement:
        return "Reservation Management";
    }
  }
}