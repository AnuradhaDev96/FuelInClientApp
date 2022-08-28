enum BranchNames {
  unawatuna,
  negombo,
  bentota
}

extension ToString on BranchNames {
  String toDisplayString() {
    switch (this) {
      case BranchNames.unawatuna:
        return "Unawatuna";
      case BranchNames.negombo:
        return "Negombo";
      case BranchNames.bentota:
        return "Bentota";
    }
  }
}