import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/player_view/new_player_controller.dart';
import 'package:mtn_ghana_wp/files/player_view/maximized_player_view.dart';
import 'package:mtn_ghana_wp/files/player_view/minimized_player_view.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({super.key});

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  PlayerController playerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return _playerView(context, playerController);
  }

  Widget _playerView(BuildContext context, PlayerController playerController) {
    return Obx(
      () {
        return Visibility(
          visible: playerController.isPlayerVisible.value,
          child: Column(
            children: [
              Flexible(
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration:
                          Duration(milliseconds: 400), // Animation duration
                      curve: Curves.easeInOut, // Animation curve
                      left: 0,
                      right: 0,
                      bottom: playerController
                              .isPlayerMaxSize.value //_isViewVisible
                          ? 0
                          : -MediaQuery.of(context).size.height,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height -
                            (webNavHeight + minPlayerHeight) -
                            7,
                        child: MaximizedPlayerView(),
                      ),
                    ),
                  ],
                ),
              ),
              MinimizedPlayerView(),
            ],
          ),
        );
      },
    );
  }
}
