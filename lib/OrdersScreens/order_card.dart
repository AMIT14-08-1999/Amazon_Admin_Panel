import 'package:amazonadmin/OrdersScreens/order_details_Screen.dart';
import 'package:amazonadmin/models/items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  int? itemCount;
  List<DocumentSnapshot>? data;
  String? orderId;
  List<String>? seperateQuantityList;
  OrderCard(
      {Key? key,
      this.data,
      this.itemCount,
      this.orderId,
      this.seperateQuantityList})
      : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => OrderDetailsScreen(
              orderID: widget.orderId,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.black,
        elevation: 10,
        shadowColor: Colors.white24,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          height: widget.itemCount! * 125,
          child: ListView.builder(
              itemCount: widget.itemCount,
              itemBuilder: (context, index) {
                Items model = Items.fromJson(
                    widget.data![index].data() as Map<String, dynamic>);
                return placedOrdersItemsDesignWidget(
                    model, context, widget.seperateQuantityList![index]);
              }),
        ),
      ),
    );
  }
}

Widget placedOrdersItemsDesignWidget(
    Items items, BuildContext context, seperateQuantityList) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 120,
    color: Colors.transparent,
    child: SingleChildScrollView(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              items.thumbnailUrl.toString(),
              width: 120,
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          items.itemTitle.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      const Text(
                        "₹",
                        style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        items.price.toString(),
                        style: const TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const Text(
                        "x",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        seperateQuantityList,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
