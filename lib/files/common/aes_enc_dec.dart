import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:encrypt/encrypt.dart';

String _encryptedKey = 'mofSSBh+ys/nwHn8EBmXgg==';

String _encryptedIV = '';
String aesEncryption(String text) {
  final key = encrypt.Key.fromBase64(_encryptedKey);
  final iv = encrypt.IV.fromBase64(_encryptedIV);

  final encrypter =
      encrypt.Encrypter(encrypt.AES(key, mode: AESMode.ecb, padding: "PKCS7"));
  final encrypted = encrypter.encrypt(text, iv: iv);

  final decrypted = encrypter.decrypt(encrypted, iv: iv);
  print("encrypted text in base 64 is ======= \n$text");
  print("\nEncrypted value is \n${encrypted.base64}\n");
  print("\ndencrypted value is \n$decrypted\n");
  return encrypted.base64;
}

String aesDecryption(String text) {
  final key = encrypt.Key.fromBase64(_encryptedKey);
  final iv = encrypt.IV.fromBase64(_encryptedIV);
  final encrypter =
      encrypt.Encrypter(encrypt.AES(key, mode: AESMode.ecb, padding: "PKCS7"));
  final decrypted =
      encrypter.decrypt(encrypt.Encrypted.fromBase64(text), iv: iv);
  print("Decrypted text in base 64 is  \n$decrypted");
  return decrypted;
}
