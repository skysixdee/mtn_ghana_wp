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
import 'package:mtn_ghana_wp/files/google_tag_manager/google_tag_manager.dart';
import 'package:mtn_ghana_wp/files/model/tune_info.dart';
import 'package:mtn_ghana_wp/files/reusable_widgets/custom_text.dart';
import 'package:mtn_ghana_wp/files/router/route_name.dart';
import 'package:mtn_ghana_wp/files/screens/banner_detail_screen/banner_detail_screen.dart';
import 'package:mtn_ghana_wp/files/screens/blacklist_screen/blacklist_screen.dart';
import 'package:mtn_ghana_wp/files/screens/blacklist_screen/create_blacklist_screen.dart';
import 'package:mtn_ghana_wp/files/screens/category_detail_screen/category_detail_screen.dart';
import 'package:mtn_ghana_wp/files/screens/faq_screen/faq_screen.dart';
import 'package:mtn_ghana_wp/files/screens/home_screen/home_screen.dart';
import 'package:mtn_ghana_wp/files/screens/mobile_drawer_screen/mobile_drawer_screen.dart';
import 'package:mtn_ghana_wp/files/screens/mobile_tune_preview/mobile_tune_preview_sceen.dart';
import 'package:mtn_ghana_wp/files/screens/music_box/music_box_content_screen.dart';
import 'package:mtn_ghana_wp/files/screens/music_box/music_box_screen.dart';
import 'package:mtn_ghana_wp/files/screens/my_tune_screen/my_music_box_view/my_music_box_content.dart';
import 'package:mtn_ghana_wp/files/screens/my_tune_screen/my_tune_screen.dart';
import 'package:mtn_ghana_wp/files/screens/my_tune_setting_screen/my_tune_setting_screen.dart';
import 'package:mtn_ghana_wp/files/screens/my_wishlist_screen/my_wishlist_screen.dart';
import 'package:mtn_ghana_wp/files/screens/name_tune_screen/name_tune_screen.dart';
import 'package:mtn_ghana_wp/files/screens/profile_screen/profile_screen.dart';
import 'package:mtn_ghana_wp/files/screens/search_screen/artists_tune_screen.dart';
import 'package:mtn_ghana_wp/files/screens/search_screen/search_screen.dart';
import 'package:mtn_ghana_wp/files/screens/see_more_screen/see_more_screen.dart';
import 'package:mtn_ghana_wp/files/screens/terms_and_condition_screen/terms_and_conditions_screen.dart';
import 'package:mtn_ghana_wp/files/screens/web_navigation_view/web_navigation_view.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';
import 'package:mtn_ghana_wp/files/utility/colors.dart';
import 'package:mtn_ghana_wp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: homeRoute,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: navBuilder,
      branches: [
        _homeShell(),
        _searchShell(),
        _bannerDetailShell(),
        _categoryDetailShell(),
        _seeMoreShell(),
        _myWishlistShell(),
        _profileShell(),
        _myTuneShell(),
        _nameTuneShell(),
        _musicBoxShell(),
        _musicBoxContentShell(),
        _myMusicBoxContentShell(),
        _myTuneSettingShell(),
        _artistsTuneShell(),
        _blackListShell(),
        _createBlackListShell(),
        _faqShell(),
        _termsAndConditionsShell(),
        //_mobileTunePreviewShell(),
      ],
    ),
  ],
  redirect: (context, state) {
    CustomAudioPlayer.instance.stop();
    print("sky name = ${state.fullPath}");
    print("sky name = ${state.name}");
    String path = state.fullPath ?? '';
    if (!StoreManager.isLoggedIn) {
      if (path == profileRoute ||
          path == myTunesRoute ||
          path == myWishlistRoute) {
        return '/';
      } else {
        return null;
      }
    }
    return null;
  },
  errorPageBuilder: (context, state) {
    return MaterialPage(child: _errorWidget(context, state));
  },
);
StatefulShellBranch _homeShell() {
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: homeRoute,
        path: homeRoute,
        builder: (context, state) {
          homePageBrowseEvent();
          return const HomeScreen();
        },
      ),
    ],
  );
}

StatefulShellBranch _searchShell() {
  TuneSearchController cont = Get.find();
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: searchRoute,
        path: searchRoute,
        builder: (context, state) {
          String key1 = state.uri.queryParameters['search'] ?? '';
          homePageSearchClickEvent(key1);
          return SearchScreen(searchKey: key1);
        },
      ),
    ],
  );
}

StatefulShellBranch _bannerDetailShell() {
  BannerDetailController cont = Get.find();
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: bannerDetailRoute,
        path: bannerDetailRoute,
        builder: (context, state) {
          String type = state.uri.queryParameters['type'] ?? '';
          String searchKey = state.uri.queryParameters['searchKey'] ?? '';
          homePageBannerClickEvent(searchKey);
          cont.getBannerDetail(type, searchKey);
          return BannerDetailScreen();
        },
      ),
    ],
  );
}

StatefulShellBranch _myWishlistShell() {
  MyWishlistController cont = Get.find();
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: myWishlistRoute,
        path: myWishlistRoute,
        builder: (context, state) {
          //cont.getBannerDetail(type, searchKey);
          cont.getWishlist();
          return MyWishlistScreen();
        },
      ),
    ],
  );
}

StatefulShellBranch _profileShell() {
  ProfileController cont = Get.find();
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: profileRoute,
        path: profileRoute,
        builder: (context, state) {
          cont.getProfileDetail();
          return ProfileScreen();
        },
      ),
    ],
  );
}

StatefulShellBranch _nameTuneShell() {
  NameTuneController cont = Get.find();
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: nameTuneRoute,
        path: nameTuneRoute,
        builder: (context, state) {
          cont.getNameTune();
          return NameTuneScreen();
        },
      ),
    ],
  );
}

