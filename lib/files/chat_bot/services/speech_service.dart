import 'dart:js_interop';

@JS('initSpeechRecognition')
external bool initSpeechRecognition();

@JS('startSpeechRecognition')
external void startSpeechRecognition(
  JSFunction onResult,
  JSFunction onStopped,
  JSFunction onStarted,
  JSFunction onLevel,
);

@JS('stopSpeechRecognition')
external void stopSpeechRecognition();

class SpeechService {
  static Future<bool> initSpeech() async {
    return initSpeechRecognition();
  }

  static Future<void> startListening(
    Function(String) onFinalText,
    Function(String) onStopped,
    Function(String) onStarted,
    Function(double) onLevel,
  ) async {
    startSpeechRecognition(
      ((JSString result) {
        onFinalText(result.toDart);
      }).toJS,
      ((JSString status) {
        onStopped(status.toDart);
      }).toJS,
      ((JSString start) {
        onStarted(start.toDart);
      }).toJS,
      ((JSAny? level) {
        if (level == null) {
          onLevel(0.0);
          return;
        }
        final dartLevel = (level as JSNumber).toDartDouble;
        onLevel(dartLevel.isNaN || dartLevel.isInfinite
            ? 0.0
            : dartLevel.clamp(0.0, 1.0));
      }).toJS,
    );
  }

  static Future<void> stopListening() async {
    stopSpeechRecognition();
  }
}



//===========code before adding web speech api=================
// import 'package:speech_to_text/speech_to_text.dart' as stt;

// class SpeechService {
//   static final stt.SpeechToText _speech = stt.SpeechToText();
//   static bool _isInitialized = false;

//   static Future<void> initSpeech() async {
//     if (!_isInitialized) {
//       await _speech.initialize();
//       _isInitialized = true;
//     }
//   }

//   static Future<void> startListening(Function(String) onResult) async {
//     await _speech.listen(
//       onResult: (result) {
//         if (result.recognizedWords.isNotEmpty) {
//           onResult(result.recognizedWords);
//         }
//       },
//     );
//   }

//   static Future<String> stopListening() async {
//     await _speech.stop();
//     return _speech.lastRecognizedWords;
//   }
// }




// import 'package:speech_to_text/speech_to_text.dart' as stt;

// class SpeechService {
//   static final stt.SpeechToText _speech = stt.SpeechToText();
//   static bool _isInitialized = false;
//   static bool _isListening = false;
//   static String _lastRecognized = "";

//   static Future<void> initSpeech() async {
//     _isInitialized = await _speech.initialize(
//       onStatus: (status) {
//         print("Speech status: $status");
//         if (status == "notListening") _isListening = false;
//         if (status == "listening") _isListening = true;
//       },
//       onError: (error) {
//         print("Speech error: $error");
//         _isListening = false;
//       },
//     );
//     print("Speech initialized: $_isInitialized");
//   }

//   static Future<void> startListening(Function(String) onResult) async {
//     if (!_isInitialized) {
//       print("Speech not initialized!");
//       return;
//     }

//     if (!_speech.isAvailable) {
//       print("Speech recognition not available!");
//       return;
//     }

//     if (_isListening) {
//       print("⚠️ Already listening, skip startListening()");
//       return;
//     }

//     _isListening = true;

//     await _speech.listen(
//       onResult: (result) {
//         _lastRecognized = result.recognizedWords;
//         print("Speech heard: $_lastRecognized");
//         onResult(_lastRecognized);
//       },
//       listenMode: stt.ListenMode.confirmation,
//       partialResults: true,
//     );
//   }

//   static Future<String> stopListening() async {
//     if (_isListening) {
//       await _speech.stop();
//       _isListening = false;
//     }
//     print("Final recognized words: $_lastRecognized");
//     return _lastRecognized;
//   }
// }



// import 'package:speech_to_text/speech_to_text.dart' as stt;

// class SpeechService {
//   static final stt.SpeechToText _speech = stt.SpeechToText();
//   static bool _isInitialized = false;

//   static Future<void> initSpeech() async {
//     _isInitialized = await _speech.initialize(
//       onStatus: (status) => print("Speech status: $status"),
//       onError: (error) => print("Speech error: $error"),
//     );
//     print("Speech initialized: $_isInitialized");
//   }

//   static Future<void> startListening(Function(String) onResult) async {
//     if (!_isInitialized) {
//       print("Speech not initialized!");
//       return;
//     }

//     if (!_speech.isAvailable) {
//       print("Speech recognition not available!");
//       return;
//     }

//     // await _speech.listen(
//     //   onResult: (result) {
//     //     print("Speech heard: ${result.recognizedWords}");
//     //     onResult(result.recognizedWords);
//     //   },
//     //   listenMode: stt.ListenMode.confirmation, // Better for Web
//     //   partialResults: true, // Show intermediate text
//     // );

//     await _speech.listen(
//       onResult: (result) {
//         String raw = result.recognizedWords;
//         // Normalize: remove spaces & non-digits if it's a number
//         String normalized = raw.replaceAll(RegExp(r'\D'), '');
//         print("Speech heard (raw): $raw");
//         print("Speech normalized: $normalized");

//         onResult(normalized.isNotEmpty ? normalized : raw);
//       },
//       listenMode: stt.ListenMode.confirmation,
//       partialResults: true,
//     );
//   }

//   static Future<String> stopListening() async {
//     await _speech.stop();
//     print("Final recognized words: ${_speech.lastRecognizedWords}");
//     return _speech.lastRecognizedWords;
//   }
// }
