extension DurationExtension on Duration {
  // String get formatMS => "${inMinutes.toString().padLeft(2, "0")}:${inSeconds.toString().padLeft(2, "0")}";
  // String get formatMS => "${inMinutes.remainder(60).toString().padLeft(2, "0")}:${inSeconds.remainder(60).toString().padLeft(2, "0")}";

  String formatHMS({
    String separator = "",
    int padLeft = 2,
    ({
      String hour,
      String minute,
      String second
    }) suffixes = (hour: "", minute: "", second: ""),
  }) {
    final int second = inSeconds.remainder(60);
    final int minute = inMinutes.remainder(60);
    final int hour = inHours;

    // final int hour = inHours.remainder(24);
    // final int day = inDays.remainder(60);

    if (hour > 0) {
      return "${hour.toString().padLeft(padLeft, "0")}${suffixes.hour}$separator${minute.toString().padLeft(padLeft, "0")}${suffixes.minute}$separator${second.toString().padLeft(padLeft, "0")}${suffixes.second}";
    } else {
      if (minute > 0) {
        return "${minute.toString().padLeft(padLeft, "0")}${suffixes.minute}$separator${second.toString().padLeft(padLeft, "0")}${suffixes.second}";
      } else {
        return "${second.toString().padLeft(padLeft, "0")}${suffixes.second}";
      }
    }
  }

  String get formatUnderHourSingleMax {
    if ((inHours > 0) || (this == Duration.zero)) {
      return "$inHours h";
    } else if (inMinutes > 0) {
      return "$inMinutes m";
    } else {
      return "$inSeconds s";
    }
  }
}

extension NumExtension on num {
  num clamp2({
    num min = 0,
    num? max,
  }) =>
      clamp(min, max ?? double.infinity);
}
