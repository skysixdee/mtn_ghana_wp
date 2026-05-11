// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mtn_ghana_wp/files/api_calls/get_artist_tunes_list_api.dart';
// import 'package:mtn_ghana_wp/files/api_calls/get_search_tune_list_api.dart';

// import 'dart:convert';
// import 'dart:js' as js;

// import 'package:mtn_ghana_wp/files/chat_bot/controllers/chat_controller.dart';
// import 'package:mtn_ghana_wp/files/chat_bot/helpers/chat_bot_scroll_helper.dart';
// import 'package:mtn_ghana_wp/files/chat_bot/services/speech_service.dart';
// import 'package:mtn_ghana_wp/files/chat_bot/services/tts_service.dart';
// import 'package:mtn_ghana_wp/files/controllers/home_controllers/home_controller.dart';
// import 'package:mtn_ghana_wp/files/model/artist_tune_list_model.dart';
// import 'package:mtn_ghana_wp/files/model/search_result_model.dart';
// import 'package:mtn_ghana_wp/files/model/tune_info.dart';
// import 'package:mtn_ghana_wp/files/router/route_name.dart';
// import 'package:mtn_ghana_wp/files/router/router.dart';
// import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
// import 'package:mtn_ghana_wp/files/utility/strings.dart';
// import 'package:mtn_ghana_wp/main.dart';


// part 'chat_nlp_handler.dart';

// class AiAgentController extends GetxController with ChatNlpHandler {
//   bool gotSpeechResult = false;
//   final chatController = Get.find<ChatController>();
//   final textController = TextEditingController();
//   final ValueNotifier<double> speechLevel = ValueNotifier<double>(0);
//   final ValueNotifier<double> botSpeechLevel = ValueNotifier<double>(0);
//   final isMicSessionActive = false.obs;
//   final isBotSpeaking = false.obs;
//   final isTickEnabled = false.obs; // NEW
//   /// ✅ Scroll helper for chatbot
//   final ChatScrollHelper scrollHelper = ChatScrollHelper();

//   final isShowingHelpVideo = false.obs;
//   final isInGreetingMode = true.obs;

//   final messages = <Map<String, String>>[].obs;
//   final isListening = false.obs;
//   List<TuneInfo> tuneList = <TuneInfo>[].obs;
//   bool listeningActive = false;
//   // String _lastFinalSpeech = "";
//   String? buyToneMode;

//   /// 🆕 Tracks whether the last user action was via VOICE
//   bool lastMessageFromVoice = false;

//   @override
//   void onInit() {
//     super.onInit();
//     SpeechService.initSpeech();
//     TTSService.initTTS(
//       onStart: () {
//         isBotSpeaking.value = true;
//         botSpeechLevel.value = 0.6;
//       },
//       onComplete: () {
//         isBotSpeaking.value = false;
//         botSpeechLevel.value = 0;
//       },
//       onCancel: () {
//         isBotSpeaking.value = false;
//         botSpeechLevel.value = 0;
//       },
//       onError: () {
//         isBotSpeaking.value = false;
//         botSpeechLevel.value = 0;
//       },
//     );

//     // Auto-scroll whenever messages update
//     ever(messages, (_) => scrollHelper.scheduleJumpToLatest());
//   }

//   /// 🟥 If purchase failed, show red bubble + retry options
//   void checkForFailedBuyToneMessage() {
//     final failedMessage = StoreManager.getFailedBuyToneMessage();
//     if (failedMessage != null && failedMessage.isNotEmpty) {
//       // Show the failed message UI bubble
//       messages.add({'bot_failed': failedMessage});

//       // Speak only if user used voice prior
//       speakQueued(failedMessage);

//       const followUp = youCanTryPurchasingToneAgainSimplyStr;

//       // Use the combined helper so suggestions are spoken with follow-up
//       speakBotWithSuggestions(followUp, [
//         byToneNameStr,
//         byArtistStr,
//         byCategoriesStr,
//         cancelStr,
//       ]);

//       StoreManager.clearFailedBuyToneMessage();
//       StoreManager.isBuyToneFromChatbot = false;
//     }
//   }

//   /// Main sendMessage. Use `isVoice: true` when called from speech flow.
//   void sendMessage(String text, {bool isVoice = false}) async {
//     isInGreetingMode.value = false;
//     // If this call is from manual typing, make sure voice-flag is false.
//     // If isVoice==true, we keep lastMessageFromVoice true (set by start/stop),
//     // do NOT overwrite it here.
//     if (!isVoice) {
//       lastMessageFromVoice = false;
//     }

