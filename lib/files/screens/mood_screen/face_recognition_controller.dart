import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/main.dart';

class FaceRecognitionController extends GetxController {
  var expression = 'Unknown'.obs;
  var isDetecting = false.obs;

  Timer? _timer;
  StreamSubscription? _captureListener;

  void startDetection() {
    isDetecting.value = true;
    js.context.callMethod('detectFace');

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      final expr = js.context['lastExpression'];
      if (expr != null && expr != expression.value) {
        expression.value = expr;
      }
    });

    _captureListener?.cancel();
    _captureListener = html.window.on['expressionCaptured'].listen((event) {
      isDetecting.value = false;
      _timer?.cancel();
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    _captureListener?.cancel();
    super.onClose();
  }
}
