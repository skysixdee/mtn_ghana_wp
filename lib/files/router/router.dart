import 'package:etisalat/files/controllers/banner_detail_controller.dart';
import 'package:etisalat/files/controllers/category_detail_controller.dart';
import 'package:etisalat/files/controllers/music_box_controller.dart';
import 'package:etisalat/files/controllers/my_tune_controllers/tune_controller.dart';
import 'package:etisalat/files/controllers/my_wishlist_controller.dart';
import 'package:etisalat/files/controllers/name_tune_controller.dart';
import 'package:etisalat/files/controllers/profile_controller.dart';
import 'package:etisalat/files/controllers/tune_search_controller.dart';
import 'package:etisalat/files/model/tune_info.dart';
import 'package:etisalat/files/router/route_name.dart';
import 'package:etisalat/files/screens/banner_detail_screen/banner_detail_screen.dart';
import 'package:etisalat/files/screens/category_detail_screen/category_detail_screen.dart';
import 'package:etisalat/files/screens/home_screen/home_screen.dart';
import 'package:etisalat/files/screens/music_box/music_box_content_screen.dart';
import 'package:etisalat/files/screens/music_box/music_box_screen.dart';
import 'package:etisalat/files/screens/my_tune_screen/my_tune_screen.dart';
import 'package:etisalat/files/screens/my_wishlist_screen/my_wishlist_screen.dart';
import 'package:etisalat/files/screens/name_tune_screen/name_tune_screen.dart';
import 'package:etisalat/files/screens/profile_screen/profile_screen.dart';
import 'package:etisalat/files/screens/search_screen/search_screen.dart';
import 'package:etisalat/files/screens/see_more_screen/see_more_screen.dart';
import 'package:etisalat/files/screens/web_navigation_view/web_navigation_view.dart';
import 'package:etisalat/files/store_manager/store_manager.dart';
import 'package:etisalat/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

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
      ],
    ),
  ],
  redirect: (context, state) {
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
    return MaterialPage(child: errorWidget(context, state));
  },
);
StatefulShellBranch _homeShell() {
  return StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
        name: homeRoute,
        path: homeRoute,
        builder: (context, state) {
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
          String type = state.uri.queryParameters['type'] ?? '';
          String code = state.uri.queryParameters['code'] ?? '';
          cont.getMusicBoxContent(type, code);
          return MusicBoxContentScreen();
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
          return CategoryDetailScreen();
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
          return SeeMoreScreen(list: lst);
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
          cont.makeApiCall();
          return const MyTuneScreen();
        },
      ),
    ],
  );
}

Widget navBuilder(context, state, navigationShell) {
  globalContext = context;
  return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Material(
      child: Column(
        children: [
          WebNavigationView(),
          Expanded(child: navigationShell),
        ],
      ),
    ),
  );
}

Widget errorWidget(BuildContext context, GoRouterState state) {
  return const Scaffold(
    body: Center(
      child: Text(
        "Error page loading",
      ),
    ),
  );
}