//     if (text.trim().isEmpty) return;

//     messages.add({'user': text});
//     textController.clear();

//     /// 🟡 Handle "Buy a tone" flow
//     if (text.toLowerCase().contains("buy a tone") ||
//         text.toLowerCase().contains("purchase a tone")) {
//       final botResponse = "Sure! How would you like to buy a tone?";

//       // Use helper to also speak suggestions when appropriate
//       speakBotWithSuggestions(botResponse, [
//         byToneNameStr,
//         byArtistStr,
//         byCategoriesStr,
//         cancelStr,
//       ]);
//       return;
//     }

//     /// 🟢 By Tone Name flow
//     if (text.toLowerCase() == "by tone name") {
//       buyToneMode = "tone_name";
//       const botResponse = alrightPlsTellMeTheToneNameYouWantToBuyStr;
//       messages.add({'bot': botResponse});
//       speakQueued(botResponse);
//       return;
//     }

//     /// 🔵 By Artist flow
//     if (text.toLowerCase() == "by artist") {
//       buyToneMode = "artist";
//       const botResponse =
//           gotItPleaseTellMeTheArtistNameWhoseTonesYouWantToBuyStr;

//       messages.add({'bot': botResponse});
//       speakQueued(botResponse);
//       return;
//     }

//     /// 🟣 By Categories flow (✅ fixed to close only after scroll)
//     if (text.toLowerCase() == "by categories") {
//       buyToneMode = null; // no need to keep mode active
//       const botResponse = sureTakingYouToTheTuneCategoriesYouCanExploreStr;

//       messages.add({'bot': botResponse});
//       speakQueued(botResponse);

//       // Mark that user came from chatbot
//       StoreManager.isBuyToneFromChatbot = true;

//       // Wait for bot message and voice
//       await Future.delayed(const Duration(seconds: 2));

//       final ctx = rootNavigatorKey.currentContext;
//       if (ctx == null) return;

//       final homeController = Get.find<HomeController>();
//       final currentLocation =
//           GoRouter.of(ctx).routerDelegate.currentConfiguration.fullPath ?? "";

//       // Navigate first (keep chatbot open)
//       if (currentLocation != homeRoute) {
//         GoRouter.of(ctx).go(homeRoute);
//         await Future.delayed(const Duration(seconds: 1));
//       }

//       // Scroll to tune categories
//       homeController.scrollToCategories();

//       // Wait for scroll animation to complete
//       await Future.delayed(const Duration(milliseconds: 800));

//       // ✅ Close chatbot only after reaching categories
//       chatController.closeChat();
//       return;
//     }

//     /// 🎵 Handle tone name input
//     if (buyToneMode == "tone_name") {
//       final toneName = text.trim();
//       if (toneName.isNotEmpty) {
//         final botResponse = "Searching for \"$toneName\"...";
//         messages.add({'bot': botResponse});
//         speakQueued(botResponse);

//         try {
//           final SearchResultModel model =
//               await getSearchedTuneListApi(toneName);
//           final statusCode = model.statusCode ?? "";
//           final message = model.message ?? "";
//           final tunes = model.responseMap?.toneList ?? [];

//           String botReply;
//           final ctx = rootNavigatorKey.currentContext;

//           if (statusCode != "SC0000") {
//             botReply = message.isNotEmpty
//                 ? "$message $pleaseTryExploringAnotherToneNameOrStr"
//                 : sorrySomethingWentWrongWhileFetchingTunesPleaseTryExploringStr;

//             // Speak the reply and re-show buy options
//             messages.add({'bot': botReply});
//             speakQueued(botReply);
//             speakBotWithSuggestions(
//               botReply,
//               [
//                 byToneNameStr,
//                 byArtistStr,
//                 byCategoriesStr,
//                 cancelStr,
//               ],
//             );

//             if (ctx != null) {
//               StoreManager.isBuyToneFromChatbot = true;
//               ctx.goNamed(searchRoute, queryParameters: {'search': toneName});
//             }
//           } else if (tunes.isEmpty) {
//             botReply =
//                 thereAreNoTunesAvailableForThisToneNamePleaseTryExploringStr;
//             messages.add({'bot': botReply});
//             speakQueued(botReply);
//             speakBotWithSuggestions(
//               botReply,
//               [
//                 byToneNameStr,
//                 byArtistStr,
//                 byCategoriesStr,
//                 cancelStr,
//               ],
//             );

