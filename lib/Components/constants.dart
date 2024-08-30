import 'package:buy_and_earn/Utils/commons.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

const kAppVersion = "1.2.1";
const kAppBuild = "10";

final String welcomeImages = "assets/images/welcome-images";

final kIconMap = {
  'mobile': "$kServiceIcon/mobile.svg",
  'postpaid': "$kServiceIcon/postpaid.svg",
  'dth': "$kServiceIcon/dth.svg",
  'electricity': "$kServiceIcon/electricity.svg",
  'broadband': "$kServiceIcon/broadband.svg",
  'fasttag': "$kServiceIcon/fasttag.svg",
  'flight': "$kServiceIcon/flight.svg",
  'train': "$kServiceIcon/train.svg",
  'hotel': "$kServiceIcon/hotel.svg",
  'bus': "$kServiceIcon/bus.svg",
  'car': "$kServiceIcon/car.svg",
  'ecommerce': "$kServiceIcon/ecommerce.svg",
  'garments': "$kServiceIcon/garments.svg",
  'grocery': "$kServiceIcon/grocery.svg",
  'food': "$kServiceIcon/food.svg",
  'courier': "$kServiceIcon/courier.svg",
  'local': "$kServiceIcon/local.svg",
};

List<String> statesList = [
  'Andhra Pradesh',
  'Arunachal Pradesh',
  'Assam',
  'Bihar',
  'Chhattisgarh',
  'Goa',
  'Gujarat',
  'Haryana',
  'Himachal Pradesh',
  'Jharkhand',
  'Karnataka',
  'Kerala',
  'Madhya Pradesh',
  'Maharashtra',
  'Manipur',
  'Meghalaya',
  'Mizoram',
  'Nagaland',
  'Odisha',
  'Punjab',
  'Rajasthan',
  'Sikkim',
  'Tamil Nadu',
  'Telangana',
  'Tripura',
  'Uttar Pradesh',
  'Uttarakhand',
  'West Bengal',
  'Andaman and Nicobar Islands',
  'Chandigarh',
  'Dadra and Nagar Haveli and Daman and Diu',
  'Delhi',
  'Lakshadweep',
  'Puducherry',
  'Ladakh',
  'Jammu and Kashmir'
];

String encryptDecryptText(String action, String string) {
  final encryptMethod = encrypt.AESMode.cbc;
  final secretKey = 'buy-and-earn-2024';
  final secretIv = 'buy-and-earn-2024';

  final key =
      sha256.convert(utf8.encode(secretKey)).toString().substring(0, 32);
  final iv = sha256.convert(utf8.encode(secretIv)).toString().substring(0, 16);

  final encrypter = encrypt.Encrypter(
      encrypt.AES(encrypt.Key.fromUtf8(key), mode: encryptMethod));
  final ivObj = encrypt.IV.fromUtf8(iv);

  String output = '';

  if (action == 'encrypt') {
    final encrypted = encrypter.encrypt(string, iv: ivObj);
    output = encrypted.base64;
  } else if (action == 'decrypt') {
    final decrypted =
        encrypter.decrypt(encrypt.Encrypted.fromBase64(string), iv: ivObj);
    output = decrypted;
  }

  return output;
}

String kFormatDate(String val) {
  return DateFormat("dd-MM-yyyy").format(DateTime.parse(val));
}

String kFormatTime(String val) {
  return DateFormat("hh:mm a").format(
    DateFormat("HH:mm").parse(val),
  );
}

bool kCompare(String searchKey, String text) {
  return text.trim().toLowerCase().contains(searchKey.trim().toLowerCase());
}
