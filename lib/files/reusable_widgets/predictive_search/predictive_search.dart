import 'package:flutter/material.dart';
//import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/controllers/predictive_search_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/tune_search_controller.dart';
import 'package:mtn_ghana_wp/files/enums/fonts.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_image.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/loading_indicator.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/files/utility/images.dart';
import 'package:mtn_ghana_wp/files/utility/strings.dart';
import 'package:mtn_ghana_wp/main.dart';

class PredictiveSearch extends StatelessWidget {
  const PredictiveSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: isDarkTheme(context) ? blackTest : lightGreyTest,
        child: SizedBox(height: 120, child: SearchScreen()));
  }
}

class SearchItem {
  final String type; // 'header', 'artist', or 'code'
  final String name;
  final String? code;
  final String? additionalInfo;

  SearchItem({
    required this.type,
    required this.name,
    this.code,
    this.additionalInfo,
  });
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  final TextEditingController _controller = TextEditingController();
  late PredictiveSearchController cont;
  final TuneSearchController _tuneSearchController = Get.find();

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => PredictiveSearchController());
    cont = Get.find<PredictiveSearchController>();

    // Add a post-frame callback to start listening after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Create a combined worker that listens to all three observables
      ever(cont.isLoadingSongName, (_) {
        // When loading state changes, check if we should show/hide overlay
        if (!cont.isLoadingSongName.value && !cont.isLoadingArtistName.value) {
          _updateOverlayVisibility();
        }
      });

      ever(cont.isLoadingArtistName, (_) {
        // When loading state changes, check if we should show/hide overlay
        if (!cont.isLoadingSongName.value && !cont.isLoadingArtistName.value) {
          _updateOverlayVisibility();
        }
      });
    });
  }

  @override
  void dispose() {
    _hideOverlay();
    _controller.dispose();
    super.dispose();
  }

  bool _hasData() {
    return cont.artistNameList.isNotEmpty ||
        cont.toneNameList.isNotEmpty ||
        cont.codeList.isNotEmpty;
  }

  void _updateOverlayVisibility() {
    // Use a short delay to ensure the UI has updated
    Future.microtask(() {
      if (!mounted) return;

      if (_hasData() && _controller.text.isNotEmpty) {
        if (_overlayEntry == null) {
          _showOverlay();
        } else {
          // Rebuild the overlay with new data
          _overlayEntry?.markNeedsBuild();
        }
      } else {
        _hideOverlay();
      }
    });
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;
    _overlayEntry = _createOverlay();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlay() {
    RenderBox box = context.findRenderObject() as RenderBox;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final offset = box.localToGlobal(Offset.zero);

    // Calculate available space below the TextField
    final availableHeight = screenHeight - (offset.dy + box.size.height + 16);

    // Calculate max safe width for the overlay based on screen bounds
    final maxSafeWidth = screenWidth - (offset.dx * 2);

    return OverlayEntry(
      opaque: false,
      builder: (context) => Stack(
        children: [
          // Tap outside to close overlay
          GestureDetector(
            onTap: () {
              if (mounted) _hideOverlay();
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              color:
                  appCont.isDarkTheme.value ? Colors.white30 : Colors.black12,
            ),
          ),

          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, box.size.height - 40),
            child: Align(
              alignment: Alignment.topLeft,
              child: Material(
                color: transparent,
                borderRadius: BorderRadius.circular(12),
                child: Obx(
                  () {
                    return Container(
                      constraints: BoxConstraints(
                        maxHeight:
                            availableHeight > 450 ? 450 : availableHeight - 20,
                        // This prevents the container from ever exceeding screen width
                        maxWidth: maxSafeWidth > 1000 ? 1000 : maxSafeWidth,
                      ),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: appCont.isDarkTheme.value ? black : white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      // We use LayoutBuilder to dynamically sizing the width down
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            child: Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              // Standardizes child sizing if screen size gets too narrow
                              children: [
                                cont.isLoadingSongName.value
                                    ? loadingIndicator(
                                        width: constraints.maxWidth < 300
                                            ? constraints.maxWidth
                                            : 300)
                                    : cont.toneNameList.isNotEmpty
                                        ? SizedBox(
                                            width: constraints.maxWidth < 300
                                                ? constraints.maxWidth
                                                : 300,
                                            child: _songs(),
                                          )
                                        : const SizedBox.shrink(),
                                _buildArtistSectionResponsive(
                                    constraints.maxWidth),
                                if (cont.codeList.isNotEmpty)
                                  SizedBox(
                                    width: constraints.maxWidth < 300
                                        ? constraints.maxWidth
                                        : 300,
                                    child: _songCode(),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtistSectionResponsive(double maxWidth) {
    final targetWidth = (maxWidth < 300 ? maxWidth : 300).toDouble();
    if (cont.isLoadingArtistName.value) {
      return loadingIndicator(width: targetWidth);
    }
    if (cont.artistNameList.isNotEmpty) {
      return SizedBox(width: targetWidth, child: _artists());
    }
    return const SizedBox.shrink();
  }

  Widget buildArtistSection() {
    if (cont.isLoadingArtistName.value) {
      return loadingIndicator(width: 300);
    }

    if (cont.artistNameList.isNotEmpty) {
      return SizedBox(width: 300, child: _artists());
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CompositedTransformTarget(
          link: _layerLink,
          child: TextField(
            controller: _controller,
            onTap: () {
              // Only show overlay if there's data
              if (_hasData()) {
                _showOverlay();
              }
            },
            onSubmitted: (value) {
              if (value.isEmpty) return;
              _hideOverlay();
              var isNumeric = isValidNumeric(value);
              cont.consolidatedResults(value, selectedIndex: isNumeric ? 2 : 0);

              context.goNamed(searchConsolidatedRoute);
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                cont.getResultFor(value);
              } else {
                // Hide overlay when search is cleared
                _hideOverlay();
              }
            },
            decoration: InputDecoration(
              hintText: searchForSongArtistCodeStr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidNumeric(String value) {
    if (value.length <= 4) return false;
    return RegExp(r'^[0-9]+$').hasMatch(value);
  }

  // ================= UI =================

  Widget _sectionHeader(String title,
      {String? imageName, bool showViewAll = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 30,
              height: 30,
              child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(3),
                  child: Image.asset(
                    imageName ?? "",
                  ))),
          Expanded(
            child: CustomText(
              title: title,
              color: black,
              colorD: whiteD,
            ),
          ),
        ],
      ),
    );
  }

  Widget _songCode() {
    return Container(
      decoration: containerDeco(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader(codeStr.toUpperCase(),
                imageName: tuneIconPng, showViewAll: true),
            const SizedBox(height: 4),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cont.codeList.length > 5 ? 5 : cont.codeList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _hideOverlay();
                    _tuneSearchController
                        .getSongCodeSearch(cont.codeList[index].toneId ?? '');
                    context.goNamed(searchRoute, queryParameters: {
                      'search': cont.codeList[index].toneId,
                      'index': "2"
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: CustomText(
                      isSelectable: false,
                      title: "${cont.codeList[index].toneId}",
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration containerDeco() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isDarkTheme(context) ? blackTest : whiteD);
  }

  Widget _songs() {
    return Container(
      decoration: containerDeco(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader(songsStr.toUpperCase(),
                imageName: tuneIconPng, showViewAll: true),
            const SizedBox(height: 4),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:
                  cont.toneNameList.length > 6 ? 6 : cont.toneNameList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _hideOverlay();
                    _tuneSearchController
                        .getSongCodeSearch(cont.toneNameList[index]);
                    context.goNamed(searchRoute, queryParameters: {
                      'search': cont.toneNameList[index],
                      'index': "0"
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: CustomText(
                      isSelectable: false,
                      title: cont.toneNameList[index],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _artists() {
    return Container(
      decoration: containerDeco(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader(artistsStr.toUpperCase(),
                imageName: artistIconPng, showViewAll: true),
            const SizedBox(height: 4),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cont.artistNameList.length > 6
                  ? 6
                  : cont.artistNameList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _hideOverlay();
                    _tuneSearchController
                        .getArtistSearch(cont.artistNameList[index]);
                    context.goNamed(artistsRoute, queryParameters: {
                      'search': cont.artistNameList[index],
                      'index': "1"
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: CustomText(
                      isSelectable: false,
                      title: cont.artistNameList[index],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
