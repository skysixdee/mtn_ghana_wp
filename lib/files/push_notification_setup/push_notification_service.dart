import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'dart:js_interop';
import 'package:web/web.dart' as web;

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
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      debugPrint('✅ [PushService] Background handler registered');

      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      debugPrint(
          '📊 [PushService] Permission: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        await _getToken();
        _setupHandlers();
      } else {
        debugPrint('❌ [PushService] Permission DENIED');
      }
    } catch (e, stack) {
      debugPrint('💥 [PushService] initialize() error: $e');
      debugPrint('💥 [PushService] StackTrace: $stack');
    }
    debugPrint('🏁 [PushService] initialize() completed');
  }

  // ─────────────────────────────────────────
  // GET TOKEN
  // ─────────────────────────────────────────
  static Future<String?> _getToken() async {
    debugPrint('🔑 [PushService] _getToken() called');
    try {
      final token = kIsWeb
          ? await FirebaseMessaging.instance.getToken(vapidKey: _vapidKey)
          : await FirebaseMessaging.instance.getToken();

      if (token != null) {
        debugPrint('✅ [PushService] Full Token: $token');
      } else {
        debugPrint('❌ [PushService] Token is NULL');
      }
      return token;
    } catch (e, stack) {
      debugPrint('💥 [PushService] _getToken() error: $e');
      debugPrint('💥 [PushService] StackTrace: $stack');
      return null;
    }
  }

  // ─────────────────────────────────────────
  // SETUP HANDLERS
  // ─────────────────────────────────────────
  static void _setupHandlers() {
    debugPrint('🎧 [PushService] _setupHandlers() called');

    // FOREGROUND
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        debugPrint('📱 [PushService] FOREGROUND message received');
        debugPrint('📱 [PushService] Title: ${message.notification?.title}');
        debugPrint('📱 [PushService] Body: ${message.notification?.body}');
        debugPrint('📱 [PushService] Data: ${message.data}');
        debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        _showInAppBanner(message);
      },
      onError: (e) => debugPrint('💥 [PushService] onMessage error: $e'),
    );

    // BACKGROUND → APP OPENED
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        debugPrint('👆 [PushService] App OPENED from notification');
        debugPrint('👆 [PushService] Data: ${message.data}');
        _handleNavigation(message.data);
      },
      onError: (e) =>
          debugPrint('💥 [PushService] onMessageOpenedApp error: $e'),
    );

    debugPrint('✅ [PushService] All listeners attached');
  }

  // ─────────────────────────────────────────
  // SHOW IN-APP BANNER
  // ─────────────────────────────────────────
  static void _showInAppBanner(RemoteMessage message) {
    debugPrint('🖼️ [PushService] _showInAppBanner() called');
    if (kIsWeb) {
      _showBrowserNotification(
        message.notification?.title ?? '',
        message.notification?.body ?? '',
      );
    } else {
      debugPrint('📲 [PushService] Mobile — show snackbar here');
    }
  }

  // ─────────────────────────────────────────
  // SHOW BROWSER NOTIFICATION (router)
  // ─────────────────────────────────────────
  static Future<void> _showBrowserNotification(
      String title, String body) async {
    debugPrint('🌐 [PushService] _showBrowserNotification() called');
    try {
      final permission = web.Notification.permission;
      debugPrint('🌐 [PushService] Permission: $permission');

      if (permission != 'granted') {
        debugPrint('❌ [PushService] Permission not granted');
        return;
      }

      // Check if app tab is visible or minimized
      final isVisible = web.document.visibilityState == 'visible';
      debugPrint('🌐 [PushService] Document visible: $isVisible');

      if (isVisible) {
        // App is MAXIMIZED — use direct Notification API
        debugPrint(
            '🌐 [PushService] App foreground — using direct Notification API');
        _showForegroundNotification(title, body);
      } else {
        // App is MINIMIZED — use ServiceWorker
        debugPrint('🌐 [PushService] App minimized — using ServiceWorker');
        await _showBackgroundNotification(title, body);
      }
    } catch (e, stack) {
      debugPrint('💥 [PushService] _showBrowserNotification error: $e');
      debugPrint('💥 [PushService] Stack: $stack');
    }
  }

  // ─────────────────────────────────────────
  // FOREGROUND NOTIFICATION (direct API)
  // ─────────────────────────────────────────
  static void _showForegroundNotification(String title, String body) {
    try {
      debugPrint('📢 [PushService] Showing FOREGROUND notification');
      web.Notification(
        title,
        web.NotificationOptions(
          body: body,
          icon: '/icons/Icon-192.png',
          requireInteraction: false,
          silent: false,
        ),
      );
      debugPrint('✅ [PushService] Foreground notification shown');
    } catch (e) {
      debugPrint('💥 [PushService] Foreground notification failed: $e');
    }
  }

  // ─────────────────────────────────────────
  // BACKGROUND NOTIFICATION (ServiceWorker)
  // ─────────────────────────────────────────
  static Future<void> _showBackgroundNotification(
      String title, String body) async {
    try {
      debugPrint('📢 [PushService] Showing BACKGROUND notification via SW');

      final registration =
          await web.window.navigator.serviceWorker.ready.toDart.timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          debugPrint('❌ [PushService] SW ready timeout');
          throw Exception('SW timeout');
        },
      );

      registration.showNotification(
        title,
        web.NotificationOptions(
          body: body,
          icon: '/icons/Icon-192.png',
          badge: '/icons/Icon-192.png',
          requireInteraction: false,
          silent: false,
        ),
      );
      debugPrint('✅ [PushService] Background notification shown via SW');
    } catch (e) {
      debugPrint('💥 [PushService] SW notification failed: $e');
      debugPrint('🔄 [PushService] Falling back to direct API');
      _showForegroundNotification(title, body); // fallback
    }
  }

  // ─────────────────────────────────────────
  // HANDLE NAVIGATION
  // ─────────────────────────────────────────
  static void _handleNavigation(Map<String, dynamic> data) {
    debugPrint('🧭 [PushService] _handleNavigation() called');
    debugPrint('🧭 [PushService] Data: $data');

    if (data.isEmpty) {
      debugPrint('⚠️ [PushService] No data payload');
      return;
    }

    final route = data['route'];
    if (route != null) {
      debugPrint('🧭 [PushService] TODO: Navigate to $route');
    } else {
      debugPrint('⚠️ [PushService] No route key. Keys: ${data.keys.toList()}');
    }
  }
}
