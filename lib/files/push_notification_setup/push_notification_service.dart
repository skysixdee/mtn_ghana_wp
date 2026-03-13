import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'dart:js' as js;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('🔔 [BGHandler] Background message received');
  debugPrint('🔔 [BGHandler] Message ID: ${message.messageId}');
  debugPrint('🔔 [BGHandler] Title: ${message.notification?.title}');
  debugPrint('🔔 [BGHandler] Body: ${message.notification?.body}');
  debugPrint('🔔 [BGHandler] Data: ${message.data}');
  debugPrint('🔔 [BGHandler] Sent time: ${message.sentTime}');
}

class PushNotificationService {
  static const _vapidKey =
      'BBYI-UFHWBx06L_cnhO9rO5ue_VDF6p-__XBdsHCxR-qkLBIDSBIUEZ2J4VtiDVenmKRLSHRpEY1KFSQTgMAs6c';

  // ─────────────────────────────────────────
  // INITIALIZE
  // ─────────────────────────────────────────
  static Future<void> initialize() async {
    debugPrint('🚀 [PushService] initialize() called');

    try {
      debugPrint('📋 [PushService] Registering background message handler...');
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      debugPrint('✅ [PushService] Background handler registered');

      debugPrint('🙏 [PushService] Requesting notification permission...');
      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      debugPrint(
          '📊 [PushService] Permission result: ${settings.authorizationStatus}');
      debugPrint('📊 [PushService] Alert: ${settings.alert}');
      debugPrint('📊 [PushService] Badge: ${settings.badge}');
      debugPrint('📊 [PushService] Sound: ${settings.sound}');

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint(
            '✅ [PushService] Permission GRANTED — proceeding with token fetch & handlers');
        await _getToken();
        _setupHandlers();
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        debugPrint(
            '⚠️ [PushService] Permission PROVISIONAL — limited notifications allowed');
        await _getToken();
        _setupHandlers();
      } else {
        debugPrint(
            '❌ [PushService] Permission DENIED — notifications will not work');
        debugPrint('❌ [PushService] Status: ${settings.authorizationStatus}');
      }
    } catch (e, stack) {
      debugPrint('💥 [PushService] initialize() threw an error: $e');
      debugPrint('💥 [PushService] StackTrace: $stack');
    }

