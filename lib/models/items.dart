import 'package:cloud_firestore/cloud_firestore.dart';

class Items {
  String? itemID;
  String? brandID;
  String? sellerUID;
  String? sellerName;
  String? itemInfo;
  String? itemTitle;
  String? longDescription;
  String? price;
  Timestamp? publishedDate;
  String? status;
  String? thumbnailUrl;
  Items({
    this.itemID,
    this.brandID,
    this.sellerUID,
    this.sellerName,
    this.itemInfo,
    this.itemTitle,
    this.longDescription,
    this.price,
    this.publishedDate,
    this.status,
    this.thumbnailUrl,
  });
  Items.fromJson(Map<String, dynamic> json) {
    brandID = json["brandID"];
    itemID = json["itemID"];
    sellerUID = json["sellerUID"];
    sellerName = json["sellerName"];
    itemInfo = json["itemInfo"];
    itemTitle = json["itemTitle"];
    longDescription = json["longDescription"];
    publishedDate = json["publishedDate"];
    status = json["status"];
    price = json["price"];
    thumbnailUrl = json["thumbnailUrl"];
  }
}
