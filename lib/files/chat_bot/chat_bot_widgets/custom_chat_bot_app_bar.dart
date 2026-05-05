  import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/chat_bot/controllers/ai_agent_controller.dart';
import 'package:mtn_ghana_wp/files/chat_bot/controllers/chat_controller.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';


Widget customChatbotAppBar(AiAgentController c, ChatController chatController) {
    return Container(
                height: 50,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // HELP + VIDEO BUTTON
                    IconButton(
                      onPressed: () {
                        c.hideKeyboard();
                        c.isShowingHelpVideo.value = true;
                      },
                      icon: Semantics(
                        label: helpStr,
                        button: true,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey[850],
                                shape: BoxShape.circle,
                                border: Border.all(color: yellow, width: 1),
                              ),
                              child: const Center(
                                child: Icon(Icons.help_outline,
                                    color: yellow, size: 22),
                              ),
                            ),
                            Positioned(
                              right: -2,
                              top: -2,
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: yellow,
                                ),
                                child: const Center(
                                  child: Icon(Icons.play_arrow,
                                      size: 12, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // CLEAR CHAT
                    IconButton(
                      onPressed: () {
                        c.isInGreetingMode.value=true;
                        if (c.messages.isNotEmpty) {
                          c.messages.clear();
                          c.isInGreetingMode.value=true;
                          c.scrollHelper.scheduleJumpToLatest();
                        }
                        c.hideKeyboard();
                      },
                      icon: Semantics(
                        label: clearChatStr,
                        button: true,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[850],
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white24, width: 1),
                          ),
                          child: const Center(
                            child: Icon(Icons.delete_outline,
                                color: Colors.white, size: 22),
                          ),
                        ),
                      ),
                    ),

                    // CLOSE CHAT
                    IconButton(
                      onPressed: (){
                        chatController.closeChat();
                        c.hideKeyboard();
                      },
                      icon: Semantics(
                        label: closeStr,
                        button: true,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[850],
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white24, width: 1),
                          ),
                          child: const Center(
                            child: Icon(Icons.close,
                                color: Colors.white, size: 22),
                          ),
                        ),
                      ),
                    ),

                    
                  ],
                ),
              );
  }
