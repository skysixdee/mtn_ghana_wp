import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/chat_bot/chat_bot_widgets/custom_chat_bot_app_bar.dart';
import 'package:mtn_ghana_wp/files/chat_bot/chat_bot_widgets/initial_greetings.dart';
import 'package:mtn_ghana_wp/files/chat_bot/chat_bot_widgets/initial_suggessions.dart';
import 'package:mtn_ghana_wp/files/chat_bot/chat_bot_widgets/input_area.dart';
import 'package:mtn_ghana_wp/files/chat_bot/chat_bot_widgets/typing_indicator_bubble.dart';
import 'package:mtn_ghana_wp/files/chat_bot/controllers/ai_agent_controller.dart';
import 'package:mtn_ghana_wp/files/chat_bot/controllers/chat_controller.dart';
import 'package:mtn_ghana_wp/files/chat_bot/widgets/video_player_widget.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';

class AiAgentScreen extends StatelessWidget {
  const AiAgentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AiAgentController c = Get.put(AiAgentController());
    final chatController = Get.find<ChatController>();
    final isMobile = MediaQuery.of(context).size.width < 600;

    return ClipRRect(
      borderRadius: BorderRadius.circular(isMobile ? 0 : 16),
      child: Stack(
        children: [
          Container(
            color: black,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customChatbotAppBar(c, chatController),
                // Obx(() {
                //   if (c.messages.isEmpty) {
                //     return Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         initialGreetings(),
                //         initialSuggessions(c),
                //       ],
                //     );
                //   }
                //   return const SizedBox.shrink();
                // }),

                Obx(() {
                  //if (c.messages.isNotEmpty) return const SizedBox.shrink();
                  if (!c.isInGreetingMode.value) {
                    return const SizedBox.shrink();
                  }

                  final isMobile = MediaQuery.of(context).size.width < 600;

                  if (!isMobile) {
                    // Desktop remains unchanged
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            initialGreetings(),
                            initialSuggessions(c),
                          ],
                        ),
                      ),
                    );
                  }

                  // -------------------------------
                  // MOBILE → CENTERED
                  // -------------------------------
                  return Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // FULL CENTER
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Center(child: initialGreetings()),
                            ),
                            const SizedBox(height: 22),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Center(child: initialSuggessions(c)),
                            ),
                            const Spacer(), // pushes content vertically to center
                          ],
                        ),
                      ),
                    ),
                  );
                }),

                // --------- CHAT LIST (UNCHANGED) ----------
                Obx(() {
                  if (c.isInGreetingMode.value) 
                    return const SizedBox.shrink(); // hide chat list completely
                  final showTyping = c.isTyping.value;
                  final itemCount = c.messages.length + (showTyping ? 1 : 0);
                  

                  return Expanded(
                    child: ListView.builder(
                      controller: c.scrollHelper.scrollController,
                      reverse: true,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      itemCount: itemCount,
                      itemBuilder: (_, i) {
                        if (showTyping && i == 0) {
                          return const TypingIndicatorBubble();
                        }
                        final messageIndex = showTyping ? i - 1 : i;
                        final reversedIndex =  c.messages.length - 1 - messageIndex;
                        final message = c.messages[reversedIndex];

                        if (message.containsKey('bot_failed')) {
                          final msg = message['bot_failed'] ?? '';
                          return Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.redAccent.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                msg,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }

                        if (message.containsKey('user') ||
                            message.containsKey('bot')) {
                          final isUser = message.containsKey('user');
                          final msg = message[isUser ? 'user' : 'bot'] ?? '';

                          return Container(
                            alignment: isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isUser ? yellow : Colors.grey[800],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                msg,
                                style: TextStyle(
                                  color: isUser ? black : white,
                                ),
                              ),
                            ),
                          );
                        }

                        if (message.containsKey('bot_suggestions') &&
                            message['bot_suggestions'] == 'buy_options') {
                          return _buildBuyOptions(c);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  );
                }),

                dividerLine(),
                const SizedBox(height: 10),
                inputArea(c),
                const SizedBox(height: 10),
              ],
            ),
          ),

          // -------------------------------------------------------
          // 🔥 CENTERED VIDEO OVERLAY INSIDE THIS CHAT WINDOW ONLY
          // -------------------------------------------------------
          Obx(() {
            if (!c.isShowingHelpVideo.value) return const SizedBox.shrink();

            return Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // BLUR ONLY INSIDE CHAT WINDOW
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                      child: Container(
                        color: Colors.black.withOpacity(0.45),
                      ),
                    ),

                    // CENTERED SMALLER VIDEO
                    Center(
                      child: Container(
                        width: isMobile
                            ? MediaQuery.of(context).size.width * 0.9
                            : 260,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 18,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: const VideoPlayerWidget(
                            videoPath: "assets/videos/help_video.mp4",
                          ),
                        ),
                      ),
                    ),

                    // CLOSE BUTTON INSIDE CHAT WINDOW
                    Positioned(
                      right: 12,
                      top: 12,
                      child: InkWell(
                        onTap: () => c.isShowingHelpVideo.value = false,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 146, 145, 145),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget dividerLine() {
    return Container(width: double.infinity, height: 1, color: Colors.grey);
  }

  // ------------------ BUY OPTIONS ------------------
  Widget _buildBuyOptions(AiAgentController c) {
    final suggestions = [
      "By Tone Name",
      "By Artist",
      "By Categories",
      "Cancel"
    ];

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Wrap(
        spacing: 10,
        runSpacing: 8,
        children: suggestions.map((text) {
          final hovered = false.obs;
          return MouseRegion(
            onEnter: (_) => hovered.value = true,
            onExit: (_) => hovered.value = false,
            child: Obx(() {
              return GestureDetector(
                onTap: () {
                  if (text == "Cancel") {
                    c.isInGreetingMode.value = true;
                    c.messages.clear();
                    c.scrollHelper.scheduleJumpToLatest();
                    return;
                  }
                  c.textController.text = text;
                  c.sendMessage(text);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: hovered.value
                          ? yellow
                          : const Color.fromARGB(255, 57, 57, 57),
                    ),
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              );
            }),
          );
        }).toList(),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:mtn_sa_wp/files/chat_bot/controllers/ai_agent_controller.dart';
// import 'package:mtn_sa_wp/files/chat_bot/controllers/chat_controller.dart';
// import 'package:mtn_sa_wp/files/utility/colors.dart';

// class AiAgentScreen extends StatelessWidget {
//   const AiAgentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AiAgentController c = Get.put(AiAgentController());
//     final chatController = Get.find<ChatController>();

//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.black,
//         elevation: 0,
//         // title: const CustomText(
//         //   title: "AI Agent",
//         //   color: white,
//         //   fontName: FontName.semiBold,
//         // ),
//         actions: [
//   // HELP + VIDEO BUTTON
//   IconButton(
//     tooltip: "Video Guide",
//     onPressed: () {},
//     icon: Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Container(
//           width: 40,
//           height: 40,
//           decoration: BoxDecoration(
//             color: Colors.grey[850],
//             shape: BoxShape.circle,
//             border: Border.all(color: yellow, width: 1),
//           ),
//           child: const Center(
//             child: Icon(Icons.help_outline, color: yellow, size: 22),
//           ),
//         ),
//         Positioned(
//           right: -2,
//           top: -2,
//           child: Container(
//             width: 18,
//             height: 18,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: yellow,
//             ),
//             child: const Center(
//               child: Icon(Icons.play_arrow, size: 12, color: Colors.black),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),

  

//   // CLEAR CHAT BUTTON — Premium Style
//   IconButton(
//     tooltip: "Clear Chat",
//     onPressed: () {
//       if (c.messages.isNotEmpty) {
//         c.messages.clear();
//         c.scrollHelper.scheduleJumpToLatest();
//       }
//     },
//     icon: Container(
//       width: 40,
//       height: 40,
//       decoration: BoxDecoration(
//         color: Colors.grey[850],
//         shape: BoxShape.circle,
//         border: Border.all(color: Colors.white24, width: 1),
//       ),
//       child: const Center(
//         child: Icon(Icons.delete_outline, color: Colors.white, size: 22),
//       ),
//     ),
//   ),



//   // CLOSE BUTTON — Premium Style
//   IconButton(
//     tooltip: "Close",
//     onPressed: chatController.closeChat,
//     icon: Container(
//       width: 40,
//       height: 40,
//       decoration: BoxDecoration(
//         color: Colors.grey[850],
//         shape: BoxShape.circle,
//         border: Border.all(color: Colors.white24, width: 1),
//       ),
//       child: const Center(
//         child: Icon(Icons.close, color: Colors.white, size: 22),
//       ),
//     ),
//   ),

  
// ],

//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Obx(() {
//               if (c.messages.isEmpty) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildGreeting(),
//                     _buildSuggestions(c),
//                   ],
//                 );
//               }
//               return const SizedBox.shrink();
//             }),

//             Expanded(
//               child: Obx(
//                 () => ListView.builder(
//                   controller: c.scrollHelper.scrollController,
//                   reverse: true,
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//                   itemCount: c.messages.length,
//                   itemBuilder: (_, i) {
//                     final reversedIndex = c.messages.length - 1 - i;
//                     final message = c.messages[reversedIndex];

//                     // ░░ BOT FAILED MESSAGE ░░
//                     if (message.containsKey('bot_failed')) {
//                       final msg = message['bot_failed'] ?? '';
//                       return Container(
//                         alignment: Alignment.centerLeft,
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 5, horizontal: 10),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.redAccent.withOpacity(0.9),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           padding: const EdgeInsets.all(12),
//                           child: Text(
//                             msg,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       );
//                     }

//                     // ░░ USER / BOT MESSAGE BUBBLES ░░
//                     if (message.containsKey('user') ||
//                         message.containsKey('bot')) {
//                       final isUser = message.containsKey('user');
//                       final msg = message[isUser ? 'user' : 'bot'] ?? '';

//                       return Container(
//                         alignment: isUser
//                             ? Alignment.centerRight
//                             : Alignment.centerLeft,
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 5, horizontal: 10),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: isUser ? yellow : Colors.grey[800],
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           padding: const EdgeInsets.all(12),
//                           child: Text(
//                             msg,
//                             style: TextStyle(
//                               color: isUser ? black : white,
//                             ),
//                           ),
//                         ),
//                       );
//                     }

//                     // ░░ BOT SUGGESTION CHIPS ░░
//                     if (message.containsKey('bot_suggestions') &&
//                         message['bot_suggestions'] == 'buy_options') {
//                       final suggestions = [
//                         "By Tone Name",
//                         "By Artist",
//                         "By Categories",
//                         "Cancel",
//                       ];

//                       return Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 8),
//                         alignment: Alignment.centerLeft,
//                         child: Wrap(
//                           spacing: 10,
//                           runSpacing: 8,
//                           children: suggestions.map((text) {
//                             final hovered = false.obs;

//                             return MouseRegion(
//                               onEnter: (_) => hovered.value = true,
//                               onExit: (_) => hovered.value = false,
//                               cursor: SystemMouseCursors.click,
//                               child: Obx(
//                                 () => GestureDetector(
//                                   onTap: () {
//                                     if (text == "Cancel") {
//                                       if (c.messages.isNotEmpty) {
//                                         c.messages.clear();
//                                         c.scrollHelper.scheduleJumpToLatest();
//                                       }
//                                       return;
//                                     }
//                                     c.textController.text = text;
//                                     c.sendMessage(text, isVoice: false);
//                                   },
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 14, vertical: 10),
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey[900],
//                                       borderRadius: BorderRadius.circular(20),
//                                       border: Border.all(
//                                         color: hovered.value
//                                             ? yellow
//                                             : const Color.fromARGB(
//                                                 255, 57, 57, 57),
//                                         width: 1,
//                                       ),
//                                     ),
//                                     child: Text(
//                                       text,
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       );
//                     }

