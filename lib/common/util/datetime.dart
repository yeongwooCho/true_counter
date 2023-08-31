String convertDateTimeToDate({required DateTime datetime}) {
  return '${datetime.year}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString().padLeft(2, '0')}';
}