StatefulShellBranch _musicBoxShell() {
  MusicBoxController cont = Get.find();
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: musicBoxRoute,
        path: musicBoxRoute,
        builder: (context, state) {
          return MusicBoxScreen();
        },
      ),
    ],
  );
}

StatefulShellBranch _musicBoxContentShell() {
  MusicBoxController cont = Get.find();
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: musicBoxContentRoute,
        path: musicBoxContentRoute,
        builder: (context, state) {
          String id = state.uri.queryParameters['id'] ?? '';

          cont.getMusicBoxContent(id);
          return MusicBoxContentScreen(
            id: id,
          );
        },
      ),
    ],
  );
}

StatefulShellBranch _myMusicBoxContentShell() {
  MusicBoxController cont = Get.find();
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: myMusicBoxContentRoute,
        path: myMusicBoxContentRoute,
        builder: (context, state) {
          String id = state.uri.queryParameters['id'] ?? '';

          cont.getMusicBoxContent(id);
          return MyMusicBoxContent(id: id);
        },
      ),
    ],
  );
}

StatefulShellBranch _categoryDetailShell() {
  CategoryDetailController cont = Get.find();
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: categoryDetailRoute,
        path: categoryDetailRoute,
        builder: (context, state) {
          String key = state.uri.queryParameters['key'] ?? '';
          String catId = state.uri.queryParameters['catId'] ?? '';
          cont.getCategoryDetailList(key, catId);
          menuCategoryClickEvent(catId, key);
          return CategoryDetailScreen(
            name: key,
          );
        },
      ),
    ],
  );
}

StatefulShellBranch _seeMoreShell() {
  //CategoryDetailController cont = Get.find();
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: seeMoreRoute,
        path: seeMoreRoute,
        builder: (context, state) {
          List<TuneInfo> lst = state.extra as List<TuneInfo>;
          String name = state.uri.queryParameters['name'] ?? '';
          return SeeMoreScreen(
            list: lst,
            name: name,
          );
        },
      ),
    ],
  );
}

StatefulShellBranch _myTuneShell() {
  TuneController cont = Get.find();
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: myTunesRoute,
        path: myTunesRoute,
        builder: (context, state) {
          bool? isReload = state.extra as bool?;
          print(" extra = param = $isReload");
          //if (isReload ?? true) {
          cont.makeApiCall();
          //}

          return MyTuneScreen();
        },
      ),
    ],
  );
}

StatefulShellBranch _artistsTuneShell() {
  ArtistsTuneController cont = Get.find();
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: artistTuneRoute,
        path: artistTuneRoute,
        builder: (context, state) {
          String artistName = state.uri.queryParameters['artistName'] ?? '';
          cont.getArtistsTune(artistName);
          return ArtistsTuneScreen(artistName: artistName);
        },
      ),
    ],
  );
}

StatefulShellBranch _faqShell() {
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: faqRoute,
        path: faqRoute,
        builder: (context, state) {
          //menuFaqClickEvent();
          return FaqScreen();
        },
      ),
    ],
  );
}

StatefulShellBranch _termsAndConditionsShell() {
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: termsAndConditionsRoute,
        path: termsAndConditionsRoute,
        builder: (context, state) {
          return TermsAndConditionsScreen();
        },
      ),
    ],
  );
}

StatefulShellBranch _myTuneSettingShell() {
  MyTuneSettingController con = Get.find();
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: myTunesSettingRoute,
        path: myTunesSettingRoute,
        builder: (context, state) {
          TuneInfo info = state.extra as TuneInfo;
          String packName = state.uri.queryParameters['packName'] ?? '';

          con.resetValue();
          return MyTuneSettingScreen(
            info: info,
            packName: packName,
          );
        },
      ),
    ],
  );
}

StatefulShellBranch _blackListShell() {
  BlacklistController bCont = Get.find();
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: blackListRoute,
        path: blackListRoute,
        builder: (context, state) {
          bCont.getList();
          return BlacklistScreen();
        },
      ),
    ],
  );
}

StatefulShellBranch _createBlackListShell() {
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: createBlackListRoute,
        path: createBlackListRoute,
        builder: (context, state) {
          return CreateBlacklistScreen();
        },
      ),
    ],
  );
}

// StatefulShellBranch _mobileTunePreviewShell() {
//   return StatefulShellBranch(
//     routes: <RouteBase>[
//       GoRoute(
//         name: mobileTunePreviewRoute,
//         path: mobileTunePreviewRoute,
//         builder: (context, state) {
//           Map<String, dynamic> map = state.extra as Map<String, dynamic>;
//           TuneInfo tuneInfo = map['tuneInfo'] as TuneInfo;
//           List<TuneInfo> tuneList = map['tuneList'] as List<TuneInfo>;
//           return MobileTunePreviewSceen(
//               tuneInfo: tuneInfo, tuneList: tuneList); //(tuneInfo: TuneInfo());
//         },
//       ),
//     ],
//   );
// }

Widget navBuilder(context, state, navigationShell) {
  globalContext = context;
  return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveBuilder(
        builder: (context, si) {
          return Scaffold(
            appBar: (si.isMobile) ? AppBar(backgroundColor: yellow) : null,
            endDrawer: MobileDrawerScreen(),
            body: Material(
              child: Column(
                children: [
                  WebNavigationView(),
                  Expanded(
                      child: Scaffold(
                    body: navigationShell,
                  )),
                ],
              ),
            ),
          );
        },
      ));
}

Widget _errorWidget(BuildContext context, GoRouterState state) {
  return const Scaffold(
    body: Center(
      child: Text(
        "Error page loading",
      ),
    ),
  );
}
