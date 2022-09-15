enum AccessRequestStatus {
  /// Default value. When anonymous user requests this is set as default
  pendingApproval,

  /// After a user's email is registered in auth the status is approved.
  /// Still the user may have to approve verification
  approved,

  /// Access request is set to declined
  declined
}

extension ToString on AccessRequestStatus {
  String toDbValue() {
    switch (this) {
      case AccessRequestStatus.pendingApproval:
        return "Pending";
      case AccessRequestStatus.approved:
        return "Approved";
      case AccessRequestStatus.declined:
        return "Declined";
      default:
        return "Pending";
    }
  }

}