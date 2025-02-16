import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:password_manager/features/passwords/data/datasources/remote_data_source.dart';
import 'package:password_manager/features/passwords/domain/entities/password_entity.dart';
import 'package:random_string_generator/random_string_generator.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final FlutterSecureStorage storage;

  final StreamController<List<PasswordEntity>> streamController =
      StreamController<List<PasswordEntity>>.broadcast();

  RemoteDataSourceImpl({required this.storage});

  final RandomStringGenerator generator =
      RandomStringGenerator(fixedLength: 12);

  List<PasswordEntity> jsonToEntity(List<String> jsonList) {
    return jsonList
        .map(
          (e) => PasswordEntity.fromJson(e),
        )
        .toList();
  }

  List<String> entityToJson(List<PasswordEntity> jsonList) {
    return jsonList
        .map(
          (e) => e.toJson(),
        )
        .toList();
  }

  Future<void> updatePasswordStream() async {
    String? jsonString = await storage.read(key: 'passList');

    List<String> jsonPassList =
        jsonString != null ? jsonDecode(jsonString).cast<String>() : [];

    List<PasswordEntity> passList = jsonToEntity(jsonPassList);
    streamController.add(passList);
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

    String? jsonString = await storage.read(key: 'passList');

    List<String> jsonPassList =
        jsonString != null ? jsonDecode(jsonString).cast<String>() : [];

    final List<PasswordEntity> passList = jsonToEntity(jsonPassList);
    passList.add(passwordEntity);

    storage.write(key: 'passList', value: jsonEncode(entityToJson(passList)));
    updatePasswordStream();
  }

  @override
  Future<void> deletePassword(String id) async {
    final String? jsonString = await storage.read(key: 'passList');
    List<String> jsonPassList =
        jsonString != null ? jsonDecode(jsonString).cast<String>() : [];

    final List<PasswordEntity> passList = jsonToEntity(jsonPassList);

    passList.removeWhere((e) => e.passwordIdentifier == id);
    storage.write(key: "passList", value: jsonEncode(entityToJson(passList)));
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
