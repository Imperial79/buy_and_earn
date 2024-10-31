import 'package:buy_and_earn/Utils/commons.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

const kAppVersion = "1.0.8";
const kAppBuild = "8";

const String kImagePath = "assets/images";
const String welcomeImages = "$kImagePath/welcome-images";

final kRelationList = [
  "Mother",
  "Father",
  "Son",
  "Daughter",
  "Spouse",
  'Legal Guardian'
];

final kIconMap = {
  'Prepaid': "$kServiceIcon/mobile.svg",
  'Postpaid': "$kServiceIcon/postpaid.svg",
  'DTH': "$kServiceIcon/dth.svg",
  'Electricity': "$kServiceIcon/electricity.svg",
  'Broadband': "$kServiceIcon/broadband.svg",
  'Fastag': "$kServiceIcon/fasttag.svg",
  'Flight': "$kServiceIcon/flight.svg",
  'Train': "$kServiceIcon/train.svg",
  'Hotel': "$kServiceIcon/hotel.svg",
  'Bus': "$kServiceIcon/bus.svg",
  'Car': "$kServiceIcon/car.svg",
  'Ecommerce': "$kServiceIcon/ecommerce.svg",
  'Garments': "$kServiceIcon/garments.svg",
  'Grocery': "$kServiceIcon/grocery.svg",
  'Food': "$kServiceIcon/food.svg",
  'Courier': "$kServiceIcon/courier.svg",
  'Local': "$kServiceIcon/local.svg",
  'Club House': "$kServiceIcon/club.svg",
  'Commission': "$kServiceIcon/commission.svg",
  'Refund': "$kServiceIcon/refund.svg",
  'Wallet': "$kServiceIcon/wallet.svg",
  'Gift': "$kServiceIcon/gift.svg",
};

// final kColorMap = {
//   'Failed': Colors.red.shade600,
//   'Pending': Colors.amber.shade600,
//   'Success': Colors.green.shade600,
// };

List<String> kStatesList = [
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

String sanitizeContact(String phoneNumber) {
  String sanitized = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

  if (sanitized.startsWith('0')) {
    sanitized = sanitized.substring(1);
  }

  if (sanitized.startsWith("+91")) {
    sanitized = sanitized.substring(3);
  }

  return sanitized;
}

String encryptDecryptText(String action, String string) {
  const encryptMethod = encrypt.AESMode.cbc;
  const secretKey = 'buy-and-earn-2024';
  const secretIv = 'buy-and-earn-2024';

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

String kFormatDateInWords(String val) {
  return DateFormat("dd MMM, yyyy").format(DateTime.parse(val));
}

String kFormatTime(String val) {
  return DateFormat("hh:mm a").format(
    DateFormat("HH:mm").parse(val),
  );
}

bool kCompare(String searchKey, String text) {
  return text.trim().toLowerCase().contains(searchKey.trim().toLowerCase());
}

String kCurrencyFormat(dynamic number, {int decimalDigit = 2}) {
  var f = NumberFormat.currency(
    symbol: "₹ ",
    locale: 'en_US',
    decimalDigits: decimalDigit,
  );
  return f.format(double.parse("$number"));
}
