enum AdminScreenBuckets {
  overview,
  inventory,
  workMonitoring,
  membersManagement,
}

extension ToString on AdminScreenBuckets {
  String toDisplayString() {
    switch (this) {
      case AdminScreenBuckets.overview:
        return "m%fõYùug b,a,Sï";//ප්‍රවේශවීමට ඉල්ලීම්
      case AdminScreenBuckets.inventory:
        return ";k;=re l<uKdlrKh";//තනතුරු කළමණාකරණය
      case AdminScreenBuckets.membersManagement:
        return "iudðlhska l<uKdlrKh";//සමාජිකයින් කළමණාකරණය
      case AdminScreenBuckets.workMonitoring:
        return "mßmd,k tAll l<uKdlrKh";//පරිපාලන ඒකක කළමණාකරණය
    }
  }
}