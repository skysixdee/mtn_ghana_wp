import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;
  const VideoPlayerWidget({super.key, required this.videoPath});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController controller;

  bool isPaused = false;
  bool isEnded = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.asset(
      widget.videoPath,
    )..initialize().then((_) {
        if (!mounted) return;

        setState(() {
          isLoading = false;
        });

        controller.play();
        controller.setLooping(false);

        controller.addListener(() {
          final pos = controller.value.position;
          final dur = controller.value.duration;
          if (controller.value.isInitialized &&
              !controller.value.isPlaying &&
              pos >= dur &&
              !isEnded) {
            setState(() => isEnded = true);
          }
        });
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void togglePlayPause() {
    if (isEnded) return;

    if (controller.value.isPlaying) {
      controller.pause();
      setState(() => isPaused = true);
    } else {
      controller.play();
      setState(() => isPaused = false);
    }
  }

  void replay() async {
    setState(() {
      isEnded = false;
      isLoading = true;
    });

    await controller.seekTo(Duration.zero);
    await controller.play();

    setState(() {
      isLoading = false;
      isPaused = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // ---- VIDEO (does NOT receive pointer events) ----
        controller.value.isInitialized
            ? IgnorePointer(
                ignoring: false,
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
              )
            : const Center(
                child: CupertinoActivityIndicator(radius: 16),
              ),

        // ---- FULL-AREA TAP OVERLAY FOR PLAY/PAUSE ----
        if (!isEnded)
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: togglePlayPause,
              child: const SizedBox.expand(),
            ),
          ),

        // ---- PAUSE ICON ----
        if (isPaused && !isEnded)
          InkWell(
            onTap:togglePlayPause,
            child: const Icon(
              Icons.play_circle_filled,
              color: Colors.white,
              size: 60,
            ),
          ),

        // ---- REPLAY ICON ----
        if (isEnded)
          InkWell(
            //behavior: HitTestBehavior.opaque,
            onTap: replay,
            child: const Icon(
              Icons.replay_circle_filled,
              color: Colors.white,
              size: 60,
            ),
          ),

        // ---- LOADING OVERLAY ----
        if (isLoading)
          Container(
            color: Colors.black26,
            child: const Center(
              child: CupertinoActivityIndicator(radius: 16),
            ),
          ),
      ],
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerWidget extends StatefulWidget {
//   final String videoPath;
//   const VideoPlayerWidget({super.key, required this.videoPath});

//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController controller;

//   bool isPaused = false;
//   bool isEnded = false;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();

//     controller = VideoPlayerController.asset(
//       widget.videoPath,
//     )..initialize().then((_) {
//         if (!mounted) return;

//         setState(() {
//           isLoading = false;
//         });

//         controller.play();
//         controller.setLooping(false);

//         controller.addListener(() {
//           final pos = controller.value.position;
//           final dur = controller.value.duration;

//           if (controller.value.isInitialized &&
//               !controller.value.isPlaying &&
//               pos >= dur &&
//               !isEnded) {
//             setState(() => isEnded = true);
//           }
//         });
//       });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   void togglePlayPause() {
//     if (isEnded) return;

//     if (controller.value.isPlaying) {
//       controller.pause();
//       setState(() => isPaused = true);
//     } else {
//       controller.play();
//       setState(() => isPaused = false);
//     }
//   }

//   void replay() async {
//     setState(() {
//       isEnded = false;
//       isLoading = true;
//     });

//     await controller.seekTo(Duration.zero);
//     await controller.play();

//     setState(() {
//       isLoading = false;
//       isPaused = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       onTap: () {
//         if (isEnded) return;
//         togglePlayPause();
//       },
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           controller.value.isInitialized
//               ? AspectRatio(
//                   aspectRatio: controller.value.aspectRatio,
//                   child: VideoPlayer(controller),
//                 )
//               : const Center(
//                   child: CupertinoActivityIndicator(radius: 16),
//                 ),

//           // PAUSE ICON
//           if (isPaused && !isEnded)
//             const AnimatedOpacity(
//               duration: Duration(milliseconds: 200),
//               opacity: 1,
//               child: Icon(
//                 Icons.pause_circle_filled,
//                 color: Colors.white,
//                 size: 60,
//               ),
//             ),

//           // REPLAY ICON
//           if (isEnded)
//             GestureDetector(
//               behavior: HitTestBehavior.opaque,
//               onTap: replay,
//               child: const Icon(
//                 Icons.replay_circle_filled,
//                 color: Colors.white,
//                 size: 70,
//               ),
//             ),

//           // LOADING OVERLAY
//           if (isLoading)
//             Container(
//               color: Colors.black26,
//               child: const Center(
//                 child: CupertinoActivityIndicator(radius: 16),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }









// import 'package:flutter/cupertino.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerWidget extends StatefulWidget {
//   final String videoPath;
//   const VideoPlayerWidget({super.key, required this.videoPath});

//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController controller;

//   @override
//   void initState() {
//     super.initState();

//     // IMPORTANT: use networkUrl for Flutter Web assets
//     controller = VideoPlayerController.networkUrl(
//       Uri.parse(widget.videoPath),
//     )..initialize().then((_) {
//         if (mounted) {
//           setState(() {});
//           controller.setLooping(true);
//           controller.play();
//         }
//       });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return controller.value.isInitialized
//         ? AspectRatio(
//             aspectRatio: controller.value.aspectRatio,
//             child: VideoPlayer(controller),
//           )
//         : const Center(child: CupertinoActivityIndicator());
//   }
// }
