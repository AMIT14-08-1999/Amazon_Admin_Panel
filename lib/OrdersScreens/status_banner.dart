import 'package:amazonadmin/brandsScreens/home_screen.dart';
import 'package:flutter/material.dart';

class StatusBanner extends StatelessWidget {
  bool? status;
  String? orderStatus;
  StatusBanner({Key? key, this.orderStatus, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? message;
    IconData? iconData;

    status! ? iconData = Icons.done : iconData = Icons.cancel;
    status! ? message = "Successful" : message = "UnSuccessful";
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Colors.pinkAccent,
          Colors.purpleAccent,
        ],
        begin: FractionalOffset(0.0, 0.0),
        end: FractionalOffset(1.0, 0.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp,
      )),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => HomeScreen(),
                ),
              );
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          Text(
            orderStatus == "ended"
                ? "Parcel Delivered $message"
                : orderStatus == "shifted"
                    ? "Parcel Shifted $message"
                    : orderStatus == "normal"
                        ? "Order Placed $message"
                        : "",
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.black,
            child: Center(
              child: Icon(
                iconData,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
