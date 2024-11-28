import 'package:buy_and_earn/Utils/CustomLoading.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../colors.dart';

class KScaffold extends ConsumerStatefulWidget {
  final bool? isLoading;
  final String? loadingText;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  const KScaffold(
      {super.key,
      this.isLoading,
      this.appBar,
      required this.body,
      this.bottomNavigationBar,
      this.loadingText,
      this.floatingActionButton,
      this.floatingActionButtonLocation});

  @override
  ConsumerState<KScaffold> createState() => _KScaffoldState();
}

class _KScaffoldState extends ConsumerState<KScaffold> {
  @override
  Widget build(BuildContext context) {
    // final hasInternet = ref.watch(internetStream);

    return Stack(
      children: [
        Scaffold(
          appBar: widget.appBar,
          body: widget.body,
          floatingActionButton: widget.floatingActionButton,
          floatingActionButtonLocation: widget.floatingActionButtonLocation,
          bottomNavigationBar: widget.bottomNavigationBar,
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: widget.isLoading ?? false
              ? kFullLoading(context, loadingText: widget.loadingText)
              : const SizedBox(),
        ),
      ],
    );
  }
}

AppBar KAppBar(
  BuildContext context, {
  String title = "",
  bool isLoading = false,
  bool showBack = true,
  List<Widget>? actions,
  bool showOriginal = false,
}) {
  String title0 = title;
  if (!showOriginal) title0 = title.toLowerCase();
  return AppBar(
    leading: showBack
        ? IconButton.filled(
            onPressed: () {
              Navigator.pop(context);
            },
            style: IconButton.styleFrom(
              backgroundColor: Light.card,
              side: const BorderSide(color: Light.border),
            ),
            padding: const EdgeInsets.all(5),
            icon: const Icon(
              Icons.arrow_back,
            ),
          )
        : null,
    leadingWidth: 70,
    title: Text(
      title0,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    ),
    automaticallyImplyLeading: false,
    actions: actions,
    titleSpacing: showBack ? 0 : 20,
    titleTextStyle: const TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: 'Jakarta',
      letterSpacing: .1,
    ),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: isLoading
          ? const LinearProgressIndicator(
              minHeight: 2,
              color: Light.primary,
              backgroundColor: Colors.white,
            )
          : const SizedBox(
              height: 2,
            ),
    ),
  );
}

Container kFullLoading(BuildContext context, {String? loadingText}) {
  return Container(
    height: double.infinity,
    width: double.infinity,
    alignment: Alignment.center,
    color: Colors.white.withOpacity(0.8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomLoading(),
        height20,
        Text(
          loadingText ?? "Please wait...",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 17,
                letterSpacing: .5,
              ),
        ),
      ],
    ),
  );
}
