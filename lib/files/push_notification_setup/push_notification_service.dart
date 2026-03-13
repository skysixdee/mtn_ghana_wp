import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

// Top-level background handler (required to be top-level)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Background message: ${message.messageId}');
}

class PushNotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    // Register background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request permissions (web shows browser prompt)
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    debugPrint('Permission status: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await _getAndPrintToken();
      _setupMessageHandlers();
    }
  }

  static Future<String?> _getAndPrintToken() async {
    // Replace with your actual VAPID key from Firebase Console
    const vapidKey =
        'BBYI-UFHWBx06L_cnhO9rO5ue_VDF6p-__XBdsHCxR-qkLBIDSBIUEZ2J4VtiDVenmKRLSHRpEY1KFSQTgMAs6c';

    final token = kIsWeb
        ? await _messaging.getToken(vapidKey: vapidKey)
        : await _messaging.getToken();

    debugPrint('FCM Token: $token');
    // TODO: Send this token to your backend server
    return token;
  }

  static void _setupMessageHandlers() {
    // App in FOREGROUND
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Foreground message: ${message.notification?.title}');
      // Show in-app notification/snackbar here
    });

    // App opened FROM a notification (background → foreground)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Opened from notification: ${message.data}');
      // Handle navigation based on message.data
    });
  }

  // Call on app start to check if launched from a notification
  static Future<RemoteMessage?> getInitialMessage() async {
    return await _messaging.getInitialMessage();
  }
}
