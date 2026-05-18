import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mtn_ghana_wp/files/api_calls/get_artist_tunes_list_api.dart';
import 'package:mtn_ghana_wp/files/api_calls/get_search_tune_list_api.dart';
import 'package:mtn_ghana_wp/files/chat_bot/controllers/chat_controller.dart';
import 'package:mtn_ghana_wp/files/chat_bot/helpers/chat_bot_scroll_helper.dart';
import 'package:mtn_ghana_wp/files/chat_bot/services/speech_service.dart';
import 'package:mtn_ghana_wp/files/chat_bot/services/tts_service.dart';
import 'package:mtn_ghana_wp/files/controllers/home_controllers/home_controller.dart';
import 'package:mtn_ghana_wp/files/model/artist_tune_list_model.dart';
import 'package:mtn_ghana_wp/files/model/search_result_model.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/router/router.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';

part 'chat_nlp_handler.dart';

class AiAgentController extends GetxController with ChatNlpHandler {
  bool gotSpeechResult = false;
  final chatController = Get.find<ChatController>();
  final textController = TextEditingController();
  final ValueNotifier<double> speechLevel = ValueNotifier<double>(0);
  final ValueNotifier<double> botSpeechLevel = ValueNotifier<double>(0);
  final isMicSessionActive = false.obs;
  final isBotSpeaking = false.obs;
  final isTickEnabled = false.obs;
  final ChatScrollHelper scrollHelper = ChatScrollHelper();

  final isShowingHelpVideo = false.obs;
  final isInGreetingMode = true.obs;

  final messages = <Map<String, String>>[].obs;
  final isListening = false.obs;
  final isTyping = false.obs;
  List<TuneInfo> tuneList = <TuneInfo>[].obs;
  bool listeningActive = false;
  String? buyToneMode;
  bool lastMessageFromVoice = false;

  @override
  void onInit() {
    super.onInit();
    SpeechService.initSpeech();
    TTSService.initTTS(
      onStart: () {
        isBotSpeaking.value = true;
        botSpeechLevel.value = 0.6;
      },
      onComplete: () {
        isBotSpeaking.value = false;
        botSpeechLevel.value = 0;
      },
      onCancel: () {
        isBotSpeaking.value = false;
        botSpeechLevel.value = 0;
      },
      onError: () {
        isBotSpeaking.value = false;
        botSpeechLevel.value = 0;
      },
    );
    ever(messages, (_) => scrollHelper.scheduleJumpToLatest());
    ever<bool>(isTyping, (typing) {
      if (typing) {
        scrollHelper.scheduleJumpToLatest();
      }
    });
  }

  void checkForFailedBuyToneMessage() {
    final failedMessage = StoreManager.getFailedBuyToneMessage();
    if (failedMessage != null && failedMessage.isNotEmpty) {
      _addBotFailedMessage(failedMessage);
      speakQueued(failedMessage);
      const followUp = youCanTryPurchasingToneAgainSimplyStr;
      speakBotWithSuggestions(followUp, [
        byToneNameStr,
        byArtistStr,
        byCategoriesStr,
        cancelStr,
      ]);
      StoreManager.clearFailedBuyToneMessage();
      StoreManager.isBuyToneFromChatbot = false;
    }
  }

  void _stopTyping() {
    if (isTyping.value) {
      isTyping.value = false;
    }
  }

  void _addBotMessage(String text) {
    _stopTyping();
    messages.add({'bot': text});
  }

  void _addBotFailedMessage(String text) {
    _stopTyping();
    messages.add({'bot_failed': text});
  }

  void _addBotSuggestions(String key) {
    _stopTyping();
    messages.add({'bot_suggestions': key});
  }

