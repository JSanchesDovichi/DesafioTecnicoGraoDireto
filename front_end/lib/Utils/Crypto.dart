import 'dart:convert';
import 'package:crypto/crypto.dart';

class Crypto {
  Codec<String, String> stringToBase64Url = utf8.fuse(base64Url);

  static String sha512encode(String base) {
    var bytes = utf8.encode(base);
    String digest = sha512.convert(bytes).toString();

    return digest.toUpperCase();
  }

  static String sha256encode(String base) {
    var bytes = utf8.encode(base);
    String digest = sha256.convert(bytes).toString();

    return digest.toUpperCase();
  }
}
