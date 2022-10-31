String secondsToTimeLeft(int seconds) {
  int h, m, s;

  h = seconds ~/ 3600;
  m = ((seconds - h * 3600)) ~/ 60;
  s = seconds - (h * 3600) - (m * 60);

  String hourLeft = h < 10 ? "0$h" : h.toString();
  String minuteLeft = m < 10 ? "0$m" : m.toString();
  String secondsLeft = s < 10 ? "0$s" : s.toString();

  String result = "$hourLeft : $minuteLeft : $secondsLeft";

  return result;
}
