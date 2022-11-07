import 'dart:convert';

import 'package:amond/data/entity/character_entity.dart';
import 'package:amond/data/entity/character_silhouette_images_entity.dart';
import 'package:amond/data/source/network/base_url.dart';
import 'package:amond/utils/auth/auth_info.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CharacterApi {
  Future<int> getExp() async {
    try {
      final url = Uri.parse('$baseUrl/v1/exp');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $globalToken',
      });
      if (response.statusCode >= 400) {
        throw Exception('경험치 불러오기에 실패했습니다.');
      }
      final res = jsonDecode(response.body)['exp'];
      return res;
    } catch (error) {
      rethrow;
    }
  }

  Future<int> changeExp(int exp) async {
    final url = Uri.parse('$baseUrl/v1/exp');

    final response = await http.put(
      url,
      body: jsonEncode({
        'exp': exp,
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $globalToken',
      },
    );
    final res = jsonDecode(response.body)['exp'];
    return res;
  }

  Future<String?> getName() async {
    final url = Uri.parse('$baseUrl/v1/nickname');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $globalToken',
    });
    final String? res = jsonDecode(utf8.decode(response.bodyBytes))["nickname"];
    return res;
  }

  Future<CharacterEntity> getCharacterInfo() async {
    final url = Uri.parse('$baseUrl/user/pet/info');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $globalToken',
    });
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    if (kDebugMode) {
      print('캐릭터 정보 응답: $json}');
    }
    return CharacterEntity.fromJson(json);
  }

  Future<void> setName(int petId, String name) async {
    final url = Uri.parse("$baseUrl/user/pet/nickname");

    await http.post(
      url,
      body: jsonEncode({
        "userPetId": petId,
        "nickname": name,
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $globalToken',
      },
    );
  }

  Future<CharacterEntity?> getPlayResult(int petId) async {
    final url = Uri.parse("$baseUrl/user/pet/play");

    final response = await http.post(
      url,
      body: jsonEncode({
        "userPetId": petId,
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $globalToken',
      },
    );

    Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
    if (kDebugMode) {
      print('캐릭터 놀아주기 결과: $json');
    }

    var resultPetInfo = json['petInfo'];
    if (resultPetInfo == null) {
      return null;
    }

    return CharacterEntity.fromJson(resultPetInfo);
  }

  Future<CharacterSilhouetteImagesEntity> getCharacterSilhouettes() async {
    final url = Uri.parse("$baseUrl/user/pet/silhouette");

    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $globalToken',
      },
    );
    final json = jsonDecode(response.body);
    final entity = CharacterSilhouetteImagesEntity.fromJson(json);

    return entity;
  }

  Future<int> feedCharacter() async {
     final url = Uri.parse("$baseUrl/user/pet/feed");

     final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $globalToken',
      },
    );


    final json = jsonDecode(response.body);
    return json['reward'];
  }

}
