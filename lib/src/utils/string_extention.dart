extension IsNumericExtention on String {
  bool get isInteger {
    return int.tryParse(this) != null;
  }

  bool get isDouble {
    return double.tryParse(this) != null;
  }
}