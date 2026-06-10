@JS()
library face_api;

import 'package:js/js.dart';

@JS('faceapi.nets.tinyFaceDetector.loadFromUri')
external dynamic loadTinyFaceDetector(String uri);

@JS('faceapi.nets.faceExpressionNet.loadFromUri')
external dynamic loadFaceExpressionNet(String uri);
