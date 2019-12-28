class LogStamp {
  String _s;

  LogStamp() {
    _s = "[" +
        DateTime.now().second.toString() +
        "." +
        DateTime.now().microsecond.toString() +
        "] ";
    return;
  }

  String stamp() {
    return _s;
  }
}
