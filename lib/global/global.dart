import 'package:amazonadmin/assistantMethods/cart_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPreferences;
CartMethods cartMethods = CartMethods();

String previousEarning = "";
String fcmServerToken =
    "key=AAAAfKkvPu8:APA91bG3WS25ilqsxHj1wFE9rwwOYGCCAK7ytdLCjAsx6-oZ9Y1xW9wITZ9B878uJ2em0dwnBTOOtcxpFmSoQGL0PHy7EXy6MkqHEgThDTVDrTwD8qVFgVS2_7qjJUUieGr3DqAmU9Qt";
