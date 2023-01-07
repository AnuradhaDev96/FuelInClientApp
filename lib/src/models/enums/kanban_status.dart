enum KanBanStatus {
  newTask,
  inProgress,
  onHold,
  completed
}

extension ToString on KanBanStatus {
  String toDisplayString() {
    switch (this) {
      case KanBanStatus.newTask:
        return "New";
      case KanBanStatus.inProgress:
        return "In Progress";
      case KanBanStatus.onHold:
        return "On Hold";
      case KanBanStatus.completed:
        return "Completed";
      default:
        return "New"; //ව්‍යාජ තනතුරක්
    }
  }
}

extension ToInteger on KanBanStatus {
  int toIntegerValue() {
    switch (this) {
      case KanBanStatus.newTask:
        return 0;
      case KanBanStatus.inProgress:
        return 1;
      case KanBanStatus.onHold:
        return 2;
      case KanBanStatus.completed:
        return 3;
      default:
        return 0;
    }
  }
}