    debugPrint('🏁 [PushService] initialize() completed');
  }

  // ─────────────────────────────────────────
  // GET TOKEN
  // ─────────────────────────────────────────
  static Future<String?> _getToken() async {
    debugPrint('🔑 [PushService] _getToken() called');
    debugPrint('🔑 [PushService] Platform is web: $kIsWeb');

    try {
      if (kIsWeb) {
        debugPrint('🔑 [PushService] Using VAPID key for web token...');
        debugPrint(
            '🔑 [PushService] VAPID key (first 10 chars): ${_vapidKey.substring(0, 10)}...');
      }

      final token = kIsWeb
          ? await FirebaseMessaging.instance.getToken(vapidKey: _vapidKey)
          : await FirebaseMessaging.instance.getToken();

      if (token != null) {
        debugPrint('✅ [PushService] FCM Token obtained successfully');
        debugPrint(
            '✅ [PushService] Token (first 20 chars): ${token.substring(0, 20)}...');
        debugPrint('✅ [PushService] Full Token: $token');
        // TODO: Send token to your backend here
        debugPrint('📤 [PushService] TODO: Send token to backend');
      } else {
        debugPrint(
            '❌ [PushService] Token is NULL — check VAPID key and Firebase config');
      }

      return token;
    } catch (e, stack) {
      debugPrint('💥 [PushService] _getToken() threw an error: $e');
      debugPrint('💥 [PushService] StackTrace: $stack');
      return null;
    }
  }

  // ─────────────────────────────────────────
  // SETUP HANDLERS
  // ─────────────────────────────────────────
  static void _setupHandlers() {
    debugPrint(
        '🎧 [PushService] _setupHandlers() called — attaching listeners');

    // FOREGROUND
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        debugPrint('📱 [PushService] FOREGROUND message received');
        debugPrint('📱 [PushService] Message ID: ${message.messageId}');
        debugPrint('📱 [PushService] Title: ${message.notification?.title}');
        debugPrint('📱 [PushService] Body: ${message.notification?.body}');
        debugPrint('📱 [PushService] Data: ${message.data}');
        debugPrint('📱 [PushService] Sent time: ${message.sentTime}');
        debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        _showInAppBanner(message);
      },
      onError: (e) {
        debugPrint('💥 [PushService] onMessage stream error: $e');
      },
    );
    debugPrint('✅ [PushService] onMessage listener attached');

    // BACKGROUND → APP OPENED
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        debugPrint('👆 [PushService] App OPENED from notification tap');
        debugPrint('👆 [PushService] Message ID: ${message.messageId}');
        debugPrint('👆 [PushService] Title: ${message.notification?.title}');
        debugPrint('👆 [PushService] Body: ${message.notification?.body}');
        debugPrint('👆 [PushService] Data payload: ${message.data}');
        debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        _handleNavigation(message.data);
      },
      onError: (e) {
        debugPrint('💥 [PushService] onMessageOpenedApp stream error: $e');
      },
    );
    debugPrint('✅ [PushService] onMessageOpenedApp listener attached');

    debugPrint(
        '🏁 [PushService] _setupHandlers() completed — all listeners active');
  }

  // ─────────────────────────────────────────
  // SHOW IN-APP BANNER
  // ─────────────────────────────────────────
  static void _showInAppBanner(RemoteMessage message) {
    debugPrint('🖼️ [PushService] _showInAppBanner() called');
    debugPrint('🖼️ [PushService] Title: ${message.notification?.title}');
    debugPrint('🖼️ [PushService] Body: ${message.notification?.body}');

    if (kIsWeb) {
      debugPrint(
          '🌐 [PushService] Web platform — calling JS showNotification()');
      _showBrowserNotification(
        message.notification?.title ?? '',
        message.notification?.body ?? '',
      );
    } else {
      debugPrint(
          '📲 [PushService] Mobile platform — show snackbar/dialog here');
      // TODO: Show Flutter snackbar or overlay
    }
  }

  // ─────────────────────────────────────────
  // SHOW BROWSER NOTIFICATION (JS interop)
  // ─────────────────────────────────────────
  static void _showBrowserNotification(String title, String body) {
    debugPrint('🌐 [PushService] _showBrowserNotification() called');
    debugPrint('🌐 [PushService] Title: $title');
    debugPrint('🌐 [PushService] Body: $body');

    try {
      debugPrint('🌐 [PushService] Calling JS showNotification()...');
      js.context.callMethod('showNotification', [title, body]);
      debugPrint('✅ [PushService] JS showNotification() called successfully');
    } catch (e, stack) {
      debugPrint('💥 [PushService] JS interop failed: $e');
      debugPrint(
          '💥 [PushService] Is showNotification() defined in index.html?');
      debugPrint('💥 [PushService] StackTrace: $stack');
    }
  }

  // ─────────────────────────────────────────
  // HANDLE NAVIGATION
  // ─────────────────────────────────────────
  static void _handleNavigation(Map<String, dynamic> data) {
    debugPrint('🧭 [PushService] _handleNavigation() called');
    debugPrint('🧭 [PushService] Data payload: $data');

    if (data.isEmpty) {
      debugPrint(
          '⚠️ [PushService] Data payload is empty — no navigation action');
      return;
    }

    final route = data['route'];
    debugPrint('🧭 [PushService] Route from payload: $route');

    if (route != null) {
      debugPrint('🧭 [PushService] Navigating to route: $route');
      // TODO: context.go(route) or Navigator.pushNamed(context, route)
      debugPrint('⚠️ [PushService] TODO: Implement navigation to $route');
    } else {
      debugPrint('⚠️ [PushService] No "route" key found in data payload');
      debugPrint('⚠️ [PushService] Available keys: ${data.keys.toList()}');
    }
  }
}