//                     return const SizedBox.shrink();
//                   },
//                 ),
//               ),
//             ),

//             //   const Divider(color: Colors.grey,
//             //  // height: 1,
//             //   ),
//             Container(width: double.infinity, height: 1, color: Colors.grey),
//             const SizedBox(height: 3),

//             _buildInputArea(c),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildGreeting() {
//     return const Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.0),
//       child: SizedBox(
//         width: double.infinity,
//         //padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
//         //color: Colors.black,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Hello there!",
//               style: TextStyle(
//                 color: yellow,
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 4),
//             Text(
//               "I'm AiAgent, your CallerTunez Assistant!",
//               style: TextStyle(color: Colors.white70, fontSize: 16),
//             ),
//             SizedBox(height: 2),
//             Text(
//               "You can search tones, browse artists or categories, and complete purchases seamlessly within this chat.",
//               style: TextStyle(color: Colors.white70, fontSize: 12),
//             ),
//             Text(
//               "How can I help you today?",
//               style: TextStyle(color: yellow, fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSuggestions(AiAgentController c) {
//     final suggestions = [
//       "Top songs by Michael Jackson",
//       "Show Tune categories",
//       "Go to Name tunes",
//       "Buy a tone",
//     ];

//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//       child: Wrap(
//         spacing: 10,
//         runSpacing: 8,
//         children: suggestions.map((text) {
//           final hovered = false.obs;

