import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/buttons/generic_button.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:mtn_ghana_wp/main.dart';

// ── Mood data ─────────────────────────────────────────────────────────────────
class _Mood {
  final String label;
  final String emoji;
  final Color primary;
  final Color light;
  final Color dark;

  const _Mood(this.label, this.emoji, this.primary, this.light, this.dark);
}

const _moods = [
  _Mood(
      'Neutral', '😐', Color(0xFF888780), Color(0xFFB4B2A9), Color(0xFF5F5E5A)),
  _Mood('Happy', '😄', Color(0xFFEF9F27), Color(0xFFFAC775), Color(0xFFBA7517)),
  _Mood('Sad', '😢', Color(0xFF378ADD), Color(0xFF85B7EB), Color(0xFF185FA5)),
  _Mood('Angry', '😠', Color(0xFFE24B4A), Color(0xFFF09595), Color(0xFFA32D2D)),
  _Mood(
      'Fearful', '😨', Color(0xFF7F77DD), Color(0xFFAFA9EC), Color(0xFF534AB7)),
  _Mood('Disgusted', '🤢', Color(0xFF639922), Color(0xFF97C459),
      Color(0xFF3B6D11)),
  _Mood('Surprised', '😲', Color(0xFFD4537E), Color(0xFFED93B1),
      Color(0xFF993556)),
  _Mood(
      'Relaxed', '😌', Color(0xFF1D9E75), Color(0xFF5DCAA5), Color(0xFF0F6E56)),
  _Mood('Relieved', '😅', Color(0xFF639922), Color(0xFFC0DD97),
      Color(0xFF97C459)),
  _Mood('Screaming', '😱', Color(0xFFD85A30), Color(0xFFF0997B),
      Color(0xFF993C1D)),
];

// ── Waveform bar config ───────────────────────────────────────────────────────
const _barCount = 6;
const _barMinHeights = [3.0, 5.0, 3.0, 4.0, 3.0, 4.0];
const _barMaxHeights = [13.0, 11.0, 15.0, 10.0, 14.0, 12.0];
const _barDurations = [1100, 900, 1300, 800, 1200, 1000];
const _barDelays = [0, 120, 60, 180, 90, 150];

// ── Public widget ─────────────────────────────────────────────────────────────
/// 200 × 70 badge. Place in an AppBar action or Stack.
class AiMoodTunesBadge extends StatefulWidget {
  final VoidCallback? onTap;
  const AiMoodTunesBadge({super.key, this.onTap});

  @override
  State<AiMoodTunesBadge> createState() => _AiMoodTunesBadgeState();
}