//             if (ctx != null) {
//               StoreManager.isBuyToneFromChatbot = true;
//               ctx.goNamed(searchRoute, queryParameters: {'search': toneName});
//             }
//           } else {
//             botReply =
//                 "Here are the available tunes of $toneName. You can click the Buy button to purchase the one you like.";
//             messages.add({'bot': botReply});
//             speakQueued(botReply);

//             if (ctx != null) {
//               StoreManager.isBuyToneFromChatbot = true;
//               ctx.goNamed(searchRoute, queryParameters: {'search': toneName});
//             }

//             await Future.delayed(const Duration(seconds: 3));
//             chatController.closeChat();
//           }
//         } catch (e) {
//           const botReply =
//               sorrySomethingWentWrongWhileFetchingTunesPleaseTryAgainLaterStr;
//           messages.add({'bot': botReply});
//           speakQueued(botReply);

//           // Suggest buy options after error
//           speakBotWithSuggestions(
//             botReply,
//             [
//               byToneNameStr,
//               byArtistStr,
//               byCategoriesStr,
//               cancelStr,
//             ],
//           );

//           messages.add({'bot_suggestions': 'buy_options'});
//         }

//         buyToneMode = null;
//         return;
//       }
//     }

//     /// 🎤 Handle artist input
//     if (buyToneMode == "artist") {
//       final artistName = text.trim();
//       if (artistName.isNotEmpty) {
//         final botResponse = "Checking available tunes for $artistName...";
//         messages.add({'bot': botResponse});
//         speakQueued(botResponse);

//         try {
//           SearchResultModel apiResponse = await getArtistTuneListScApi(artistName);
//           final statusCode = apiResponse.statusCode ?? "";
//           final message = apiResponse.message ?? "";
//           final tunes = apiResponse.responseMap?.toneList ?? [];

//           String botReply;
//           final ctx = rootNavigatorKey.currentContext;

//           if (statusCode != "SC0000") {
//             botReply = message.isNotEmpty
//                 ? "$message Please try exploring another artist or searching by tone name."
//                 : "Sorry, something went wrong while fetching tunes. Please try exploring another artist or searching by tone name.";

//             messages.add({'bot': botReply});
//             speakQueued(botReply);
//             speakBotWithSuggestions(
//               botReply,
//               ["By Tone Name", "By Artist", "By Categories", "Cancel"],
//             );

//             if (ctx != null) {
//               StoreManager.isBuyToneFromChatbot = true;
//               GoRouter.of(ctx).go(
//                   '$artistTuneRoute?artistName=$artistName&fromChatbot=true');
//             }
//           } else if (tunes.isEmpty) {
//             botReply =
//                 "There are no tunes available for this artist. Please try exploring another artist or searching by tone name.";
//             messages.add({'bot': botReply});
//             speakQueued(botReply);
//             speakBotWithSuggestions(
//               botReply,
//               ["By Tone Name", "By Artist", "By Categories", "Cancel"],
//             );

//             if (ctx != null) {
//               StoreManager.isBuyToneFromChatbot = true;
//               GoRouter.of(ctx).go(
//                   '$artistTuneRoute?artistName=$artistName&fromChatbot=true');
//             }
//           } else {
//             botReply =
//                 "Here are the available tunes of $artistName. You can click the Buy button to purchase the one you like.";
//             messages.add({'bot': botReply});
//             speakQueued(botReply);

//             if (ctx != null) {
//               StoreManager.isBuyToneFromChatbot = true;
//               GoRouter.of(ctx).go(
//                   '$artistTuneRoute?artistName=$artistName&fromChatbot=true');
//             }

//             await Future.delayed(const Duration(seconds: 3));
//             chatController.closeChat();
//           }
//         } catch (e) {
//           final botReply =
//               "Sorry, something went wrong while fetching tunes. Please try again later.";
//           messages.add({'bot': botReply});
//           speakQueued(botReply);
//           speakBotWithSuggestions(
//             botReply,
//             ["By Tone Name", "By Artist", "By Categories", "Cancel"],
//           );
//           messages.add({'bot_suggestions': 'buy_options'});
//         }

//         buyToneMode = null;
//         return;
//       }
//     }

