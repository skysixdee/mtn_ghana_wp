import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mtn_ghana_wp/files/store_manager/store_manager.dart';

class TuneInfo {
  String? id;
  String? type;

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
  String? localImgName;
  String? toneIdStreamingUrl;
  String? toneIdpreviewImageUrl;
  RxBool? isLiked = false.obs;
  bool? isPlaying = false;
  RxBool? isLiking = false.obs;
  RxBool isDeleting = false.obs;
  String? activationChannel;
  String? chargedDate;
  String? firstActivationDate;
  String? languageCode;
  String? contentType;
  String? chargedValidity;
  String? deactivationDate;
  String? deactivationChannel;
  String? offerType;
  String? offerMode;
  String? chargeType;
  TuneInfo({
    this.id,
    this.type,
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
    this.localImgName,
    this.activationChannel,
    this.chargedDate,
    this.firstActivationDate,
    this.languageCode,
    this.contentType,
    this.chargedValidity,
    this.deactivationDate,
    this.deactivationChannel,
    this.offerType,
    this.offerMode,
    this.chargeType,
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
          (StoreManager.isEnglish
              ? json['album_L1']
              : json['album_L2'] ?? json['albumName_L2']),
      artistName: json['artistName'] ??
          json['artist'] ??
          (StoreManager.isEnglish
              ? json['artist_L1']
              : json['artist_L2'] ?? json['artistName_L2']),
      categoryId: '${json['categoryId']}',
      downloadCount: json['downloadCount'],
      likeCount: json['likeCount'],
      previewImageUrl: json['previewImageUrl'] ??
          json['contentPreviewImageURL'] ??
          json['previewImage'],
      toneId: json['toneId'] ??
          "${json['contentId']}" ??
          json['toneCode'] ??
          json['musicBoxId'],
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
          json['musicBoxName'] ??
          json['offerName'] ??
          (StoreManager.isEnglish
              ? json['contentName_L1']
              : json['contentName_L2']),
      toneUrl: json['toneUrl'],
      status: json['status'] ?? json['offerStatus'],
      price: '${json['price'] ?? json['chargedAmount']}',
      expiryDate: json['expiryDate'],
      activationChannel: json['activationChannel'],
      chargedDate: json['chargedDate'],
      firstActivationDate: json['firstActivationDate'],
      languageCode: json['languageCode'],
      contentType: json['contentType'],
      chargedValidity: json['chargedValidity'],
      deactivationDate: json['deactivationDate'],
      deactivationChannel: json['deactivationChannel'],
      offerType: json['offerType'],
      offerMode: json['offerMode'],
      chargeType: json['chargeType'],
    );
  }

  toJson() {}
}