class _AiMoodTunesBadgeState extends State<AiMoodTunesBadge>
    with TickerProviderStateMixin {
  int _index = 0;

  // Pulse rings
  late final AnimationController _pulse1Ctrl;
  late final AnimationController _pulse2Ctrl;

  // Waveform bars
  late final List<AnimationController> _barCtrls;
  late final List<Animation<double>> _barAnims;

  // Mood label fade + slide
  late final AnimationController _textCtrl;
  late final Animation<double> _textOpacity;
  late final Animation<Offset> _textSlide;

  Timer? _cycleTimer;

  @override
  void initState() {
    super.initState();

    // Pulse rings (staggered by half period)
    _pulse1Ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2200))
      ..repeat();
    _pulse2Ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2200));
    Future.delayed(const Duration(milliseconds: 1100), () {
      if (mounted) _pulse2Ctrl.repeat();
    });

    // Waveform bars
    _barCtrls = List.generate(
      _barCount,
      (i) => AnimationController(
          vsync: this, duration: Duration(milliseconds: _barDurations[i])),
    );
    _barAnims = List.generate(
      _barCount,
      (i) => Tween(begin: _barMinHeights[i], end: _barMaxHeights[i]).animate(
        CurvedAnimation(parent: _barCtrls[i], curve: Curves.easeInOut),
      ),
    );
    for (int i = 0; i < _barCount; i++) {
      Future.delayed(Duration(milliseconds: _barDelays[i]), () {
        if (mounted) _barCtrls[i].repeat(reverse: true);
      });
    }

    // Mood text
    _textCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _textOpacity = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));
    _textSlide = Tween(begin: const Offset(0, 0.6), end: Offset.zero)
        .animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));
    _textCtrl.forward();

    // Cycle every 2 s
    _cycleTimer =
        Timer.periodic(const Duration(seconds: 2), (_) => _nextMood());
  }

  Future<void> _nextMood() async {
    await _textCtrl.reverse();
    if (!mounted) return;
    setState(() => _index = (_index + 1) % _moods.length);
    _textCtrl.forward(from: 0);
  }

  @override
  void dispose() {
    _cycleTimer?.cancel();
    _pulse1Ctrl.dispose();
    _pulse2Ctrl.dispose();
    for (final c in _barCtrls) c.dispose();
    _textCtrl.dispose();
    super.dispose();
  }

  _Mood get _mood => _moods[_index];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation:
          Listenable.merge([_pulse1Ctrl, _pulse2Ctrl, _textCtrl, ..._barCtrls]),
      builder: (context, _) {
        final mood = _mood;
        return GestureDetector(
          onTap: widget.onTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // ── Pulse rings ──────────────────────────────────────────────
              // _PulseRing(controller: _pulse1Ctrl, color: mood.primary),
              // _PulseRing(controller: _pulse2Ctrl, color: mood.primary),

              // ── Badge body ───────────────────────────────────────────────
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0f0d1e),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)), //circular(8),
                  border:
                      Border.all(color: const Color(0xFF3C3489), width: 0.5),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Emoji
                    FadeTransition(
                        opacity: _textOpacity,
                        child: CustomText(
                          isSelectable: false,
                          title: mood.emoji,
                          fontSize: 20,
                        )),

                    const SizedBox(width: 8),

                    // Centre column
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // AI label row
                          Row(mainAxisSize: MainAxisSize.min, children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Color(0xFF5DCAA5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5),
                            CustomText(
                              isSelectable: false,
                              title: moodDetectStr, //aiMoodPickerStr,
                              fontSize: 10,
                              color: Color(0xFF9FE1CB),
                              fontName: FontName.semiBold,
                            )
                          ]),

                          const SizedBox(height: 3),

                          // Mood label
                          SizedBox(
                            height: 18,
                            child: FadeTransition(
                              opacity: _textOpacity,
                              child: SlideTransition(
                                  position: _textSlide,
                                  child: CustomText(
                                    isSelectable: false,
                                    title: mood.label,
                                    fontSize: 14,
                                    fontName: FontName.semiBold,
                                    color: mood.light,
                                  )),
                            ),
                          ),

                          const SizedBox(height: 4),

                          // Waveform
                          SizedBox(
                            height: 8,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: List.generate(_barCount, (i) {
                                final colors = [
                                  mood.primary,
                                  mood.light,
                                  mood.dark
                                ];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 2),
                                  child: Container(
                                    width: 4,
                                    height: _barAnims[i].value,
                                    decoration: BoxDecoration(
                                      color: colors[i % 3],
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(2)),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 6),

                    // CTA column
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            CustomText(
                              isSelectable: false,
                              title: playYourMoodStr,
                              fontName: FontName.regular,
                              fontSize: 10,
                              color: Color(0xFF888780),
                            ),
                            GenericButton(
                              leadingIcon: Icon(
                                Icons.close,
                                size: 20,
                                color: white,
                              ),
                              bgColor: transparent,
                              padding: EdgeInsets.all(0),
                              onTap: () =>
                                  appCont.isShowHomePopBanner.value = false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Pulse ring ────────────────────────────────────────────────────────────────
class _PulseRing extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  const _PulseRing({required this.controller, required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        final t = controller.value;
        return Positioned.fill(
          child: Opacity(
            opacity: (1 - t) * 0.5,
            child: Transform.scale(
              scale: 1.0 + t * 0.5,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: color, width: 1.2),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
