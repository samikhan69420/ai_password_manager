import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:password_manager/features/ai/data/datasources/ai_remote_data_source.dart';
import 'package:password_manager/features/ai/domain/entities/user_entity.dart';
import 'package:password_manager/features/app/const/classes_functions/string_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AiRemoteDataSourceImpl implements AiRemoteDataSource {
  final SharedPreferences preferences;

  AiRemoteDataSourceImpl({required this.preferences});

  @override
  UserEntity getProfile() {
    final jsonUserProfile = preferences.getString(StringConst.userProfile);
    final UserEntity userEntity =
        UserEntity.fromJson(jsonDecode(jsonUserProfile!));
    return userEntity;
  }

  @override
  void setProfile(UserEntity userEntity) {
    final String encodedProfile = jsonEncode(userEntity.toJson());
    preferences.setString(StringConst.userProfile, encodedProfile);
  }

  @override
  void updateProfile(UserEntity newProfile) {
    preferences.remove(StringConst.userProfile);
    final String encodedProfile = jsonEncode(newProfile.toJson());
    preferences.setString(StringConst.userProfile, encodedProfile);
  }

  @override
  Future<String> getAiPassword(String prompt) async {
    // Building the request

    final groqApiKey = dotenv.env['GROQ_API_KEY'];
    final request = Request(
      'POST',
      Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
    );
    request.body = jsonEncode({
      "messages": [
        {
          "role": "system",
          "content": '''
            You are an AI model used within a password manager application. Your role is crucial, as every response you generate impacts user security and usability. Follow these instructions carefully and exactly as given:
            Purpose: Generate a secure yet memorable password that is personalized to the user.
            Input Fields Provided:
            User’s first name and last name
            User’s date of birth
            A brief description of the user
            A numeric value (0–10) where 0 indicates the most secure (complex) and 10 indicates the easiest to remember
            Desired password length
            Additional parameter about the password (THIS FIELD CAN BE EMPTY),
            Password Creation Rules:
            Only include information provided in the input fields. Do not add any additional elements or make assumptions.
            Ensure that the password is unique and relevant to the user based on their specific details.
            Response: Only reply with the generated password—no additional text or explanations.
            Your responses should be concise, correct, and strictly limited to the generated password text only.
          '''
        },
        {"role": "user", "content": prompt}
      ],
      "model": "gemma2-9b-it"
    });
    request.headers.addAll({
      'Authorization': 'Bearer $groqApiKey',
      'Content-Type': 'application/json',
      'Cookie':
          '__cf_bm=rIY4GrPfGQsB5cvFWUVn6WV9RfrNrZ6GG077GiLTl6E-1730800281-1.0.1.1-9FXxyP9B2kRlgsa9aWmuAyICtarTJ.OyKu8ddCsfo3W97BqKm5k1VzrgnHUYpfoxJUgVFaYYZ1ZEbky2dPiKfA'
    });

    // Sending the request
    String responseString = '';
    final streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      final response = await streamedResponse.stream.bytesToString();
      final decodedResponse = jsonDecode(response);

      if (decodedResponse is Map && decodedResponse['choices'] is List) {
        final choicesList = decodedResponse['choices'] as List;

        if (choicesList.isNotEmpty && choicesList.first is Map) {
          final message = choicesList.first['message'];

          if (message is Map) {
            responseString = message['content'];
          }
        }
      }
    } else {
      debugPrint('Error: ${streamedResponse.statusCode}');
      throw Exception(streamedResponse.reasonPhrase);
    }
    if (responseString.isEmpty) {
      throw Exception(streamedResponse.reasonPhrase);
    } else {
      return responseString;
    }
  }
}
