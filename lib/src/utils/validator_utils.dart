bool isLKPhoneNumber(String value) {
  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
    return false;
  }
  return true;
}

/// Accepts both new and old nic numbers
///
/// XXXXXXXXXv (with 9 numbers) || XXXXXXXXXXXX (with 12 numbers)
bool isLKNicNumber(String value) {
  if (!RegExp(r'^([0-9]{9}[x|X|v|V]|[0-9]{12})$').hasMatch(value)) {
    return false;
  }
  return true;
}