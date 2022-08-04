import 'package:amazonadmin/ItemsScreens/item_screens.dart';
import 'package:amazonadmin/global/global.dart';
import 'package:amazonadmin/models/brands_model.dart';
import 'package:amazonadmin/splashScreen/my_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BrandsUiDesignWidget extends StatefulWidget {
  Brands? model;
  BuildContext? context;
  BrandsUiDesignWidget({
    Key? key,
    this.context,
    this.model,
  }) : super(key: key);

  @override
  State<BrandsUiDesignWidget> createState() => _BrandsUiDesignWidgetState();
}

class _BrandsUiDesignWidgetState extends State<BrandsUiDesignWidget> {
  deleterBrand(String brandUniqueId) {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("brands")
        .doc(brandUniqueId)
        .delete();
    Fluttertoast.showToast(msg: "Brand Deleted Successfully");
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => ItemsScreen(
              model: widget.model,
            ),
          ),
        );
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.greenAccent,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    widget.model!.thumbnailUrl.toString(),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          widget.model!.brandTitle.toString(),
                          style: const TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          deleterBrand(widget.model!.brandID.toString());
                        },
                        icon: const Icon(
                          Icons.delete_sweep,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
