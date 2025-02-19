import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class TuneInfo {
  String? id;
  String? type;
  // String? contentName;
  // String? path;
  // String? album;
  // String? artist;
  String? msisdn;
  String? createdDate;
  String? wishListType;

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
        type: json['type'],
        // contentName: json['contentName'],
        // path: json['path'],
        // album: json['album'] ?? json['albumName'],
        // artist: json['artist'] ?? json['artistName'],
        msisdn: json['msisdn'],
        createdDate: json['createdDate'],
        wishListType: json['wishListType'],
        albumName: json['albumName'] ?? json['album'],
        artistName: json['artistName'] ?? json['artist'],
        categoryId: '${json['categoryId']}',
        downloadCount: json['downloadCount'],
        likeCount: json['likeCount'],
        previewImageUrl: json['previewImageUrl'],
        toneId: json['toneId'] ?? json['contentId'] ?? json['toneCode'],
        toneIdStreamingUrl: json['toneIdStreamingUrl'] ?? json['path'],
        toneIdpreviewImageUrl:
            json['toneIdpreviewImageUrl'] ?? json['previewImageUrl'],
        toneName:
            json['toneName'] ?? json['contentName'] ?? json['channelName'],
        toneUrl: json['toneUrl'],
        status: json['status'],
        price: '${json['price']}',
        expiryDate: json['expiryDate']);
  }

  toJson() {}
}