//           return MouseRegion(
//             onEnter: (_) => hovered.value = true,
//             onExit: (_) => hovered.value = false,
//             cursor: SystemMouseCursors.click,
//             child: Obx(
//               () => GestureDetector(
//                 onTap: () {
//                   c.textController.text = text;
//                   c.sendMessage(text, isVoice: false);
//                 },
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[900],
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(
//                       color: hovered.value
//                           ? yellow
//                           : const Color.fromARGB(255, 57, 57, 57),
//                       width: 1,
//                     ),
//                   ),
//                   child: Text(
//                     text,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildInputArea(AiAgentController c) {
//     return Obx(
//       () => Container(
//         padding: const EdgeInsets.only(left: 8, right: 8, bottom: 3),
//         child: Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 maxLines: 3,
//                 minLines: 1,
//                 textInputAction: TextInputAction.send,
//                 controller: c.textController,
//                 style: TextStyle(
//                   color: c.isListening.value ? Colors.blueGrey : Colors.white,
//                   fontStyle:
//                       c.isListening.value ? FontStyle.italic : FontStyle.normal,
//                 ),
//                 decoration: InputDecoration(
//                   hintText: c.isListening.value
//                       ? "Speak your query..."
//                       : "Type your message...",
//                   hintStyle: const TextStyle(color: Colors.grey),
//                   filled: true,
//                   fillColor: Colors.grey[900],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                 ),
//                 onSubmitted: (value) => c.sendMessage(value, isVoice: false),
//               ),
//             ),
//             const SizedBox(width: 8),
//             if (c.isListening.value) ...[
//               IconButton(
//                 icon: const Icon(Icons.check_circle,
//                     color: Colors.green, size: 32),
//                 onPressed: () {
//                   c.listeningActive = false;
//                   c.stopAndSend();
//                 },
//               ),
//               IconButton(
//                 icon:
//                     const Icon(Icons.cancel, color: Colors.redAccent, size: 32),
//                 onPressed: () {
//                   c.listeningActive = false;
//                   c.cancelListening();
//                 },
//               ),
//             ] else ...[
//               IconButton(
//                 icon: const Icon(Icons.mic, color: Colors.white, size: 30),
//                 onPressed: c.startListening,
//               ),
//               IconButton(
//                 icon: const Icon(Icons.send, color: yellow, size: 28),
//                 onPressed: () =>
//                     c.sendMessage(c.textController.text, isVoice: false),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }


//=============without adding auto scroll approach==============
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mtn_sa_wp/files/chat_bot/controllers/ai_agent_controller.dart';
// import 'package:mtn_sa_wp/files/chat_bot/controllers/chat_controller.dart';
// import 'package:mtn_sa_wp/files/enums/fonts.dart';
// import 'package:mtn_sa_wp/files/reusable_widgets/custom_text.dart';
// import 'package:mtn_sa_wp/files/utility/colors.dart';

// class AiAgentScreen extends StatelessWidget {
//   const AiAgentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AiAgentController c = Get.put(AiAgentController());
//     final chatController = Get.find<ChatController>();

//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.black,
//         elevation: 0,
//         title: const CustomText(
//           title: "AI Agent",
//           color: white,
//           fontName: FontName.semiBold,
//         ),
//         actions: [
//           IconButton(
//             tooltip: "Clear Chat",
//             icon: const Icon(Icons.delete_outline, color: Colors.white),
//             onPressed: () {
//               if (c.messages.isNotEmpty) {
//                 c.messages.clear();
//               }
//             },
//           ),
//           IconButton(
//             tooltip: "Close",
//             icon: const Icon(Icons.close, color: Colors.white),
//             onPressed: chatController.closeChat,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Obx(() {
//             if (c.messages.isEmpty) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildGreeting(),
//                   _buildSuggestions(c),
//                 ],
//               );
//             }
//             return const SizedBox.shrink();
//           }),
//           Expanded(
//             child: Obx(
//               () => ListView.builder(
//                 controller: c.scrollController,
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//                 itemCount: c.messages.length,
//                 itemBuilder: (_, i) {
//                   final message = c.messages[i];

//                   // 🟥 Case: Bot failed message (API failure)
//                   if (message.containsKey('bot_failed')) {
//                     final msg = message['bot_failed'] ?? '';
//                     return Container(
//                       alignment: Alignment.centerLeft,
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 5, horizontal: 10),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.redAccent.withOpacity(0.9),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: const EdgeInsets.all(12),
//                         child: Text(
//                           msg,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     );
//                   }

