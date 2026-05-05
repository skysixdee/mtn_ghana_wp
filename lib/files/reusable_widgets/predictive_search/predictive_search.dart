import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/is_dark_theme.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';

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
                  height: 400,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    color: isDarkTheme(context) ? blackD : white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Wrap(
                    spacing: 10,
                    children: [
                      //Flexible(child: _albums()),
                      SizedBox(width: 300, child: _albums()),
                      const SizedBox(width: 16),
                      //Flexible(child: _songs()),
                      SizedBox(width: 300, child: _songs()),
                      const SizedBox(width: 16),
                      //Flexible(child: _artists()),
                      SizedBox(width: 300, child: _artists()),
                    ],
                  ),
                  // SingleChildScrollView(
                  //   child: Column(
                  //     children: [
                  //       // 🔝 TOP RESULT
                  //       // _sectionHeader("TOP RESULT"),
                  //       // _listItem(
                  //       //   "Headlights (feat. KIDDO)",
                  //       //   "English Song • Alan Walker",
                  //       // ),

                  //       // const SizedBox(height: 20),

                  //       // 🎶 3 COLUMN LAYOUT
                  //       Row(
                  //         spacing: 10,
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Expanded(child: _albums()),
                  //           const SizedBox(width: 16),
                  //           Expanded(child: _songs()),
                  //           const SizedBox(width: 16),
                  //           Expanded(child: _artists()),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
              if (_overlayEntry == null) _showOverlay();
            },
            decoration: InputDecoration(
              hintText: "Search...",
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
        if (showViewAll)
          Text("View All", style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _albums() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("ALBUMS", showViewAll: true),
        const SizedBox(height: 10),
        _listItem("Mere Jeevan Saathi", "Hindi Album • 1972"),
        _listItem("Hela Ki Prema", "Odia Album • 2021"),
        _listItem("Heera Panna", "Hindi Album • 1973"),
      ],
    );
  }

  Widget _songs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("SONGS", showViewAll: true),
        const SizedBox(height: 10),
        _listItem("HE", "Haryanvi Song"),
        _listItem("Heeriye (feat. Arijit Singh)", "Hindi Song"),
        _listItem("Headlights (feat. KIDDO)", "English Song"),
      ],
    );
  }

  Widget _artists() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("ARTISTS", showViewAll: true),
        const SizedBox(height: 10),
        _listItem("Hema Malini", "Artist"),
        _listItem("Hesham Abdul Wahab", "Artist"),
        _listItem("Heavy Rain Sounds for Sleep", "Artist"),
      ],
    );
  }

  Widget _listItem(String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      title: CustomText(
        title: title,
        color: black,
        colorD: black,
      ), //Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,),
      subtitle: CustomText(
        title: subtitle,
        color: darkGrey,
        colorD: whiteD,
      ),
      onTap: () {
        _controller.text = title;
        _hideOverlay();
      },
    );
  }
}