  void sendMessage(String text, {bool isVoice = false}) async {
    isInGreetingMode.value = false;
    if (!isVoice) lastMessageFromVoice = false;
    if (text.trim().isEmpty) return;

    messages.add({'user': text});
    textController.clear();

    // ─────────────────────────────────────────────────────────────────
    // STEP 1: Chip/button tap responses (exact fixed strings)
    // These are sent programmatically when user taps a suggestion chip.
    // They are NOT free-form user input so NLP is not needed here.
    // ─────────────────────────────────────────────────────────────────

    if (text.toLowerCase() == "by tone name") {
      buyToneMode = "tone_name";
      const botResponse = alrightPlsTellMeTheToneNameYouWantToBuyStr;
      _addBotMessage(botResponse);
      speakQueued(botResponse);
      return;
    }

    if (text.toLowerCase() == "by artist") {
      buyToneMode = "artist";
      const botResponse =
          gotItPleaseTellMeTheArtistNameWhoseTonesYouWantToBuyStr;
      _addBotMessage(botResponse);
      speakQueued(botResponse);
      return;
    }

    if (text.toLowerCase() == "by categories") {
      buyToneMode = null;
      const botResponse = sureTakingYouToTheTuneCategoriesYouCanExploreStr;
      _addBotMessage(botResponse);
      speakQueued(botResponse);
      StoreManager.isBuyToneFromChatbot = true;
      await Future.delayed(const Duration(seconds: 2));
      final homeController = Get.find<HomeController>();
      final currentLocation =
          router.routerDelegate.currentConfiguration.fullPath;
      if (currentLocation != homeRoute) {
        router.go(homeRoute);
        await Future.delayed(const Duration(seconds: 1));
      }
      await homeController.scrollToCategories();
      chatController.closeChat();
      return;
    }

    // ─────────────────────────────────────────────────────────────────
    // STEP 2: Active buyToneMode — user is mid-flow entering a name
    // If buyToneMode is active, the user's message is a raw tone/artist
    // name, not an intent. Skip NLP and go straight to the API.
    // ─────────────────────────────────────────────────────────────────

    if (buyToneMode == "tone_name") {
      final toneName = text.trim();
      if (toneName.isNotEmpty) {
        final botResponse = "Searching for \"$toneName\"...";
        _addBotMessage(botResponse);
        speakQueued(botResponse);
        try {
          final SearchResultModel model =
              await getSearchedTuneListApi(toneName);
          final statusCode = model.statusCode ?? "";
          final message = model.message ?? "";
          final tunes = model.responseMap?.toneList ?? [];
          String botReply;
          final ctx = rootNavigatorKey.currentContext;
          if (statusCode != "SC0000") {
            botReply = message.isNotEmpty
                ? "$message $pleaseTryExploringAnotherToneNameOrStr"
                : sorrySomethingWentWrongWhileFetchingTunesPleaseTryExploringStr;
            speakQueued(botReply);
            speakBotWithSuggestions(botReply, [
              byToneNameStr,
              byArtistStr,
              byCategoriesStr,
              cancelStr,
            ]);
            if (ctx != null) {
              StoreManager.isBuyToneFromChatbot = true;
              ctx.goNamed(searchRoute, queryParameters: {'search': toneName});
            }
          } else if (tunes.isEmpty) {
            botReply =
                thereAreNoTunesAvailableForThisToneNamePleaseTryExploringStr;
            speakQueued(botReply);
            speakBotWithSuggestions(botReply, [
              byToneNameStr,
              byArtistStr,
              byCategoriesStr,
              cancelStr,
            ]);
            if (ctx != null) {
              StoreManager.isBuyToneFromChatbot = true;
              ctx.goNamed(searchRoute, queryParameters: {'search': toneName});
            }
          } else {
            botReply =
                "Here are the available tunes of $toneName. You can click the Buy button to purchase the one you like.";
            _addBotMessage(botReply);
            speakQueued(botReply);
            if (ctx != null) {
              StoreManager.isBuyToneFromChatbot = true;
              ctx.goNamed(searchRoute, queryParameters: {'search': toneName});
            }
            await Future.delayed(const Duration(seconds: 3));
            chatController.closeChat();
          }
        } catch (e) {
          const botReply =
              sorrySomethingWentWrongWhileFetchingTunesPleaseTryAgainLaterStr;
          _addBotMessage(botReply);
          speakQueued(botReply);
          speakBotWithSuggestions(botReply, [
            byToneNameStr,
            byArtistStr,
            byCategoriesStr,
            cancelStr,
          ]);
        }
        buyToneMode = null;
        return;
      }
    }

    if (buyToneMode == "artist") {
      final artistName = text.trim();
      if (artistName.isNotEmpty) {
        final botResponse = "Checking available tunes for $artistName....";
        _addBotMessage(botResponse);
        speakQueued(botResponse);
        try {
          SearchResultModel apiResponse =
              await getArtistTuneListScApi(artistName);
          final statusCode = apiResponse.statusCode ?? "";
          final message = apiResponse.message ?? "";
          final tunes = apiResponse.responseMap?.toneList ?? [];
          String botReply;
          final ctx = rootNavigatorKey.currentContext;
          if (statusCode != "SC0000") {
            botReply = message.isNotEmpty
                ? "$message Please try exploring another artist or searching by tone name."
                : "Sorry, something went wrong while fetching tunes. Please try exploring another artist or searching by tone name.";
            speakQueued(botReply);
            speakBotWithSuggestions(botReply,
                ["By Tone Name", "By Artist", "By Categories", "Cancel"]);
            if (ctx != null) {
              StoreManager.isBuyToneFromChatbot = true;
              GoRouter.of(ctx).go(
                  '$artistTuneRoute?artistName=$artistName&fromChatbot=true');
            }
          } else if (tunes.isEmpty) {
            botReply =
                "There are no tunes available for this artist. Please try exploring another artist or searching by tone name.";
            speakQueued(botReply);
            speakBotWithSuggestions(botReply,
                ["By Tone Name", "By Artist", "By Categories", "Cancel"]);
            if (ctx != null) {
              StoreManager.isBuyToneFromChatbot = true;
              GoRouter.of(ctx).go(
                  '$artistTuneRoute?artistName=$artistName&fromChatbot=true');
            }
          } else {
            botReply =
                "Here are the available tunes of $artistName. You can click the Buy button to purchase the one you like.";
            _addBotMessage(botReply);
            speakQueued(botReply);
            if (ctx != null) {
              StoreManager.isBuyToneFromChatbot = true;
              GoRouter.of(ctx).go(
                  '$artistTuneRoute?artistName=$artistName&fromChatbot=true');
            }
            await Future.delayed(const Duration(seconds: 3));
            chatController.closeChat();
          }
        } catch (e) {
          final botReply =
              "Sorry, something went wrong while fetching tunes. Please try again later.";
          _addBotMessage(botReply);
          speakQueued(botReply);
          speakBotWithSuggestions(botReply,
              ["By Tone Name", "By Artist", "By Categories", "Cancel"]);
        }
        buyToneMode = null;
        return;
      }
    }

    // ─────────────────────────────────────────────────────────────────
    // STEP 3: Free-form user input → Rasa NLP intent detection
    // All natural language messages reach here. Rasa returns intent
    // and entities. Each intent maps to a specific chatbot action.
    // ─────────────────────────────────────────────────────────────────

    isTyping.value = true;
    try {
      final nlpResult = await extractNlp(text);
      final intent = nlpResult['intent'] ?? 'unknown';
      final artist = nlpResult['artist'];

      print("🎯 NLP result: intent=$intent, artist=$artist");

      // ── Network / Server Errors ──
      if (intent == 'no_internet') {
        const botResponse =itLooksLikeYouAreOfflineStr;
            
        _addBotMessage(botResponse);
        speakQueued(botResponse);
        return;
      }

      if (intent == 'server_error') {
        const botResponse =
            sorryIamUnableToReachTheServerRightNowStr;
        _addBotMessage(botResponse);
        speakQueued(botResponse);
        return;
      }

      // ── KB Answer ── (NEW BLOCK — add this)
      if (intent == 'kb_answer') {
        final answer =
            nlpResult['kb_answer'] as String? ?? iCanHelpYouBuyAToneStr;
        _addBotMessage(answer);
        speakQueued(answer);
        return;
      }

      // ── Greeting ──
      if (intent == 'greet') {
        const botResponse =
            "Hello! 👋 I'm your CallerTune Assistant. I can help you buy a tone, explore artists or categories, and navigate to any section. How can I help you today?";
        _addBotMessage(botResponse);
        speakQueued(botResponse);
        return;
      }

      // ── Bye ──
      if (intent == 'bye') {
        const botResponse =
            "Goodbye! 👋 Feel free to come back anytime if you need help with your caller tunes!";
        _addBotMessage(botResponse);
        speakQueued(botResponse);
        await Future.delayed(const Duration(seconds: 2));
        chatController.closeChat();
        return;
      }

      // ── Buy tone ──
      if (intent == 'buy_tone') {
        const botResponse = "Sure! How would you like to buy a tone?";
        speakBotWithSuggestions(botResponse, [
          byToneNameStr,
          byArtistStr,
          byCategoriesStr,
          cancelStr,
        ]);
        return;
      }

      // ── Show songs by artist ──
      if (intent == 'show_songs_by_artist' &&
          artist != null &&
          artist.isNotEmpty) {
        final botResponse =
            "Got it! Showing you songs by $artist. Please wait a moment.";
        _addBotMessage(botResponse);
        speakQueued(botResponse);
        await Future.delayed(const Duration(seconds: 2));
        chatController.closeChat();
        Future.delayed(const Duration(milliseconds: 400), () {
          final ctx = rootNavigatorKey.currentContext;
          if (ctx != null) {
            GoRouter.of(ctx)
                .go('$artistTuneRoute?artistName=$artist&fromChatbot=true');
          }
        });
        return;
      }

      // ── Simple screen navigation intents ──
      final Map<String, String> intentToRoute = {
        'navigate_musicbox': musicBoxRoute,
        'navigate_home': homeRoute,
        'navigate_profile': profileRoute,
        'navigate_faq': faqRoute,
        'navigate_name_tune': nameTuneRoute,
        'navigate_my_tunes': myTunesRoute,
        'navigate_my_wishlist': myWishlistRoute,
        // 'navigate_notifications': notificationsRoute,
      };

      if (intentToRoute.containsKey(intent)) {
        final routeName = intentToRoute[intent]!;
        final screenName = routeName.replaceAll("/", "").isEmpty
            ? "Home"
            : routeName.replaceAll("/", "");
        final botResponse = "Sure! Taking you to the $screenName screen.";
        _addBotMessage(botResponse);
        speakQueued(botResponse);
        await Future.delayed(const Duration(seconds: 2));
        chatController.closeChat();
        Future.delayed(const Duration(milliseconds: 400), () {
          final ctx = rootNavigatorKey.currentContext;
          if (ctx != null) {
            GoRouter.of(ctx).go(routeName);
          }
        });
        return;
      }

      // ── Show tune categories ──
      if (intent == 'show_tune_categories') {
        const botResponse = sureShowingYouTheTuneCategoriesStr;
        _addBotMessage(botResponse);
        speakQueued(botResponse);
        await Future.delayed(const Duration(seconds: 2));
        chatController.closeChat();
        await Future.delayed(const Duration(milliseconds: 500));
        final homeController = Get.find<HomeController>();
        final currentLocation =
            router.routerDelegate.currentConfiguration.fullPath;
        if (currentLocation != homeRoute) {
          await Future.delayed(const Duration(milliseconds: 400));
          router.go(homeRoute);
          await Future.delayed(const Duration(seconds: 1));
          await homeController.scrollToCategories();
        } else {
          await homeController.scrollToCategories();
        }
        return;
      }

      // ── Default fallback ──
      var botResponse = iCanHelpYouBuyAToneStr;
      _addBotMessage(botResponse);
      speakQueued(botResponse);
    } finally {
      _stopTyping();
    }
  }