//                   // 🟡 Case 1: Normal user/bot messages
//                   if (message.containsKey('user') ||
//                       message.containsKey('bot')) {
//                     final isUser = message.containsKey('user');
//                     final msg = message[isUser ? 'user' : 'bot'] ?? '';
//                     return Container(
//                       alignment:
//                           isUser ? Alignment.centerRight : Alignment.centerLeft,
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 5, horizontal: 10),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: isUser ? yellow : Colors.grey[800],
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: const EdgeInsets.all(12),
//                         child: Text(
//                           msg,
//                           style: TextStyle(color: isUser ? black : white),
//                         ),
//                       ),
//                     );
//                   }

//                   // 🟢 Case 2: Bot suggestions (for buy tone)
//                   if (message.containsKey('bot_suggestions') &&
//                       message['bot_suggestions'] == 'buy_options') {
//                     final suggestions = ["By Tone Name", "By Artist", "Cancel"];
//                     return Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 8),
//                       alignment: Alignment.centerLeft,
//                       child: Wrap(
//                         spacing: 10,
//                         runSpacing: 8,
//                         children: suggestions.map((text) {
//                           final hovered = false.obs;
//                           return MouseRegion(
//                             onEnter: (_) => hovered.value = true,
//                             onExit: (_) => hovered.value = false,
//                             cursor: SystemMouseCursors.click,
//                             child: Obx(
//                               () => GestureDetector(
//                                 onTap: () {
//                                   if (text == "Cancel") {
//                                     // 🧹 Works exactly like Clear Chat
//                                     if (c.messages.isNotEmpty) {
//                                       c.messages.clear();
//                                     }
//                                     return;
//                                   }
//                                   c.textController.text = text;
//                                   c.sendMessage(text);
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 14, vertical: 10),
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey[900],
//                                     borderRadius: BorderRadius.circular(20),
//                                     border: Border.all(
//                                       color: hovered.value
//                                           ? yellow
//                                           : const Color.fromARGB(
//                                               255, 57, 57, 57),
//                                       width: 1,
//                                     ),
//                                   ),
//                                   child: Text(
//                                     text,
//                                     style: const TextStyle(
//                                         color: Colors.white, fontSize: 14),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     );
//                   }

