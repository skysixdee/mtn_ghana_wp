import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/chat_bot/chat_bot_widgets/equalizer_wave.dart';
import 'package:mtn_ghana_wp/files/chat_bot/controllers/ai_agent_controller.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';


Widget inputArea(AiAgentController c) {
  return Obx(
    () => Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        children: [
          // -------------------------------
          // TEXT FIELD + WAVE WHEN LISTENINGi
          // -------------------------------
          Expanded(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                TextField(
                  maxLines: 3,
                  minLines: 1,
                  textInputAction: TextInputAction.send,
                  controller: c.textController,
                  onChanged: (value) {
                    // Enable tick only when text is present
                    c.isTickEnabled.value = value.trim().isNotEmpty;
                  },
                  style: TextStyle(
                    color: c.isListening.value ? Colors.blueGrey : Colors.white,
                    fontStyle: c.isListening.value
                        ? FontStyle.italic
                        : FontStyle.normal,
                  ),
                  decoration: InputDecoration(
                    hintText: (c.isListening.value || c.isBotSpeaking.value)
                        ? ""
                        : "Type your message...",
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  onSubmitted: (value) {
                    final text = c.textController.text.trim();

                    // If mic session is active (voice mode)
                    if (c.isMicSessionActive.value) {
                      if (text.isNotEmpty) {
                        // ENTER behaves exactly like pressing ✓
                        c.listeningActive = false;
                        c.stopAndSend();
                      }
                      return; // Prevent normal submit behavior
                    }

                    // Normal typing mode
                    if (text.isNotEmpty) {
                      c.sendMessage(text, isVoice: false);
                    }
                  },
                ),

                /// ----------------------------------------------------------
                ///  NEW: Wave animation INSIDE the TextField while listening
                /// ----------------------------------------------------------
                if (c.isListening.value || c.isBotSpeaking.value)
                  Positioned(
                    left: 20,
                    right: 20,
                    child: SizedBox(
                      height: 36,
                      child: EqualizerWave(
                        levelListenable: c.isListening.value
                            ? c.speechLevel
                            : c.botSpeechLevel,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // --------------------------------------------------------
          // MIC + SEND BUTTON LOGIC
          // --------------------------------------------------------
          if (c.isMicSessionActive.value) ...[
            IconButton(
              icon: Icon(Icons.check_circle,
                  color: c.isTickEnabled.value
                      ? Colors.green
                      : const Color.fromARGB(255, 100, 100, 100),
                  size: 32),
              onPressed: c.isTickEnabled.value
                  ? () {
                      c.listeningActive = false;
                      c.stopAndSend();
                    }
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.cancel, color: Colors.redAccent, size: 32),
              onPressed: () {
                c.listeningActive = false;
                c.cancelListening();
              },
            ),
          ] else ...[
            IconButton(
              icon: const Icon(Icons.mic, color: Colors.white, size: 30),
              onPressed: c.startListening,
            ),
            IconButton(
              icon: const Icon(Icons.send, color: yellow, size: 28),
              onPressed: () {
                final isMobile = MediaQuery.of(Get.context!).size.width < 600;

                if (isMobile && c.textController.text.isNotEmpty) {
                  c.hideKeyboard();
                }
                if (c.textController.text.isNotEmpty) {
                  c.sendMessage(c.textController.text, isVoice: false);
                }
              },
            ),
          ],
        ],
      ),
    ),
  );
}
