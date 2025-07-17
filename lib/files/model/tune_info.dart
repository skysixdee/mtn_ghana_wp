import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';

class TuneInfo {
  String? id;
  String? type;
  /*
"ContentType": "1",
            "activationChannel": "WEB",
            "chargedDate": "2025-07-16 07:48:50",
            "contentId": "8926",
            "contentPreviewImageURL": "http://10.135.64.104:8179/stream-media/get-preview-image?fileId=+u3WTWq+7a0=",
            "contentStreamingURL": "http://10.135.64.104:8179/stream-media/get-tone-path?fileId=+u3WTWq+7a0=",
            "expiryDate": "2025-09-14 07:48:50",
            "firstActivationDate": "2025-07-16 07:48:37",
            "isContentPackage": "1",
            "languageCode": "en",
            "price": "0.75",
            "status": "A"

*/
  String? msisdn;
  String? createdDate;
  String? wishListType;
  String? isContentPackage;
  String? price;
  String? expiryDate;
  String? categoryId;
  String? toneId;
  String? toneName = "No name";
  String? albumName = "albumName";
  String? artistName = "artistName";
  String? toneUrl;
  String? previewImageUrl;
  String? downloadCount;
  String? likeCount;
  String? status;
  String? toneIdStreamingUrl;
  String? toneIdpreviewImageUrl;
  RxBool? isLiked = false.obs;
  bool? isPlaying = false;
  RxBool? isLiking = false.obs;
  RxBool isDeleting = false.obs;

  TuneInfo({
    this.id,
    this.type,
    // this.contentName,
    // this.path,
    // this.album,
    // this.artist,
    this.msisdn,
    this.createdDate,
    this.wishListType,
    this.isContentPackage,
    this.albumName,
    this.artistName,
    this.categoryId,
    this.downloadCount,
    this.likeCount,
    this.previewImageUrl,
    this.toneId,
    this.toneIdStreamingUrl,
    this.toneIdpreviewImageUrl,
    this.toneName,
    this.toneUrl,
    this.price,
    this.status,
    this.expiryDate,
  });
  factory TuneInfo.fromJson(Map<String, dynamic> json) {
    return TuneInfo(
        id: json['id'],
        type: "${json['type']}",
        msisdn: json['msisdn'],
        createdDate: json['createdDate'],
        wishListType: json['wishListType'],
        isContentPackage: json['isContentPackage'],
        albumName: json['albumName'] ??
            json['album'] ??
            (StoreManager.isEnglish ? json['album_L1'] : json['album_L2']),
        artistName: json['artistName'] ??
            json['artist'] ??
            (StoreManager.isEnglish ? json['artist_L1'] : json['artist_L2']),
        categoryId: '${json['categoryId']}',
        downloadCount: json['downloadCount'],
        likeCount: json['likeCount'],
        previewImageUrl: json['previewImageUrl'] ??
            json['contentPreviewImageURL'] ??
            json['previewImage'],
        toneId: json['toneId'] ?? "${json['contentId']}" ?? json['toneCode'],
        toneIdStreamingUrl: json['toneIdStreamingUrl'] ??
            json['path'] ??
            json['location'] ??
            json['contentStreamingURL'],
        toneIdpreviewImageUrl: json['toneIdpreviewImageUrl'] ??
            json['previewImageUrl'] ??
            json['contentPreviewImageURL'] ??
            json['previewImage'],
        toneName: json['toneName'] ??
            json['contentName'] ??
            json['contentName'] ??
            (StoreManager.isEnglish
                ? json['contentName_L1']
                : json['contentName_L2']),
        toneUrl: json['toneUrl'],
        status: json['status'],
        price: '${json['price']}',
        expiryDate: json['expiryDate']);
  }

  toJson() {}
}
