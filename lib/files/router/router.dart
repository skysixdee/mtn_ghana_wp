import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mtn_ghana_wp/files/google_tag_manager/google_tag_manager.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/screens/reward_point_screen/reward_point_screen.dart';
import 'package:mtn_ghana_wp/files/side_menu_view/side_menu_view.dart';
import 'package:mtn_ghana_wp/files/utility/constants.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:mtn_ghana_wp/files/common/custom_audio_player.dart';
import 'package:mtn_ghana_wp/files/controllers/artists_tune_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/banner_detail_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/blacklist_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/category_detail_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/music_box_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/my_tune_setting_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/my_tune_controllers/tune_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/my_wishlist_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/name_tune_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/profile_controller.dart';
import 'package:mtn_ghana_wp/files/controllers/tune_search_controller.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/screens/about_screen/about_screen.dart';
import 'package:mtn_ghana_wp/files/screens/banner_detail_screen/banner_detail_screen.dart';
import 'package:mtn_ghana_wp/files/screens/blacklist_screen/blacklist_screen.dart';
import 'package:mtn_ghana_wp/files/screens/blacklist_screen/create_blacklist_screen.dart';
import 'package:mtn_ghana_wp/files/screens/category_detail_screen/category_detail_screen.dart';
import 'package:mtn_ghana_wp/files/screens/faq_screen/faq_screen.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/home_screen.dart';
import 'package:mtn_ghana_wp/files/screens/mobile_drawer_screen/mobile_drawer_screen.dart';
import 'package:mtn_ghana_wp/files/screens/music_box/music_box_content_screen.dart';
import 'package:mtn_ghana_wp/files/screens/music_box/music_box_screen.dart';
import 'package:mtn_ghana_wp/files/screens/my_tune_screen/my_music_box_view/my_music_box_content.dart';
import 'package:mtn_ghana_wp/files/screens/my_tune_screen/my_tune_screen.dart';
import 'package:mtn_ghana_wp/files/screens/my_tune_setting_screen/my_tune_setting_screen.dart';
import 'package:mtn_ghana_wp/files/screens/my_wishlist_screen/my_wishlist_screen.dart';
import 'package:mtn_ghana_wp/files/screens/name_tune_screen/name_tune_screen.dart';
import 'package:mtn_ghana_wp/files/screens/profile_screen/profile_screen.dart';
import 'package:mtn_ghana_wp/files/screens/search_screen/artist_list_screen.dart';
import 'package:mtn_ghana_wp/files/screens/search_screen/artists_tune_screen.dart';
import 'package:mtn_ghana_wp/files/screens/search_screen/search_screen.dart';
import 'package:mtn_ghana_wp/files/screens/see_more_screen/see_more_screen.dart';
import 'package:mtn_ghana_wp/files/screens/terms_and_condition_screen/terms_and_conditions_screen.dart';
import 'package:mtn_ghana_wp/files/screens/about_screen/about_screen.dart';
import 'package:mtn_ghana_wp/files/screens/web_navigation_view/web_navigation_view.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';

final _rootNavigatorKey = Get.key; //GlobalKey<NavigatorState>();
final scaffoldKey = GlobalKey<ScaffoldState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: homeRoute,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: navBuilder,
      branches: _getShellBranches(),
    ),
  ],
  redirect: (context, state) {
    CustomAudioPlayer.instance.stop();
    final path = state.fullPath ?? '';

    if (!StoreManager.isLoggedIn &&
        (path == profileRoute ||
            path == myTunesRoute ||
            path == myWishlistRoute)) {
      return '/';
    }
    return null;
  },
  errorPageBuilder: (context, state) =>
      MaterialPage(child: _errorWidget(context, state)),
);

