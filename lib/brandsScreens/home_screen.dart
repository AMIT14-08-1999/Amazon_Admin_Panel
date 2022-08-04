import 'package:amazonadmin/brandsScreens/brands_ui_design.dart';
import 'package:amazonadmin/brandsScreens/upload_brands_screen.dart';
import 'package:amazonadmin/functions/functions.dart';
import 'package:amazonadmin/global/global.dart';
import 'package:amazonadmin/models/brands_model.dart';
import 'package:amazonadmin/push_notification/push_notification_system.dart';
import 'package:amazonadmin/splashScreen/my_splash_screen.dart';
import 'package:amazonadmin/widgets/my_drawer.dart';
import 'package:amazonadmin/widgets/text_delegate_header_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  restrictBlockSeller() async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((snapshot) {
      if (snapshot.data()!["status"] != "approved") {
        showReusableSnackBar(context, "You are blocked byt admin ..");
        showReusableSnackBar(
            context, "Contact admin: 8420324760 or admin@gmail.com");
        FirebaseAuth.instance.signOut();
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MySplashScreen()));
      }
    });
  }

  getSellerEarningFromDatabase() {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .get()
        .then((dataSnapShot) {
      previousEarning = dataSnapShot.data()!["earnings"].toString();
    }).whenComplete(() {
      restrictBlockSeller();
    });
    restrictBlockSeller();
  }

  @override
  void initState() {
    super.initState();
    PushNotificationSystem pushNotificationSystem = PushNotificationSystem();
    pushNotificationSystem.whenNotificationReceived(context);
    pushNotificationSystem.generateDeviceRecognitionToken();
    getSellerEarningFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
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
          "Amazon Sellers App",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => const UploadBrandScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.upload,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextDelegateHeaderWidget(
              title: "My Brands",
            ),
          ),
          StreamBuilder(
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  itemBuilder: (context, index) {
                    Brands brandsModel = Brands.fromJson(
                      snapshot.data.docs[index].data() as Map<String, dynamic>,
                    );
                    return BrandsUiDesignWidget(
                      model: brandsModel,
                      context: context,
                    );
                  },
                  itemCount: snapshot.data.docs.length,
                  staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text("No brands exists"),
                  ),
                );
              }
            },
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .doc(sharedPreferences!.getString("uid"))
                .collection("brands")
                .orderBy("publishedDate", descending: true)
                .snapshots(),
          )
        ],
      ),
    );
  }
}
