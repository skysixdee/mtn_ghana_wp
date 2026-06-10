// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'dart:convert';
import 'dart:typed_data';

class MoodService {
  static bool _modelsLoaded = false;

  static Future<void> loadModels() async {
    if (_modelsLoaded) return;

    // Step 1: Wait for face-api.js to be available in window
    int scriptWait = 0;
    while (js.context['faceapi'] == null) {
      await Future.delayed(const Duration(milliseconds: 300));
      scriptWait++;
      if (scriptWait > 50) {
        throw Exception(
          'face-api.js not found. Check the script tag in web/index.html',
        );
      }
    }

    // Step 2: Trigger model loading via JS
    js.context.callMethod('eval', [
      """
      window._modelsLoaded = false;
      window._modelsError = null;

      const baseEl = document.querySelector('base');
      const base = baseEl ? baseEl.href : (window.location.origin + '/');
      const modelPath = base + 'models';

      console.log('Loading models from: ' + modelPath);

      Promise.all([
        faceapi.nets.tinyFaceDetector.loadFromUri(modelPath),
        faceapi.nets.faceExpressionNet.loadFromUri(modelPath)
      ])
      .then(() => {
        window._modelsLoaded = true;
        console.log('face-api models ready at: ' + modelPath);
      })
      .catch((err) => {
        window._modelsError = err.toString();
        console.error('Model load error:', err);
      });
    """
    ]);

    // Step 3: Poll until loaded or error
    int timeout = 0;
    while (true) {
      await Future.delayed(const Duration(milliseconds: 300));
      timeout++;

      final error = js.context['_modelsError'];
      if (error != null) {
        throw Exception(
          '$error — make sure web/models/ folder has all 4 files',
        );
      }

      if (js.context['_modelsLoaded'] == true) break;

      if (timeout > 100) {
        throw Exception(
          'Models timed out. Check web/models/ folder has:\n'
          '- tiny_face_detector_model-weights_manifest.json\n'
          '- tiny_face_detector_model-shard1\n'
          '- face_expression_model-weights_manifest.json\n'
          '- face_expression_model-shard1',
        );
      }
    }

    // Step 4: Verify isLoaded flag
    final ready = js.context.callMethod('eval', [
      """
      faceapi.nets.tinyFaceDetector.isLoaded &&
      faceapi.nets.faceExpressionNet.isLoaded
    """
    ]);

    if (ready != true) {
      throw Exception(
        'Models not ready after loading. Re-download model files.',
      );
    }

    _modelsLoaded = true;
  }

  static Future<Map<String, dynamic>> detectMood(Uint8List imageBytes) async {
    if (!_modelsLoaded) {
      return {'mood': 'models not loaded', 'scores': {}};
    }

    // Create blob URL
    final blob = html.Blob([imageBytes], 'image/jpeg');
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Inject hidden img
    final img = html.ImageElement()
      ..src = url
      ..id = 'face_detect_img'
      ..style.display = 'none';
    html.document.body!.append(img);

    await img.onLoad.first;

    // Run detection
    js.context.callMethod('eval', [
      """
      window._faceResult = null;
      window._faceDetecting = true;
      window._faceError = null;
      (async () => {
        try {
          const img = document.getElementById('face_detect_img');
          const detection = await faceapi
            .detectSingleFace(img, new faceapi.TinyFaceDetectorOptions())
            .withFaceExpressions();
          window._faceResult = detection
            ? JSON.stringify(detection.expressions)
            : 'none';
        } catch(e) {
          window._faceError = e.toString();
          console.error('Detection error:', e);
        } finally {
          window._faceDetecting = false;
        }
      })();
    """
    ]);

    // Poll until done
    int timeout = 0;
    while (js.context['_faceDetecting'] == true) {
      await Future.delayed(const Duration(milliseconds: 100));
      timeout++;
      if (timeout > 100) {
        img.remove();
        html.Url.revokeObjectUrl(url);
        return {'mood': 'detection timeout', 'scores': {}};
      }
    }

    // Cleanup
    img.remove();
    html.Url.revokeObjectUrl(url);

    final jsError = js.context['_faceError'];
    if (jsError != null) {
      return {'mood': 'error: $jsError', 'scores': {}};
    }

    final result = js.context['_faceResult']?.toString();
    if (result == null || result == 'none') {
      return {'mood': 'no face found', 'scores': {}};
    }

    final Map<String, dynamic> scores = jsonDecode(result);
    final topMood = scores.entries
        .reduce((a, b) => (a.value as double) > (b.value as double) ? a : b)
        .key;

    return {'mood': topMood, 'scores': scores};
  }
}
