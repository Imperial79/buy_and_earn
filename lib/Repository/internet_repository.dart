// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final hasInternetProvider = StateProvider<bool>((ref) => false);

// final internetStream = StreamProvider((ref) {
//   InternetConnection _connectionChecker = InternetConnection();
//   return _connectionChecker.onStatusChange.map((status) {
//     ref.read(hasInternetProvider.notifier).state =
//         status == InternetStatus.connected;
//     return status;
//   });
// });
