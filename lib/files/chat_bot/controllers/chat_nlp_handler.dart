part of 'ai_agent_controller.dart';

mixin ChatNlpHandler {
  // ── Change this URL to your deployed server URL in production ──────────
  static final String _parseApiUrl =
      parseNlpUrl; //'http://127.0.0.1:8000/parse';

  /// Calls the unified /parse endpoint.
  ///
  /// Returns a map guaranteed to contain:
  ///   'intent'    : String   (e.g. "buy_tone", "kb_answer", "unknown")
  ///   'artist'    : String?
  ///   'category'  : String?
  ///   'relevant'  : bool
  ///   'kb_answer' : String?  (non-null only when intent == "kb_answer")
  Future<Map<String, dynamic>> extractNlp(String text) async {
    try {
      final response = await http
          .post(
            Uri.parse(_parseApiUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'text': text}),
          )
          .timeout(const Duration(seconds: 8)); // prevents hanging

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          print("🧠 NLP result: $decoded");
          return decoded;
        }
      }

      print("⚠️ NLP bad response: ${response.statusCode}");

      // Server responded but not properly → treat as server issue
      return {
        ..._fallback(),
        'intent': 'server_error',
      };
    } on TimeoutException {
      print("⏱️ NLP timeout");
      return {
        ..._fallback(),
        'intent': 'server_error',
      };
    } on SocketException {
      print("📡 No internet connection");
      return {
        ..._fallback(),
        'intent': 'no_internet',
      };
    } catch (e) {
      print("❌ NLP error: $e");
      return {
        ..._fallback(),
        'intent': 'server_error',
      };
    }
  }

  Map<String, dynamic> _fallback() {
    return {
      'intent': 'unknown',
      'artist': null,
      'category': null,
      'relevant': false,
      'kb_answer': null,
    };
  }
}