  Future<void> speakQueued(String text) async {
    if (!lastMessageFromVoice) return;
    TTSService.speak(text);
  }

  Future<void> speakBotWithSuggestions(
      String botText, List<String> suggestions) async {
    _addBotMessage(botText);
    _addBotSuggestions('buy_options');
    if (lastMessageFromVoice) {
      final combined = "$botText. ${suggestions.join(', ')}";
      await speakQueued(combined);
    }
  }

  void hideKeyboard() {
    final context = Get.context;
    if (context == null) return;
    FocusScope.of(context).unfocus();
  }

  void _setSpeechLevel(double level) {
    if (level.isNaN || level.isInfinite) {
      speechLevel.value = 0;
      return;
    }
    speechLevel.value = level.clamp(0.0, 1.0).toDouble();
  }

  void startListening() {
    listeningActive = true;
    lastMessageFromVoice = true;
    textController.clear();
    isMicSessionActive.value = false;
    isListening.value = false;
    isTickEnabled.value = false;
    _setSpeechLevel(0);

    bool gotSpeechResult = false;
    bool permissionGranted = false;

    SpeechService.startListening(
      (finalText) {
        if (!listeningActive) return;
        gotSpeechResult = true;
        textController.text = finalText;
        isListening.value = false;
        _setSpeechLevel(0);
        isTickEnabled.value = finalText.trim().isNotEmpty;
        isMicSessionActive.value = true;
      },
      (status) {
        if (!listeningActive) return;
        if (!permissionGranted) {
          listeningActive = false;
          isListening.value = false;
          isMicSessionActive.value = false;
          isTickEnabled.value = false;
          _setSpeechLevel(0);
          textController.clear();
          return;
        }
        if (!gotSpeechResult) {
          listeningActive = false;
          isListening.value = false;
          isMicSessionActive.value = false;
          isTickEnabled.value = false;
          _setSpeechLevel(0);
          textController.clear();
          return;
        }
      },
      (started) {
        if (!listeningActive) return;
        permissionGranted = true;
        isListening.value = true;
        isMicSessionActive.value = true;
        isTickEnabled.value = false;
        _setSpeechLevel(0);
      },
      (level) {
        if (!listeningActive || !isListening.value) {
          _setSpeechLevel(0);
          return;
        }
        _setSpeechLevel(level);
      },
    );
  }

  void stopAndSend() async {
    listeningActive = false;
    isListening.value = false;
    isMicSessionActive.value = false;
    lastMessageFromVoice = true;
    isTickEnabled.value = false;
    _setSpeechLevel(0);
    final textToSend = textController.text.trim();
    if (textToSend.isNotEmpty) {
      sendMessage(textToSend, isVoice: true);
      hideKeyboard();
    }
    textController.clear();
  }

  void cancelListening() async {
    listeningActive = false;
    isListening.value = false;
    isMicSessionActive.value = false;
    isTickEnabled.value = false;
    _setSpeechLevel(0);
    textController.clear();
    await SpeechService.stopListening();
  }

  @override
  void onClose() {
    textController.dispose();
    speechLevel.dispose();
    botSpeechLevel.dispose();
    scrollHelper.dispose();
    super.onClose();
  }
}
