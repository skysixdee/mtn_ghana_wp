  // ------------------ SUGGESTIONS ------------------
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/chat_bot/controllers/ai_agent_controller.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';


Widget initialSuggessions(AiAgentController c) {
  final suggestions = [
    topSongsByMichaelJacksonStr,
    showTuneCategoriesStr,
    goToNameTunesStr,
    buyAToneStr,
  ];

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    child: Wrap(
      alignment: WrapAlignment.center,          // ← CENTERED
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      runSpacing: 8,
      children: suggestions.map((text) {
        final hovered = false.obs;

        return MouseRegion(
          onEnter: (_) => hovered.value = true,
          onExit: (_) => hovered.value = false,
          cursor: SystemMouseCursors.click,
          child: Obx(
            () => GestureDetector(
              onTap: () {
                c.textController.text = text;
                c.sendMessage(text, isVoice: false);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: hovered.value
                        ? yellow
                        : const Color.fromARGB(255, 57, 57, 57),
                    width: 1,
                  ),
                ),
                child: Text(
                  text,
                  textAlign: TextAlign.center,        // ← CENTERED TEXT
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}