//                   return const SizedBox.shrink();
//                 },
//               ),
//             ),
//           ),
//           const Divider(color: Colors.grey),
//           _buildInputArea(c),
//         ],
//       ),
//     );
//   }

//   Widget _buildGreeting() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
//       color: Colors.black,
//       child: const Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Hello there!",
//             style: TextStyle(
//               color: yellow,
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 6),
//           Text(
//             "I'm AiAgent, your Smart Assistant!",
//             style: TextStyle(color: Colors.white70, fontSize: 16),
//           ),
//           SizedBox(height: 2),
//           Text(
//             "How can I help you today?",
//             style: TextStyle(color: Colors.white70, fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }

//   /// 🧠 Default suggestion buttons
//   Widget _buildSuggestions(AiAgentController c) {
//     final suggestions = [
//       "Top songs by Michael Jackson",
//       "Show Tune categories",
//       "Go to Name tunes",
//       "Buy a tone"
//     ];

//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//       child: Wrap(
//         spacing: 10,
//         runSpacing: 8,
//         children: suggestions.map((text) {
//           final hovered = false.obs;
//           return MouseRegion(
//             onEnter: (_) => hovered.value = true,
//             onExit: (_) => hovered.value = false,
//             cursor: SystemMouseCursors.click,
//             child: Obx(
//               () => GestureDetector(
//                 onTap: () {
//                   c.textController.text = text;
//                   c.sendMessage(text);
//                 },
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[900],
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(
//                       color: hovered.value
//                           ? yellow
//                           : const Color.fromARGB(255, 57, 57, 57),
//                       width: 1,
//                     ),
//                   ),
//                   child: Text(
//                     text,
//                     style: const TextStyle(color: Colors.white, fontSize: 14),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   /// 💬 Input field section
//   Widget _buildInputArea(AiAgentController c) {
//     return Obx(
//       () => Container(
//         color: Colors.black,
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//         child: Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: c.textController,
//                 style: TextStyle(
//                   color: c.isListening.value ? Colors.blueGrey : Colors.white,
//                   fontStyle:
//                       c.isListening.value ? FontStyle.italic : FontStyle.normal,
//                 ),
//                 decoration: InputDecoration(
//                   hintText: c.isListening.value
//                       ? "Speak your query..."
//                       : "Type your message...",
//                   hintStyle: const TextStyle(color: Colors.grey),
//                   filled: true,
//                   fillColor: Colors.grey[900],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             if (c.isListening.value) ...[
//               IconButton(
//                 icon: const Icon(Icons.check_circle,
//                     color: Colors.green, size: 32),
//                 onPressed: () {
//                   c.listeningActive = false;
//                   c.stopAndSend();
//                 },
//               ),
//               IconButton(
//                 icon:
//                     const Icon(Icons.cancel, color: Colors.redAccent, size: 32),
//                 onPressed: () {
//                   c.listeningActive = false;
//                   c.cancelListening();
//                 },
//               ),
//             ] else ...[
//               IconButton(
//                 icon: const Icon(Icons.mic, color: Colors.white, size: 30),
//                 onPressed: c.startListening,
//               ),
//               IconButton(
//                 icon: const Icon(Icons.send, color: yellow, size: 28),
//                 onPressed: () => c.sendMessage(c.textController.text),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }





//==================without buy tone flow========================

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mtn_sa_wp/files/chat_bot/controllers/ai_agent_controller.dart';
// import 'package:mtn_sa_wp/files/chat_bot/controllers/chat_controller.dart';
// import 'package:mtn_sa_wp/files/enums/fonts.dart';
// import 'package:mtn_sa_wp/files/reusable_widgets/custom_text.dart';
// import 'package:mtn_sa_wp/files/utility/colors.dart';

// class AiAgentScreen extends StatelessWidget {
//   const AiAgentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AiAgentController c = Get.put(AiAgentController());
//     final chatController = Get.find<ChatController>();

//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.black,
//         elevation: 0,
//         title: const CustomText(
//           title:"AI Agent",
//           color: white,
//           fontName: FontName.semiBold,
//         ),
//         actions: [
//           IconButton(
//             tooltip: "Clear Chat",
//             icon: const Icon(Icons.delete_outline, color: Colors.white),
//             onPressed: () {
//               if (c.messages.isNotEmpty) {
//                 c.messages.clear();
//               }
//             },
//           ),
//           IconButton(
//             tooltip: "Close",
//             icon: const Icon(Icons.close, color: Colors.white),
//             onPressed: chatController.closeChat,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Obx(() {
//             if (c.messages.isEmpty) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildGreeting(),
//                   _buildSuggestions(c),
//                 ],
//               );
//             }
//             return const SizedBox.shrink();
//           }),
//           Expanded(
//             child: Obx(
//               () => ListView.builder(
//                 controller: c.scrollController,
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//                 itemCount: c.messages.length,
//                 itemBuilder: (_, i) {
//                   final isUser = c.messages[i].containsKey('user');
//                   final message = c.messages[i][isUser ? 'user' : 'bot'] ?? '';
//                   return Container(
//                     alignment: isUser
//                         ? Alignment.centerRight
//                         : Alignment.centerLeft,
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 5, horizontal: 10),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: isUser ?yellow: Colors.grey[800],
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: const EdgeInsets.all(12),
//                       child: Text(
//                         message,

