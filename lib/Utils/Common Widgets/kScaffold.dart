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
        // hasInternet.when(
        //   data: (data) => data == InternetStatus.disconnected
        //       ? _noInternetPill(context)
        //       : Container(),
        //   error: (error, stackTrace) => SizedBox(),
        //   loading: () => SizedBox(),
        // ),
      ],
    );
  }

  Align _noInternetPill(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: kColor(context).errorContainer,
            borderRadius: kRadius(100),
            boxShadow: [
              BoxShadow(
                color: kColor(context).errorContainer.withOpacity(.5),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.signal_wifi_connected_no_internet_4_rounded,
                color: kColor(context).onErrorContainer,
              ),
              width10,
              Text(
                "No Internet",
                style: TextStyle(
                  color: kColor(context).onErrorContainer,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
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
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (showBack)
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const RotatedBox(
                quarterTurns: 10,
                child: Icon(
                  Icons.arrow_right_alt_sharp,
                  size: 30,
                ),
              ),
              visualDensity: VisualDensity.compact,
            ),
          ),
        Text(
          title0,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ],
    ),
    automaticallyImplyLeading: false,
    actions: actions,
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
              color: kPrimaryColor,
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
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            loadingText ?? "Please wait...",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  letterSpacing: .7,
                ),
          ),
        ),
        SizedBox(
          width: 60,
          child: LinearProgressIndicator(
            backgroundColor: kSecondaryColor,
            color: kPrimaryColor,
            minHeight: 6,
          ),
        ),
      ],
    ),
  );
}
