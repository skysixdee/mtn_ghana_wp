import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
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
import 'package:mtn_ghana_wp/files/utility/strings.dart';

class PredictiveSearch extends StatelessWidget {
  const PredictiveSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(border: Border.all(color: white)),
        child: SizedBox(height: 100, child: SearchScreen()));
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
    Get.lazyPut(() => PredictiveSearchController());
    cont = Get.find<PredictiveSearchController>();
    super.initState();
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

    return OverlayEntry(
      opaque: false,
      builder: (context) => Stack(
        children: [
          // 👇 Tap outside to close
          GestureDetector(
            onTap: _hideOverlay,
            behavior: HitTestBehavior.translucent,
            child: Container(
                color: isDarkTheme(context) ? Colors.white30 : Colors.black12),
          ),

          Positioned(
            //width: box.size.width - 32,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: const Offset(0, 60),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                    //height: 400,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      //color: Colors.white,
                      color: isDarkTheme(context) ? blackD : white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Obx(
                      () {
                        return Wrap(
                          spacing: 20,
                          runSpacing: 20,
                          children: [
                            cont.isLoadingSong.value
                                ? loadingIndicator(width: 300)
                                : SizedBox(width: 300, child: _songs()),
                            //const SizedBox(width: 16),
                            //Flexible(child: _songs()),
                            buildArtistSection(),
                            //const SizedBox(width: 16),
                            //Flexible(child: _artists()),
                            if (cont.codeList.isNotEmpty)
                              SizedBox(width: 300, child: _songCode()),
                          ],
                        );
                      },
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildArtistSection() {
    if (cont.isLoadingArtist.value) {
      return loadingIndicator(width: 300);
    }

    if (cont.artistList.isNotEmpty) {
      return SizedBox(width: 300, child: _artists());
    }

    return const SizedBox();
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
            onTap: _showOverlay,
            onChanged: (value) {
              if (value.isNotEmpty) {
                cont.getResultFor(value);
              }

              if (_overlayEntry == null) _showOverlay();
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

  // ================= UI =================

  Widget _sectionHeader(String title, {bool showViewAll = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          title: title,
          color: black,
          colorD: whiteD,
        ),
        // if (showViewAll)
        //   CustomText(
        //     title: viewMoreStr,
        //     fontName: FontName.regular,
        //     color: black,
        //     colorD: whiteD,
        //   ),
      ],
    );
  }

  Widget _songCode() {
    return Container(
      decoration: containerDeco(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader(codeStr.toUpperCase(), showViewAll: true),
            const SizedBox(height: 10),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cont.codeList.length > 5 ? 5 : cont.codeList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _tuneSearchController
                        .getSongCodeSearch(cont.codeList[index].toneId ?? '');
                    context.goNamed(searchRoute, queryParameters: {
                      'search': cont.codeList[index].toneId,
                      'index': "2"
                    }); //goNamed(searchRoute);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
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
        borderRadius: BorderRadius.circular(4),
        color: isDarkTheme(context) ? blackTest : whiteD);
  }

  Widget _songs() {
    return Container(
      decoration: containerDeco(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader(songsStr.toUpperCase(), showViewAll: true),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: cont.toneList.length > 6 ? 6 : cont.toneList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _tuneSearchController
                        .getSongCodeSearch(cont.toneList[index]);
                    context.goNamed(searchRoute, queryParameters: {
                      'search': cont.toneList[index],
                      'index': "0"
                    }); //goNamed(searchRoute);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: CustomText(
                      isSelectable: false,
                      title: cont.toneList[index],
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader(artistsStr.toUpperCase(), showViewAll: true),
            const SizedBox(height: 10),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:
                  cont.artistList.length > 6 ? 6 : cont.artistList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _tuneSearchController
                        .getArtistSearch(cont.artistList[index]);
                    context.goNamed(artistsRoute, queryParameters: {
                      'search': cont.artistList[index],
                      'index': "1"
                    }); //goNamed(searchRoute);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: CustomText(
                      isSelectable: false,
                      title: cont.artistList[index],
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
