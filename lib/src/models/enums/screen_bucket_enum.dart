enum ScreenBuckets {
  myFuelOrders,
  booking,
  accommodation,
  services,
  galleryPage,
  dining,
  reservationHistory,
  reservationSuits,
}

extension ToString on ScreenBuckets {
  String toDisplayString() {
    switch (this) {
      case ScreenBuckets.myFuelOrders:
        return "iudðlhska l<uKdlrKh";//සමාජිකයින් කළමණාකරණය
      case ScreenBuckets.booking:
        return "Book Now";
      case ScreenBuckets.accommodation:
        return "Accommodations";
      case ScreenBuckets.services:
        return "Services";
      case ScreenBuckets.galleryPage:
        return "Gallery";
      case ScreenBuckets.dining:
        return "Dining";
      case ScreenBuckets.reservationHistory:
        return "Booking History";
      case ScreenBuckets.reservationSuits:
        return "Reservation Suits";
    }
  }
}
