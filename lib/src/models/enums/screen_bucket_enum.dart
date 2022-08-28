enum ScreenBuckets {
  home,
  booking,
  accommodation,
  services,
  galleryPage,
  dining,
  reservationHistory
}

extension ToString on ScreenBuckets {
  String toDisplayString() {
    switch (this) {
      case ScreenBuckets.home:
        return "Home";
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
    }
  }
}