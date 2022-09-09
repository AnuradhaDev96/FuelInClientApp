class ReservationSuit {
  String hotelName;
  String? customerName;
  String? customerEmail;
  String? reservationSuitType;
  double? totalCost;

  ReservationSuit({
    required this.hotelName,
    this.customerName,
    this.customerEmail,
    this.reservationSuitType,
    this.totalCost,
  });

  Map<String, dynamic> toMap(){
    return {
      'hotelName': hotelName,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'reservationSuitType': reservationSuitType,
      'totalCost': totalCost,
    };
  }
}