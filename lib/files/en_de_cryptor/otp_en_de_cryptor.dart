import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:encrypt/encrypt.dart';

class AesEnDeCryptor {
  String encryptedKey = "d2AQuZZDfTIlZeXW";
  String encryptedIV = "912QWA56CFB3SA3F";
  String deEncryptedKey = "112QWA56CFB3SA3G";
  String deEncryptedIV = "e2AQuZZDfTIlZeXX";

  String aesEnc(String text) {
    final key = encrypt.Key.fromUtf8(encryptedKey);
    final iv = encrypt.IV.fromUtf8(encryptedIV);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(text, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    print("Encrypted otp is ${encrypted.base64}");
    print("dencrypted otp is $decrypted");
    return encrypted.base64;
  }

  String decryptWithAES(String text) {
    print("Encrypted data : $text");
    String decrypted = '';
    try {
      final key = encrypt.Key.fromUtf8(deEncryptedKey);
      final iv = encrypt.IV.fromUtf8(deEncryptedIV);
      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: AESMode.cbc));
      decrypted = encrypter.decrypt(encrypt.Encrypted.fromBase64(text), iv: iv);
    } catch (e) {
      decrypted = '';
    }
    return decrypted;
  }
}
