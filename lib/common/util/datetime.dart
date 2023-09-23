String convertDateTimeToDateString({
  required DateTime datetime,
}) {
  return '${datetime.year}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString().padLeft(2, '0')}';
}

String convertDateTimeToDateTimeString({
  required DateTime datetime,
}) {
  return '${datetime.year}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString().padLeft(2, '0')} ${datetime.hour.toString().padLeft(2, '0')}시';
}
