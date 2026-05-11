import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';

class MoodDetectionScreen extends StatefulWidget {
  const MoodDetectionScreen({super.key});

  @override
  State<MoodDetectionScreen> createState() => _MoodDetectionScreenState();
}

class _MoodDetectionScreenState extends State<MoodDetectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(title: "Mood Detection"),
    );
  }
}
