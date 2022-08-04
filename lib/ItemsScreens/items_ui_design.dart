import 'package:amazonadmin/ItemsScreens/items_details_screen.dart';
import 'package:amazonadmin/models/items.dart';
import 'package:flutter/material.dart';

class ItemsUiDesignWidget extends StatefulWidget {
  Items? model;
  BuildContext? context;
  ItemsUiDesignWidget({
    Key? key,
    this.context,
    this.model,
  }) : super(key: key);

  @override
  State<ItemsUiDesignWidget> createState() => _BrandsUiDesignWidgetState();
}

class _BrandsUiDesignWidgetState extends State<ItemsUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => ItemsDetailsScreen(
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
            height: 280,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    widget.model!.itemTitle.toString(),
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Image.network(
                    widget.model!.thumbnailUrl.toString(),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    widget.model!.itemInfo.toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
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
