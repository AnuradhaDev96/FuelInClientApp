enum ScreenBuckets {
  home,
  booking,
  accommodation,

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
    }
  }
}