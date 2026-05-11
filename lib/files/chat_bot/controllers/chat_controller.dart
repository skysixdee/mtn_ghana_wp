import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/chat_bot/controllers/ai_agent_controller.dart';


class ChatController extends GetxController {
  RxBool showChat = false.obs;
  final isFabPressed = false.obs;

  void toggleChat() {
    showChat.value = !showChat.value;

    if (showChat.value) {
      // Ensure we land on the latest message as soon as the sheet opens
      Future.delayed(const Duration(milliseconds: 50), () {
        if (Get.isRegistered<AiAgentController>()) {
          final ai = Get.find<AiAgentController>();
          ai.scrollHelper.scheduleJumpToLatest();
          ai.checkForFailedBuyToneMessage();
        }
      });
    }
  }

  void closeChat() => showChat.value = false;
}


//===================before adding new auto scroll approach===================
// import 'package:get/get.dart';
// import 'package:mtn_sa_wp/files/chat_bot/controllers/ai_agent_controller.dart';

// class ChatController extends GetxController {
//   RxBool showChat = false.obs;
//   final isFabPressed = false.obs;

//   void toggleChat() {
//     showChat.value = !showChat.value;

//     if (showChat.value) {
//       Future.delayed(const Duration(milliseconds: 300), () {
//         if (Get.isRegistered<AiAgentController>()) {
//           final ai = Get.find<AiAgentController>();
//           ai.scrollToBottom();
//           ai.checkForFailedBuyToneMessage(); // 👈 Added this line
//         }
//       });
//     }
//   }

//   void closeChat() => showChat.value = false;
// }




// import 'package:get/get.dart';

// class ChatController extends GetxController {
//   /// Observable boolean to track chat popup visibility
//   RxBool showChat = false.obs;
//   final isFabPressed = false.obs;


//   /// Toggle chat popup on/off
//   void toggleChat() => showChat.value = !showChat.value;

//   /// Close chat popup
//   void closeChat() => showChat.value = false;
// }
