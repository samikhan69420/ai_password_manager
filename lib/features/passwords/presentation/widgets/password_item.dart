import 'package:password_manager/features/passwords/domain/entities/password_entity.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PasswordItem extends StatelessWidget {
  final PasswordEntity passwordEntity;
  const PasswordItem({
    super.key,
    required this.passwordEntity,
  });

  String getPasswordTitle() {
    if (passwordEntity.username == null || passwordEntity.username!.isEmpty) {
      return 'Credit Card';
    } else if (passwordEntity.creditCardInfo == null ||
        passwordEntity.creditCardInfo!.isEmpty) {}
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Basic(
        title: Text(passwordEntity.username!),
        subtitle: Row(
          children: [
            passwordEntity.username!.isEmpty
                ? Container()
                : const Text("Credit Card"),
            passwordEntity.creditCardInfo!.isEmpty
                ? Container()
                : const Text("Credit Card"),
            passwordEntity.creditCardInfo!.isEmpty
                ? Container()
                : const Text("Credit Card"),
          ],
        ),
      ),
    );
  }
}