//                         style: TextStyle(color: isUser?black:white),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),

//           const Divider(color: Colors.grey),
//           _buildInputArea(c),
//         ],
//       ),
//     );
//   }

//   Widget _buildGreeting() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
//       color: Colors.black,
//       child:const Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children:[
          
//           Text(
//             "Hello there!",
//             style: TextStyle(
//               color: yellow,
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 6),
//           Text(
//             "I'm AiAgent, your Smart Assistant!",
//             style: TextStyle(color: Colors.white70, fontSize: 16),
//           ),
//           SizedBox(height: 2),
//           Text(
//             "How can I help you today?",
//             style: TextStyle(color: Colors.white70, fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }

//   /// 🧠 Default suggestion buttons
//   Widget _buildSuggestions(AiAgentController c) {
//     final suggestions = [
//       "Top songs by Michael Jackson",
//       "Show Tune categories",
//       "Go to Name tunes",
//       "Buy a tone"
//     ];

//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//       child: Wrap(
//         spacing: 10,
//         runSpacing: 8,
//         children: suggestions.map((text) {
//           final hovered = false.obs;
//           return MouseRegion(
//             onEnter: (_) => hovered.value = true,
//             onExit: (_) => hovered.value = false,
//             cursor: SystemMouseCursors.click,
//             child: Obx(
//               () => GestureDetector(
//                 onTap: () {
//                   c.textController.text = text;
//                   c.sendMessage(text);
//                 },
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[900],
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(
//                       color: hovered.value
//                           ? yellow
//                           : const Color.fromARGB(255, 57, 57, 57),
//                       width: 1,
//                     ),
//                   ),
//                   child: Text(
//                     text,
//                     style: const TextStyle(color: Colors.white, fontSize: 14),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   /// 💬 Input field section
//   Widget _buildInputArea(AiAgentController c) {
//     return Obx(
//       () => Container(
//         color: Colors.black,
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//         child: Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: c.textController,
//                 style: TextStyle(
//                   color: c.isListening.value
//                       ? Colors.blueGrey
//                       : Colors.white,
//                   fontStyle: c.isListening.value
//                       ? FontStyle.italic
//                       : FontStyle.normal,
//                 ),
//                 decoration: InputDecoration(
//                   hintText: c.isListening.value
//                       ? "Speak your query..."
//                       : "Type your message...",
//                   hintStyle: const TextStyle(color: Colors.grey),
//                   filled: true,
//                   fillColor: Colors.grey[900],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 20, vertical: 12),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             if (c.isListening.value) ...[
//               IconButton(
//                 icon: const Icon(Icons.check_circle,
//                     color: Colors.green, size: 32),
//                 onPressed: () {
//                   c.listeningActive = false;
//                   c.stopAndSend();
//                 },
//               ),
//               IconButton(
//                 icon: const Icon(Icons.cancel,
//                     color: Colors.redAccent, size: 32),
//                 onPressed: () {
//                   c.listeningActive = false;
//                   c.cancelListening();
//                 },
//               ),
//             ] else ...[
//               IconButton(
//                 icon: const Icon(Icons.mic, color: Colors.white, size: 30),
//                 onPressed: c.startListening,
//               ),
//               IconButton(
//                 icon:
//                     const Icon(Icons.send, color:yellow, size: 28),
//                 onPressed: () => c.sendMessage(c.textController.text),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }



//---------------without suggession chips or buttons------------------------

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mtn_sa_wp/files/chat_bot/controllers/ai_agent_controller.dart';
// import 'package:mtn_sa_wp/files/chat_bot/controllers/chat_controller.dart';

// class AiAgentScreen extends StatelessWidget {
//   const AiAgentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AiAgentController c = Get.put(AiAgentController());
//      final chatController = Get.find<ChatController>();

//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               "AI Agent",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             InkWell(
//               onTap: chatController.closeChat,
//               child: const Icon(Icons.close, color: Colors.white),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(
//               () => ListView.builder(
//                 controller: c.scrollController,
//                 padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//                 itemCount: c.messages.length,
//                 itemBuilder: (_, i) {
//                   final isUser = c.messages[i].containsKey('user');
//                   final message = c.messages[i][isUser ? 'user' : 'bot'] ?? '';
//                   return Container(
//                     alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//                     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: isUser ? Colors.blueAccent : Colors.grey[800],
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: const EdgeInsets.all(12),
//                       child: Text(
//                         message,
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           const Divider(color: Colors.grey),
//           _buildInputArea(c),
//         ],
//       ),
//     );
//   }

//   Widget _buildInputArea(AiAgentController c) {
//     return Obx(
//       () => Container(
//         color: Colors.black,
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//         child: Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: c.textController,
//                 style: TextStyle(
//                   color: c.isListening.value ? Colors.blueGrey : Colors.white,
//                   fontStyle: c.isListening.value ? FontStyle.italic : FontStyle.normal,
//                 ),
//                 decoration: InputDecoration(
//                   hintText: c.isListening.value ?"Speak your query...":"Type your message...",
//                   hintStyle: const TextStyle(color: Colors.grey),
//                   filled: true,
//                   fillColor: Colors.grey[900],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             if (c.isListening.value) ...[
//               // ✅ Tick button
//               IconButton(
//                 icon: const Icon(Icons.check_circle, color: Colors.green, size: 32),
//                 onPressed: () {
//                   c.listeningActive = false; // stop further updates
//                   c.stopAndSend();
//                 },
//               ),
//               // ❌ Cross button
//               IconButton(
//                 icon: const Icon(Icons.cancel, color: Colors.redAccent, size: 32),
//                 onPressed: () {
//                   c.listeningActive = false; // stop further updates
//                   c.cancelListening();
//                 },
//               ),
//             ] else ...[
//               // 🎤 Mic button
//               IconButton(
//                 icon: const Icon(Icons.mic, color: Colors.white, size: 30),
//                 onPressed: c.startListening,
//               ),
//               // 📤 Send button
//               IconButton(
//                 icon: const Icon(Icons.send, color: Colors.blueAccent, size: 28),
//                 onPressed: () => c.sendMessage(c.textController.text),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