//     /// 🧠 NLP intent processing
//     final nlpResult = await extractNlp(text);
//     final intent = nlpResult['intent'] ?? 'unknown';
//     final artist = nlpResult['artist'];
//     final category = nlpResult['category'];

//     print("🎯 NLP result: intent=$intent, artist=$artist, category=$category");

//     // Show songs by artist
//     if (intent == 'show_songs_by_artist' &&
//         artist != null &&
//         artist.isNotEmpty) {
//       final botResponse =
//           "Got it! Showing you songs by $artist. Please wait a moment.";
//       messages.add({'bot': botResponse});
//       speakQueued(botResponse);

//       await Future.delayed(const Duration(seconds: 2));
//       chatController.closeChat();

//       Future.delayed(const Duration(milliseconds: 400), () {
//         final ctx = rootNavigatorKey.currentContext;
//         if (ctx != null) {
//           GoRouter.of(ctx)
//               .go('$artistTuneRoute?artistName=$artist&fromChatbot=true');
//         }
//       });
//       return;
//     }

//     // Navigate by category intent
//     if (intent == 'navigate_category' && category != null) {
//       final cat = appCont.categories.firstWhereOrNull(
//           (c) => c.categoryName?.toLowerCase() == category.toLowerCase());
//       if (cat != null) {
//         final botResponse = "Sure! Opening the ${cat.categoryName} category.";
//         messages.add({'bot': botResponse});
//         speakQueued(botResponse);
//         await Future.delayed(const Duration(seconds: 2));
//         chatController.closeChat();

//         Future.delayed(const Duration(milliseconds: 400), () {
//           final ctx = rootNavigatorKey.currentContext;
//           if (ctx != null) {
//             GoRouter.of(ctx).goNamed(categoryDetailRoute, queryParameters: {
//               'key': cat.categoryName ?? '',
//               'catId': cat.categoryId ?? '',
//             });
//           }
//         });
//         return;
//       }
//     }

//     /// Route map for simple navigation intents
//     final Map<String, String> intentToRoute = {
//       'navigate_musicbox': musicBoxRoute,
//       'navigate_home': homeRoute,
//       'navigate_profile': profileRoute,
//       'navigate_faq': faqRoute,
//       'navigate_name_tune': nameTuneRoute,
//       'navigate_my_tunes': myTunesRoute,
//       'navigate_my_wishlist': myWishlistRoute,
//     };

//     if (intentToRoute.containsKey(intent)) {
//       final routeName = intentToRoute[intent]!;
//       final screenName = routeName.replaceAll("/", "").isEmpty
//           ? "Home"
//           : routeName.replaceAll("/", "");
//       final botResponse = "Sure! Taking you to the $screenName screen.";
//       messages.add({'bot': botResponse});
//       speakQueued(botResponse);

//       await Future.delayed(const Duration(seconds: 2));
//       chatController.closeChat();

//       Future.delayed(const Duration(milliseconds: 400), () {
//         final ctx = rootNavigatorKey.currentContext;
//         if (ctx != null) {
//           GoRouter.of(ctx).go(routeName);
//         }
//       });
//       return;
//     }

//     /// Show tune categories intent
//     if (intent == 'show_tune_categories') {
//       final botResponse = "Sure! Showing you the tune categories.";
//       messages.add({'bot': botResponse});
//       speakQueued(botResponse);

//       await Future.delayed(const Duration(seconds: 2));
//       chatController.closeChat();

//       await Future.delayed(const Duration(milliseconds: 500));
//       final ctx = rootNavigatorKey.currentContext;
//       if (ctx == null) return;

//       final homeController = Get.find<HomeController>();
//       final currentLocation =
//           GoRouter.of(ctx).routerDelegate.currentConfiguration.fullPath ?? "";

//       if (currentLocation != homeRoute) {
//         chatController.closeChat();

//         await Future.delayed(const Duration(milliseconds: 400));
//         GoRouter.of(ctx).go(homeRoute);

//         await Future.delayed(const Duration(seconds: 1));
//         homeController.scrollToCategories();
//       } else {
//         homeController.scrollToCategories();
//       }
//       return;
//     }

//     /// Default fallback response
//     var botResponse =
//         iCanHelpYouBuyAToneStr;
//     messages.add({'bot': botResponse});
//     speakQueued(botResponse);
//   }

//   Future<void> speakQueued(String text) async {
//     if (!lastMessageFromVoice) return;
//     TTSService.speak(text);
//   }

