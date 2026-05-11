import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';


Widget initialGreetings() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,   
      children: [
        Text(
          helloThereStr,
          textAlign: TextAlign.center,                 
          style: TextStyle(
            color: yellow,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          iamAiAgentYourCallerTuneAssistantStr,
          textAlign: TextAlign.center,                 
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 2),
        Text(
          youCanSearchTonesBrowseArtistStr,
          textAlign: TextAlign.center,                
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
        Text(
          howCanIHelpYouTodayStr,
          textAlign: TextAlign.center,                 
          style: TextStyle(
            color: yellow,
            fontSize: 18,
          ),
        ),
      ],
    ),
  );
}
