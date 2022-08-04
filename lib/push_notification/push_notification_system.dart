import 'package:amazonadmin/functions/functions.dart';
import 'package:amazonadmin/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future whenNotificationReceived(context) async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        showNotificationWhenOpenApp(
          remoteMessage.data["userOrderId"],
          context,
        );
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        showNotificationWhenOpenApp(
          remoteMessage.data["userOrderId"],
          context,
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        showNotificationWhenOpenApp(
          remoteMessage.data["userOrderId"],
          context,
        );
      }
    });
  }

  Future generateDeviceRecognitionToken() async {
    String? registrationDeviceToken = await messaging.getToken();

    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .update({
      "sellerDeviceToken": registrationDeviceToken,
    });

    messaging.subscribeToTopic("allSellers");
    messaging.subscribeToTopic("allUsers");
  }

  showNotificationWhenOpenApp(orderId, context) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .get()
        .then((snapshot) {
      if (snapshot.data()!["status"] == "ended") {
        showReusableSnackBar(context,
            "Order ID: # $orderId \n\n has delivered & received by the user.");
      } else {
        showReusableSnackBar(context,
            "You have new Order. \nOrder ID: # $orderId \n\n Please Check Now.");
      }
    });
  }
}