List<StatefulShellBranch> _getShellBranches() => [
      _createShell(homeRoute, (_) => const HomeScreen(),
          onInit: (s) => homePageBrowseEvent()),
      _createShell(mainRoute, (_) => const HomeScreen(),
          onInit: (s) => homePageBrowseEvent()),
      _createShell(
          searchRoute,
          (s) => SearchScreen(
                searchKey: s.uri.queryParameters['search'] ?? '',
                index: s.uri.queryParameters['index'] ?? '',
              ),
          onInit: (dynamic s) =>
              homePageSearchClickEvent(s.uri.queryParameters['search'] ?? '')),
      _createShell(
          artistsRoute,
          (s) => ArtistListScreen(
                searchKey: s.uri.queryParameters['search'] ?? '',
                index: s.uri.queryParameters['index'] ?? '',
              )),
      _createShell(bannerDetailRoute, (s) => BannerDetailScreen(),
          onInit: (dynamic s) {
        final type = s.uri.queryParameters['type'] ?? '';
        final searchKey = s.uri.queryParameters['searchKey'] ?? '';
        homePageBannerClickEvent(searchKey);
        Get.find<BannerDetailController>().getBannerDetail(type, searchKey);
      }),
      _createShell(myWishlistRoute, (_) => MyWishlistScreen(),
          onInit: (s) => Get.find<MyWishlistController>().getWishlist()),
      _createShell(profileRoute, (_) => ProfileScreen(),
          onInit: (s) => Get.find<ProfileController>().getProfileDetail()),
      _createShell(nameTuneRoute, (_) => NameTuneScreen(),
          onInit: (s) => Get.find<NameTuneController>().getNameTune()),
      _createShell(musicBoxRoute, (_) => MusicBoxScreen()),
      _createShell(musicBoxContentRoute, (s) {
        final id = s.uri.queryParameters['id'] ?? '';
        final boxName = s.uri.queryParameters['boxName'] ?? '';
        final boxImage = s.uri.queryParameters['boxImage'] ?? '';
        Get.find<MusicBoxController>().getMusicBoxContent(id);
        return MusicBoxContentScreen(
            id: id, boxName: boxName, boxImage: boxImage);
      }),
      _createShell(myMusicBoxContentRoute, (s) {
        final id = s.uri.queryParameters['id'] ?? '';
        Get.find<MusicBoxController>().getMusicBoxContent(id);
        return MyMusicBoxContent(id: id);
      }),
      _createShell(categoryDetailRoute, (s) {
        final catId = s.uri.queryParameters['catId'] ?? '';
        menuCategoryClickEvent(catId);
        Get.find<CategoryDetailController>().getCategoryDetailList(catId);
        return CategoryDetailScreen(name: catId);
      }),
      _createShell(
          seeMoreRoute,
          (s) => SeeMoreScreen(
                list: s.extra as List<TuneInfo>,
                name: s.uri.queryParameters['name'] ?? '',
              )),
      _createShell(myTunesRoute, (_) => MyTuneScreen(),
          onInit: (s) => Get.find<TuneController>().makeApiCall()),
      _createShell(artistTuneRoute, (s) {
        final artistName = s.uri.queryParameters['artistName'] ?? '';
        Get.find<ArtistsTuneController>().getArtistsTune(artistName);
        return ArtistsTuneScreen(artistName: artistName);
      }),
      _createShell(rewardPointRoute, (_) => RewardPointScreen()),
      _createShell(faqRoute, (_) => FaqScreen()),
      _createShell(aboutRoute, (_) => AboutScreen()),
      _createShell(termsAndConditionsRoute, (_) => TermsAndConditionsScreen()),
      _createShell(myTunesSettingRoute, (s) {
        final info = s.extra as TuneInfo;
        final packName = s.uri.queryParameters['packName'] ?? '';
        Get.find<MyTuneSettingController>().resetValue();
        return MyTuneSettingScreen(info: info, packName: packName);
      }),
      _createShell(blackListRoute, (_) => BlacklistScreen(),
          onInit: (s) => Get.find<BlacklistController>().getList()),
      _createShell(createBlackListRoute, (_) => CreateBlacklistScreen()),
    ];

StatefulShellBranch _createShell(
    String name, Widget Function(GoRouterState) builder,
    {void Function(GoRouterState)? onInit}) {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        name: name,
        path: name,
        builder: (context, state) {
          if (onInit != null) onInit(state);
          return builder(state);
        },
      ),
    ],
  );
}

Widget navBuilder(context, state, navigationShell) {
  //globalContext = context;
  return ResponsiveBuilder(
    builder: (context, si) {
      return Scaffold(
        key: scaffoldKey,
        appBar: si.isMobile
            ? AppBar(automaticallyImplyLeading: false, backgroundColor: yellow)
            : null,
        endDrawer: si.isMobile ? MobileDrawerScreen() : null,
        body: Column(
          children: [
            WebNavigationView(),
            Expanded(
                child: Stack(
              children: [
                Row(
                  children: [
                    si.isMobile
                        ? const SizedBox()
                        : const SizedBox(width: sideMenuWidth),
                    Expanded(child: navigationShell)
                  ],
                ),
                si.isMobile ? const SizedBox() : const SideMenuView()
              ],
            ))
          ],
        ),
      );
    },
  );
}

Widget _errorWidget(BuildContext context, GoRouterState state) {
  return const Scaffold(
    body: Center(
      child: CustomText(title: "Error page loading"),
    ),
  );
}
