import 'dart:convert';

import 'package:amazonadmin/global/global.dart';
import 'package:amazonadmin/models/address.dart';
import 'package:amazonadmin/splashScreen/my_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AddressDesign extends StatelessWidget {
  Address? model;
  String? orderStatus;
  String? orderId;
  String? sellerId;
  String? orderByUser;
  String? totalAmount;
  AddressDesign({
    Key? key,
    this.model,
    this.orderByUser,
    this.orderId,
    this.orderStatus,
    this.sellerId,
    this.totalAmount,
  }) : super(key: key);

  sendNotificationToUser(userUID, orderId) async {
    String userDeviceToken = "";
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userUID)
        .get()
        .then((snapshot) {
      if (snapshot.data()!["userDeviceToken"] != null) {
        userDeviceToken = snapshot.data()!["userDeviceToken"].toString();
      }
    });
    notificationFormat(
      userDeviceToken,
      orderId,
      sharedPreferences!.getString("name"),
    );
  }

  notificationFormat(userDeviceToken, orderId, sellerName) {
    Map<String, String> headerNotification = {
      'Content-Type': "application/json",
      "Authorization": fcmServerToken,
    };
    Map bodyNotification = {
      'body':
          "Dear user, your order (# $orderId) has been shifted successfully by seller $sellerName.",
      'title': "Parcel Shifted",
    };
    Map dataMap = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "userOrderId": orderId,
    };
    Map officialFormat = {
      'notification': bodyNotification,
      "data": dataMap,
      'priority': "High",
      'to': userDeviceToken,
    };
    http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerNotification,
      body: jsonEncode(officialFormat),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Shopping Details:-- ",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              TableRow(
                children: [
                  const Text(
                    "Name: ",
                    style: TextStyle(color: Colors.green),
                  ),
                  Text(
                    model!.name.toString(),
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
              const TableRow(
                children: [
                  SizedBox(height: 4),
                  SizedBox(height: 4),
                ],
              ),
              TableRow(
                children: [
                  const Text(
                    "Phone No: ",
                    style: TextStyle(color: Colors.green),
                  ),
                  Text(
                    model!.phoneNumber.toString(),
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            model!.completeAddress.toString(),
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (orderStatus == "normal") {
              FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(sharedPreferences!.getString("uid"))
                  .update({
                "earnings": (double.parse(previousEarning)) +
                    (double.parse(totalAmount!)),
              }).whenComplete(() {
                FirebaseFirestore.instance
                    .collection("orders")
                    .doc(orderId)
                    .update({
                  "status": "shifted",
                }).whenComplete(() {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(orderByUser)
                      .collection("orders")
                      .doc(orderId)
                      .update({
                    "status": "shifted",
                  });
                }).whenComplete(() {
                  sendNotificationToUser(orderByUser, orderId);
                  Fluttertoast.showToast(msg: "Confirmed Successfully..");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => const MySplashScreen(),
                    ),
                  );
                });
              });
            } else if (orderStatus == "shifted") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const MySplashScreen()));
            } else if (orderStatus == "ended") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const MySplashScreen()));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const MySplashScreen()));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              color: Colors.grey,
              width: MediaQuery.of(context).size.width - 40,
              height: orderStatus == "ended"
                  ? 60
                  : MediaQuery.of(context).size.height * .10,
              child: Center(
                child: Text(
                  orderStatus == "ended"
                      ? "Go Back"
                      : orderStatus == "shifted"
                          ? "Go Back"
                          : orderStatus == "normal"
                              ? "Parcel Packed & \nShifted to nearest Pickup Point. \nClick to Confirm"
                              : "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
