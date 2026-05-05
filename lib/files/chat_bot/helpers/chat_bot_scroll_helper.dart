import 'package:flutter/material.dart';

/// A helper class to manage smooth and reliable chat auto-scrolling.
/// Works seamlessly with reverse:true ListView like ChatGPT or WhatsApp.
class ChatScrollHelper {
  final ScrollController scrollController = ScrollController();

  bool _pendingJump = false;

  /// Call this when messages list changes
  void scheduleJumpToLatest() {
    if (_pendingJump) return;
    _pendingJump = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _jumpToLatest(animated: false);

      // run once more in microtask (for async layout adjustments)
      Future.microtask(() {
        _jumpToLatest(animated: false);
        _pendingJump = false;
      });
    });
  }

  /// Manually jump or animate to latest
  void jumpToLatestNow({bool animated = false}) => _jumpToLatest(animated: animated);

  void _jumpToLatest({bool animated = false}) {
    if (!scrollController.hasClients) return;
    const target = 0.0; // for reverse:true ListView
    try {
      if (animated) {
        scrollController.animateTo(
          target,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      } else {
        scrollController.jumpTo(target);
      }
    } catch (_) {
      // ignore occasional asserts
    }
  }

  void dispose() {
    scrollController.dispose();
  }
}
