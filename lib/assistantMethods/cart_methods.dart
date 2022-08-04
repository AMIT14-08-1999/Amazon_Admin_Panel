import 'package:amazonadmin/global/global.dart';

class CartMethods {
  separateItemIDUserCartList() {
    List<String>? userCartList = sharedPreferences!.getStringList("userCart");
    List<String> itemsIDsList = [];
    for (var i = 1; i < userCartList!.length; i++) {
      String item = userCartList[i].toString();
      var lastCharPosItemBeforeColon = item.lastIndexOf(":");
      String getItemId = item.substring(0, lastCharPosItemBeforeColon);
      itemsIDsList.add(getItemId);
    }
    return itemsIDsList;
  }

  separateItemQuantityFromUserCartList() {
    List<String>? userCartList = sharedPreferences!.getStringList("userCart");
    List<int> itemsQuantityList = [];
    for (var i = 1; i < userCartList!.length; i++) {
      String item = userCartList[i].toString();
      var colonAfterCharacterList = item.split(":").toList();
      var quantityNumber = int.parse(colonAfterCharacterList[1].toString());
      itemsQuantityList.add(quantityNumber);
    }
    return itemsQuantityList;
  }

  separateOrderItemIDs(productIDs) {
    List<String>? userCartList = List<String>.from(productIDs);
    List<String> itemsIDsList = [];
    for (var i = 1; i < userCartList.length; i++) {
      String item = userCartList[i].toString();
      var lastCharPosItemBeforeColon = item.lastIndexOf(":");
      String getItemId = item.substring(0, lastCharPosItemBeforeColon);
      itemsIDsList.add(getItemId);
    }
    return itemsIDsList;
  }

  separateOrderItemQuantity(productIDs) {
    List<String>? userCartList = List<String>.from(productIDs);
    List<String> itemsQuantityList = [];
    for (var i = 1; i < userCartList.length; i++) {
      String item = userCartList[i].toString();
      var colonAfterCharacterList = item.split(":").toList();
      var quantityNumber = int.parse(colonAfterCharacterList[1].toString());
      itemsQuantityList.add(quantityNumber.toString());
    }
    return itemsQuantityList;
  }
}
