import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  ScrollController? _scrollController;
  GlobalKey? _categoryKey;

  void attachScrollController(
    ScrollController controller,
    GlobalKey categoryKey,
  ) {
    _scrollController = controller;
    _categoryKey = categoryKey;
  }

  void detachScrollController(ScrollController controller) {
    if (_scrollController == controller) {
      _scrollController = null;
      _categoryKey = null;
    }
  }

  Future<void> scrollToCategories() async {
    for (var attempt = 0; attempt < 12; attempt++) {
      final controller = _scrollController;
      final renderObject = _categoryKey?.currentContext?.findRenderObject();

      if (renderObject is RenderBox &&
          renderObject.attached &&
          controller != null &&
          controller.hasClients) {
        await _scrollToAttachedCategory(renderObject, controller);
        return;
      }

      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  Future<void> _scrollToAttachedCategory(
    RenderBox box,
    ScrollController controller,
  ) async {
    final offset = box.localToGlobal(Offset.zero).dy;
    final target = (controller.offset + offset - 100).clamp(
      controller.position.minScrollExtent,
      controller.position.maxScrollExtent,
    ).toDouble();
    await controller.animateTo(
      target,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }
}

