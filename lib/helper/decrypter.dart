import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/asymmetric/pkcs1.dart';
import 'package:pointycastle/asymmetric/rsa.dart';

class Decrypter {
  static decryptCode(String publicKey, String encryptedSymmetricKey, String iv, String encryptedData) {
    return _decryptData(_decryptSymmetricKey(publicKey, encryptedSymmetricKey), iv, encryptedData);
  }

  static List<int> _decryptSymmetricKey(String public, String encryptedSymmetricKey) {
    encrypt.RSAKeyParser parser = encrypt.RSAKeyParser();
    RSAPrivateKey publicKey = parser.parse(public) as RSAPrivateKey;
    var encr = encrypt.Encrypter(
      encrypt.RSA(
          privateKey: publicKey,
          encoding: encrypt.RSAEncoding.OAEP,
          digest: encrypt.RSADigest.SHA256),
    );

    var newKey = encr.decryptBytes(encrypt.Encrypted.fromBase64(encryptedSymmetricKey));
    print("newKey:::$newKey");

    return newKey;
  }

  static String _decryptData(List<int> symmetricKey, String ivKey, String encrypted) {
    final key = encrypt.Key.fromBase64(base64Encode(symmetricKey)); //32 chars
    final iv = encrypt.IV.fromBase64(ivKey);

    final e = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final decryptedData =
        e.decrypt(encrypt.Encrypted.fromBase64(encrypted), iv: iv);

    print("Data:::");
    print(decryptedData);
    return decryptedData;
  }
}
