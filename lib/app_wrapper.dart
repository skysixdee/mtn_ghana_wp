// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// /// Dummy Chat Controller (same structure as original)
// class ChatController extends GetxController {
//   RxBool showChat = false.obs;

//   void toggleChat() {
//     showChat.value = !showChat.value;
//   }
// }

// /// Dummy FAB (replace later with BreathingGradientFab)
// class DummyFab extends StatelessWidget {
//   final VoidCallback onTap;
//   final Widget child;

//   const DummyFab({super.key, required this.onTap, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//       onPressed: onTap,
//       child: child,
//     );
//   }
// }

// class AppWrapper extends StatelessWidget {
//   final Widget child;

//   const AppWrapper({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     final chatController = Get.put(ChatController());
//     final width = MediaQuery.of(context).size.width;
//     final isMobile = width < 600;

//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: isMobile
//           ? (didPop, result) {
//               if (didPop) return;

//               if (chatController.showChat.value) {
//                 chatController.showChat.value = false;
//                 return;
//               }

//               Navigator.of(context).maybePop();
//             }
//           : null,
//       child: Scaffold(
//         body: SafeArea(
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               /// ✅ EXISTING APP (Router)
//               Positioned.fill(child: child),

//               /// ✅ CHATBOT (Dummy for now)
//               Obx(() {
//                 final isVisible = chatController.showChat.value;

//                 if (!isVisible) return const SizedBox.shrink();

//                 /// MOBILE → FULLSCREEN
//                 if (isMobile) {
//                   return Positioned.fill(
//                     child: Container(
//                       color: Colors.black,
//                       child: const Center(
//                         child: SizedBox(
//                           width: 200,
//                           height: 200,
//                           child: ColoredBox(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   );
//                 }

//                 /// DESKTOP → POPUP
//                 return Positioned(
//                   bottom: 30,
//                   right: 20,
//                   child: Material(
//                     elevation: 14,
//                     borderRadius: BorderRadius.circular(16),
//                     child: Container(
//                       width: 360,
//                       height: 500,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: const Center(
//                         child: SizedBox(
//                           width: 200,
//                           height: 200,
//                           child: ColoredBox(color: Colors.grey),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             ],
//           ),
//         ),

//         /// ✅ FLOATING BUTTON
//         floatingActionButton: Obx(() {
//           if (chatController.showChat.value) {
//             return const SizedBox.shrink();
//           }

//           return Padding(
//             padding:
//                 EdgeInsets.only(bottom: isMobile ? 50 : 16.0, right: 12.0),
//             child: DummyFab(
//               onTap: chatController.toggleChat,
//               child: const Icon(Icons.smart_toy),
//             ),
//           );
//         }),
//         floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/chat_bot/chat_bot_buttons/live_chat_fab.dart';
import 'package:mtn_ghana_wp/files/chat_bot/controllers/chat_controller.dart';
import 'package:mtn_ghana_wp/files/chat_bot/screens/ai_agent_screen.dart';

class AppWrapper extends StatelessWidget {
  final Widget child;

  const AppWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatController());
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: isMobile
          ? (didPop, result) {
              if (didPop) return;

              // If chatbot open → close it
              if (chatController.showChat.value) {
                chatController.showChat.value = false;
                return;
              }

              // else normal back
              Navigator.of(context).maybePop();
            }
          : null,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              /// ✅ MAIN APP (Router)
              Positioned.fill(child: child),

              /// ✅ CHATBOT UI
              Obx(() {
                final isVisible = chatController.showChat.value;

                if (!isVisible) return const SizedBox.shrink();

                /// 📱 MOBILE → FULLSCREEN
                if (isMobile) {
                  return Positioned.fill(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        key: const ValueKey('chat_mobile_fullscreen'),
                        color: Colors.black,
                        child: const AiAgentScreen(),
                      ),
                    ),
                  );
                }

                /// 💻 DESKTOP → POPUP
                return Positioned(
                  bottom: 30,
                  right: 20,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    layoutBuilder: (currentChild, previousChildren) {
                      return Stack(
                        children: [
                          ...previousChildren,
                          if (currentChild != null) currentChild,
                        ],
                      );
                    },
                    child: Material(
                      elevation: 14,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: 360,
                        height: 500,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const ClipRRect(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16)),
                          child: AiAgentScreen(),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),

        /// ✅ FLOATING BUTTON
        floatingActionButton: Obx(() {
          if (chatController.showChat.value) {
            return const SizedBox.shrink();
          }

          return Padding(
            padding:
                EdgeInsets.only(bottom: isMobile ? 50 : 16.0, right: 12.0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: BreathingGradientFab(
                onTap: chatController.toggleChat,
                child: const Icon(
                  Icons.smart_toy_rounded,
                  color: Colors.black87,
                  size: 34,
                ),
              ),
            ),
          );
        }),

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}