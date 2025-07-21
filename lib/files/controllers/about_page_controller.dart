import 'package:get/get.dart';
import 'package:mtn_ghana_wp/files/model/about_page_model.dart';
import 'package:mtn_ghana_wp/files/network_manager/network_manager.dart';
import 'package:mtn_ghana_wp/files/utility/urls.dart';

class AboutPageController extends GetxController {
  final isLoading = false.obs;
  List<AboutList> aboutList = [];
  @override
  void onInit() {
    super.onInit();
    getPageDeatil();
  }

  getPageDeatil() async {
    isLoading.value = true;
    Map<String, dynamic> jsonResp = await NetworkManager().get(aboutPageUrl);
    AboutPageModel model = AboutPageModel.fromJson(jsonResp);
    //await Future.delayed(Duration(seconds: 2));

    //aboutList = aboutPageModelFromJson(_json).aboutList ?? [];
    aboutList = model.aboutList ?? [];
    isLoading.value = false;
  }
}

String _json = """{
	"aboutList": [{
			"header": "Choose your ringback tune from a variety of music genres",


			"dataList": [{
					"data": [{
							"icon_name": "about_search",
							"icon_title": "Search",
							"text":" Find any song in the ringtune catalogue using the search engine."
							

						}

					]

				},
				{
					"data": [{
							"icon_name": "about_music",
							"icon_title": "Tune Library",
							"text":"Build your tune library and make your callers listen to different melodies whenever they call you."
							
						}


					]
				},
				{
					"data": [{
							"icon_name": "about_style",
							"icon_title": "All Styles Hits",
							"text":"Explore bestsellers, most recent, most liked, top picks from all styles (Gospel, Hiphop, Reggae...)"
							
						}


					]
				}	

			]

		},


		{
			"header": "That special someone for that special moment",


			"dataList": [{
					"data": [{
							"icon_name": "about_special_icon",
							"icon_title": "Special Number",
							"text": "Dedicate tunes to your loved ones. Let them feel special by playing your favorite tunes to them."
							

						}

					]

				},
				{
					"data": [{
							"icon_name": "about_clock",
							"icon_title": "Time settings",
							"text":"Let your callers hear tunes on special events. Set tunes for birthdays, anniversaries, or any special days. Control the complete time customization so that you don't miss out on any important events."
						}


					]
				},
				{
					"data": [{
							"icon_name": "about_music_library",
							"icon_title": "Default Tune ",
							"text":"Set that special tune as your default one and let your callers always cherish the melody when they call you."
							
						}


					]
				},
				{
					"data": [{
							"icon_name": "about_shuffle",
							"icon_title": "Shuffle List ",
							"text": "Build your library by downloading your favorite tunes and endyear your callers with a different note whenever they call you."
							
						}


					]
				}

			]

		},


		{
			"header": "ACCESS IT ANYWHERE… ANYTIME",


			"dataList": [{
					"data": [{
							"icon_name": "about_responsive",
							"icon_title": "RESPONSIVE",
							"text": "Web/Tab/Mobile"
							

						}

					]

				},
				{
					"data": [{
							"icon_name": "about_mobile_icon",
							"icon_title": "APPLICATION",
							"text":"Android/iOS"
						
						}


					]
				},
				{
					"data": [{
							"icon_name": "about_ussd",
							"icon_title": "USSD",
							"text":"Dial *1355#"
						
						}


					]
				},
				{
					"data": [{
							"icon_name": "about_sms",
							"icon_title": "SMS",
							"text": "Send <keyword> to 1355 or send help to 1355."
							
						}


					]
				},
				{
					"data": [{
							"icon_name": "about_ivr",
							"icon_title": "IVR",
							"text": "Call 1355"
							
						}


					]
				}

			]

		}

	]
}""";
