String convertDateTimeToDateString({
  required DateTime datetime,
}) {
  return '${datetime.year}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString().padLeft(2, '0')}';
}

String convertDateTimeToHour({
  required DateTime datetime,
}) {
  return '${datetime.year}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString().padLeft(2, '0')} ${datetime.hour.toString().padLeft(2, '0')}';
}

String convertDateTimeToMinute({
  required DateTime datetime,
}) {
  return '${datetime.year}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString().padLeft(2, '0')} ${datetime.hour.toString().padLeft(2, '0')}:${datetime.minute.toString().padLeft(2, '0')}';
}
