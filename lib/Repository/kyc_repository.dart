import 'package:flutter_riverpod/flutter_riverpod.dart';

final kyc_repository = Provider(
  (ref) => KycRepository(),
);

final showKycBanner = StateProvider(
  (ref) => true,
);

class KycRepository {}
