import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HelpUI extends ConsumerStatefulWidget {
  const HelpUI({super.key});

  @override
  ConsumerState<HelpUI> createState() => _HelpUIState();
}

class _HelpUIState extends ConsumerState<HelpUI> {
  String _directChatLink =
      "https://tawk.to/chat/66a273a032dca6db2cb5b09a/1i3l97av8";
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return KScaffold(
      body: SafeArea(
        child: Tawk(
          onLinkTap: (link) {
            launchUrlString(link, mode: LaunchMode.externalApplication);
          },
          directChatLink: _directChatLink,
          visitor: TawkVisitor(
            name: '${user!.name}',
            email: '${user.email}',
          ),
        ),
      ),
    );
  }
}
