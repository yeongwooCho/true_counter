import 'package:intl/intl.dart';

final NumberFormat numberFormat = NumberFormat('###,###,###,###');
// print(numberFormat.format(1000000);
// # ==> 1,000,000

String convertIntToMoneyString({
  required int number,
}) {
  return numberFormat.format(number);
}