//   // 🆕 Helper: add bot message + suggestion message to UI, and speak both lines
//   // when lastMessageFromVoice == true.
//   Future<void> speakBotWithSuggestions(
//       String botText, List<String> suggestions) async {
//     // UI bubbles
//     messages.add({'bot': botText});
//     messages.add({'bot_suggestions': 'buy_options'});

//     // Speak only in voice mode
//     if (lastMessageFromVoice) {
//       final combined = "$botText. ${suggestions.join(', ')}";
//       await speakQueued(combined); // 🆕 uses queue-safe TTS
//     }
//   }

//   void hideKeyboard() {
//     final context = Get.context;
//     if (context == null) return;

//     FocusScope.of(context).unfocus();
//   }

//   void _setSpeechLevel(double level) {
//     if (level.isNaN || level.isInfinite) {
//       speechLevel.value = 0;
//       return;
//     }

//     speechLevel.value = level.clamp(0.0, 1.0).toDouble();
//   }

//   void startListening() {
//     listeningActive = true;
//     lastMessageFromVoice = true;

//     // WAIT for browser to confirm start (do NOT show UI yet)
//     textController.clear();
//     isMicSessionActive.value = false;
//     isListening.value = false;
//     isTickEnabled.value = false;
//     _setSpeechLevel(0);

//     bool gotSpeechResult = false;
//     bool permissionGranted = false;

//     // Call JS synchronously - do not pre-show UI here
//     SpeechService.startListening(
//       // onFinalText
//       (finalText) {
//         if (!listeningActive) return;

//         gotSpeechResult = true;
//         textController.text = finalText;

//         // stop waves (listener ended)
//         isListening.value = false;
//         _setSpeechLevel(0);

//         // enable tick only if text exists
//         isTickEnabled.value = finalText.trim().isNotEmpty;

//         // ensure mic UI stays visible (if it was shown)
//         isMicSessionActive.value = true;
//       },

//       // onStopped (silence / denied / ended)
//       (status) {
//         if (!listeningActive) return;

//         // If permission never granted → reset (denied or user closed)
//         if (!permissionGranted) {
//           listeningActive = false;
//           isListening.value = false;
//           isMicSessionActive.value = false;
//           isTickEnabled.value = false;
//           _setSpeechLevel(0);
//           textController.clear();
//           return;
//         }

//         // Permission granted but user stayed silent → act like cancel
//         if (!gotSpeechResult) {
//           listeningActive = false;
//           isListening.value = false;
//           isMicSessionActive.value = false;
//           isTickEnabled.value = false;
//           _setSpeechLevel(0);
//           textController.clear();
//           return;
//         }

//         // If gotSpeechResult == true, do nothing (user spoke, UI already shows)
//       },

//       // onStarted (permission granted / actual listening started)
//       (started) {
//         if (!listeningActive) return;

//         permissionGranted = true;

//         // Now show waveforms + tick/cross
//         isListening.value = true;
//         isMicSessionActive.value = true;
//         isTickEnabled.value = false;
//         _setSpeechLevel(0);
//       },

//       // onLevel
//       (level) {
//         if (!listeningActive || !isListening.value) {
//           _setSpeechLevel(0);
//           return;
//         }

//         _setSpeechLevel(level);
//       },
//     );
//   }

//   void stopAndSend() async {
//     listeningActive = false;
//     isListening.value = false;
//     isMicSessionActive.value = false; //close mic session
//     lastMessageFromVoice = true; // 🆕 Final confirmation of voice message
//     isTickEnabled.value = false;
//     // 🔥 Always send the CURRENT text inside the TextField (edited or not)
//     _setSpeechLevel(0);
//     final textToSend = textController.text.trim();

//     if (textToSend.isNotEmpty) {
//       sendMessage(textToSend, isVoice: true);
//       hideKeyboard();
//     }

//     // _lastFinalSpeech = "";
//     textController.clear();
//   }

//   void cancelListening() async {
//     listeningActive = false;
//     isListening.value = false;
//     isMicSessionActive.value = false; // close mic session
//     isTickEnabled.value = false;
//     _setSpeechLevel(0);
//     textController.clear();
//     await SpeechService.stopListening();
//   }

//   @override
//   void onClose() {
//     textController.dispose();
//     speechLevel.dispose();
//     botSpeechLevel.dispose();
//     scrollHelper.dispose();
//     super.onClose();
//   }
// }



