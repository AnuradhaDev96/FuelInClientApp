bool isLKPhoneNumber(String value) {
  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
    return false;
  }
  return true;
}