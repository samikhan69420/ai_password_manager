import 'package:password_manager/features/app/const/classes_functions/string_const.dart';
import 'package:password_manager/features/passwords/domain/entities/password_entity.dart';

List<int> checkEmpty(final PasswordEntity password) {
  List<int> list = [];
  if (password.username != null && password.username!.isNotEmpty) {
    list.add(0);
  }
  if (password.creditCardInfo![StringConst.cardNumber]!.isNotEmpty) {
    list.add(1);
  }
  if (password.otherFields != null &&
      password.otherFields![StringConst.addressLine1]!.isNotEmpty) {
    list.add(2);
  }
  return list;
}
