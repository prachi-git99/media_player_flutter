String formatDuration(int? duration) {
  if (duration == null) return "00:00";
  Duration d = Duration(milliseconds: duration);
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String minutes = twoDigits(d.inMinutes.remainder(60));
  String seconds = twoDigits(d.inSeconds.remainder(60));
  return "$minutes:$seconds";
}
