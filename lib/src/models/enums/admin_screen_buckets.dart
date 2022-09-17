enum AdminScreenBuckets {
  systemAccessRequests,
  systemRoleManagement,
  membersManagement,
  administrativeUnitManagement,
}

extension ToString on AdminScreenBuckets {
  String toDisplayString() {
    switch (this) {
      case AdminScreenBuckets.systemAccessRequests:
        return "m%fõYùug b,a,Sï";//ප්‍රවේශවීමට ඉල්ලීම්
      case AdminScreenBuckets.systemRoleManagement:
        return ";k;=re l<uKdlrKh";//තනතුරු කළමණාකරණය
      case AdminScreenBuckets.membersManagement:
        return "iudðlhska l<uKdlrKh";//සමාජිකයින් කළමණාකරණය
      case AdminScreenBuckets.administrativeUnitManagement:
        return "mßmd,k tAll l<uKdlrKh";//පරිපාලන ඒකක කළමණාකරණය
    }
  }
}