/// Formats an integer (in seconds) to 24-hour format.
///
/// Example: `formatToMilitaryTime(920) == "15:20"`.
///
/// Pads with zeroes if necessary, i.e. `formatToMilitaryTime(540) == "09:00"`.
/// TODO(matuella): Improve naming.
String formatToMilitaryTime(Duration duration) {
  // Pads left with one zero if necessary, i.e. `twoDigits(2) == "02"`.
  String twoDigits(int value) => value.toString().padLeft(2, '0');

  if (duration.inHours > 0) {
    final hours = twoDigits(duration.inHours.remainder(60));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  } else if (duration.inMinutes > 0) {
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  } else {
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '00:$seconds';
  }
}
