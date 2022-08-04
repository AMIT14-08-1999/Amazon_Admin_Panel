import 'package:amazonadmin/OrdersScreens/order_card.dart';
import 'package:amazonadmin/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShiftedParcelScreen extends StatefulWidget {
  const ShiftedParcelScreen({Key? key}) : super(key: key);

  @override
  State<ShiftedParcelScreen> createState() => _ShiftedParcelScreenState();
}

class _ShiftedParcelScreenState extends State<ShiftedParcelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
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
        ),
        title: const Text(
          "Shifted parcels",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("status", isEqualTo: "shifted")
            .where("sellerUID", isEqualTo: sharedPreferences!.getString("uid"))
            .orderBy("orderTime", descending: true)
            .snapshots(),
        builder: ((context, AsyncSnapshot dataSnapshot) {
          if (dataSnapshot.hasData) {
            return ListView.builder(
              itemCount: dataSnapshot.data.docs.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("items")
                      .where("itemID",
                          whereIn: cartMethods.separateOrderItemIDs(
                              (dataSnapshot.data.docs[index].data()
                                  as Map<String, dynamic>)["productIDs"]))
                      .where("sellerUID",
                          whereIn: (dataSnapshot.data.docs[index].data()
                              as Map<String, dynamic>)["uid"])
                      .orderBy("publishedDate", descending: true)
                      .get(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return OrderCard(
                        itemCount: snapshot.data.docs.length,
                        data: snapshot.data.docs,
                        orderId: dataSnapshot.data.docs[index].id,
                        seperateQuantityList:
                            cartMethods.separateOrderItemQuantity(
                          (dataSnapshot.data.docs[index].data()
                              as Map<String, dynamic>)["productIDs"],
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text("No Data Exists"),
                      );
                    }
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text("No Data Exists"),
            );
          }
        }),
      ),
    );
  }
}
