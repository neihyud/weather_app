String getTypeCode(String code, int dt) {
  if (code.isNotEmpty) {
    code = code.substring(0, code.length - 1);
  }

  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000);

  int hour = dateTime.hour;
  
  if (hour < 5 || hour > 18) {
    return '${code}n';
  }

  return '${code}d';
}
