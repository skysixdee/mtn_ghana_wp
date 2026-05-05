
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  static final FlutterTts _tts = FlutterTts();

  static Future<void> initTTS({
    VoidCallback? onStart,
    VoidCallback? onComplete,
    VoidCallback? onCancel,
    VoidCallback? onError,
  }) async {
    _tts.setStartHandler(() {
      onStart?.call();
    });
    _tts.setCompletionHandler(() {
      onComplete?.call();
    });
    _tts.setCancelHandler(() {
      onCancel?.call();
    });
    _tts.setErrorHandler((_) {
      onError?.call();
    });

    await _tts.setLanguage("en-US");
    await _tts.setPitch(1.0);
    await _tts.setSpeechRate(0.8);
  }

  static Future<void> speak(String text) async {
    await _tts.stop();
    await _tts.speak(text);
  }
}





// import 'package:flutter_tts/flutter_tts.dart';
// class TTSService {
//   static final _tts = FlutterTts();

//   static void initTTS() {
//     _tts.setLanguage("en-IN");
//     _tts.setSpeechRate(0.9);
//   }

//   static void speak(String text) {
//     _tts.speak(text);
//   }
// }



