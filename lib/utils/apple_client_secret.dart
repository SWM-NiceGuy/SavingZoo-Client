import 'package:amond/secrets/secret.dart';
import 'package:jose/jose.dart';

// DateTime only has a millisecondsSinceEpoch, but JWT needs secondsSinceEpoch.
// This is just a simple extension to add that capability to DateTime.
extension SecondsSinceEpoch on DateTime {
  int get secondsSinceEpoch {
    return millisecondsSinceEpoch ~/ 1000;
  }

  DateTime fromSecondsSinceEpoch(int seconds) {
    return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
  }
}

class Utils {
  static const keyId = appleKeyId;
  static const teamId = appleTeamId;
  static const clientId = 'com.amond.amondApp';
  static const audience = 'https://appleid.apple.com';
  static const algorithm = 'ES256';
  static const validDuration = 300;

  // Getting project folder using introspection instead of Platform.script
  // so that it works with unit testing as well
  // static String get projectFolder {
  //   final mirrorPath = reflectClass(Utils).owner as LibraryMirror;
  //   final utilsClassFolder = dirname(mirrorPath.uri.path);
  //   return Directory.fromUri(Uri.parse(utilsClassFolder)).absolute.parent.path;
  // }

  // static String get pemKey {
  //   final keyFile = join(
  //     'secrets',
  //     'amond-ios-key',
  //     'AuthKey.pem',
  //   );
  // final path = Uri.parse('.').resolveUri(Uri.file(keyFile)).toFilePath();
  // return File(path).readAsStringSync();
  // }

  static String appleClientSecret() {
    final jwk = JsonWebKey.fromPem(appleAuthPemKey, keyId: keyId);

    final claims = JsonWebTokenClaims.fromJson({
      'iss': teamId,
      'iat': DateTime.now().secondsSinceEpoch,
      'exp': DateTime.now().secondsSinceEpoch + validDuration,
      'aud': audience,
      'sub': clientId,
    });

    final builder = JsonWebSignatureBuilder()
      ..jsonContent = claims.toJson()
      ..addRecipient(jwk, algorithm: algorithm);

    return builder.build().toCompactSerialization();
  }
}
