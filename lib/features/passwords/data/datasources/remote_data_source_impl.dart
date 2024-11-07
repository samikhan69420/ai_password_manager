import 'dart:async';
import 'dart:convert';

import 'package:password_manager/features/passwords/data/datasources/remote_data_source.dart';
import 'package:password_manager/features/passwords/domain/entities/password_entity.dart';
import 'package:random_string_generator/random_string_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final SharedPreferences sharedPreferences;

  final StreamController<List<PasswordEntity>> streamController =
      StreamController<List<PasswordEntity>>.broadcast();

  RemoteDataSourceImpl({required this.sharedPreferences});

  final RandomStringGenerator generator =
      RandomStringGenerator(fixedLength: 12);

  void updatePasswordStream() {
    List<String> passList = sharedPreferences.getStringList('passList') ?? [];

    List<PasswordEntity> passwordEntityList = passList
        .map(
          (e) => PasswordEntity.fromJson(e),
        )
        .toList();

    streamController.add(passwordEntityList);
  }

  @override
  Stream<List<PasswordEntity>> getPasswords(String? passwordIdentifier) {
    Future.delayed(Duration.zero, () => updatePasswordStream());
    final stream = streamController.stream;
    return stream;
  }

  @override
  void createPassword(PasswordEntity uiPasswordEntity) async {
    final PasswordEntity passwordEntity = PasswordEntity(
      passwordIdentifier:
          uiPasswordEntity.passwordIdentifier ?? generator.generate(),
      title: uiPasswordEntity.title,
      username: uiPasswordEntity.username,
      password: uiPasswordEntity.password,
      creditCardInfo: uiPasswordEntity.creditCardInfo,
      otherFields: uiPasswordEntity.otherFields,
    );
    final List<String> passList =
        sharedPreferences.getStringList('passList') ?? [];

    passList.add(passwordEntity.toJson());

    sharedPreferences.setStringList('passList', passList);
    updatePasswordStream();
  }

  @override
  void deletePassword(String id) {
    final List<String> passList =
        sharedPreferences.getStringList('passList') ?? [];
    passList.removeWhere(
        (element) => jsonDecode(element)['passwordIdentifier'] == id);
    sharedPreferences.setStringList('passList', passList);
    updatePasswordStream();
  }

  @override
  void updatePassword(PasswordEntity passwordEntity) {
    final String id = passwordEntity.passwordIdentifier!;

    final PasswordEntity newPass = PasswordEntity(
      passwordIdentifier: id,
      creditCardInfo: passwordEntity.creditCardInfo,
      otherFields: passwordEntity.otherFields,
      password: passwordEntity.password,
      title: passwordEntity.title,
      username: passwordEntity.username,
    );
    deletePassword(id);
    createPassword(newPass);
    updatePasswordStream();
  }
}
