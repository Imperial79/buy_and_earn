import 'package:animations/animations.dart';
import 'package:buy_and_earn/Screens/Home/HomeUI.dart';
import 'package:buy_and_earn/Screens/More/MoreUI.dart';
import 'package:buy_and_earn/Screens/Refer/ReferUI.dart';
import 'package:buy_and_earn/Screens/Transactions/TransactionsUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/KBottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationProvider = StateProvider<int>((ref) => 0);

class RootUI extends ConsumerStatefulWidget {
  // final bool isExit;
  const RootUI({
    super.key,
    // this.isExit = false,
  });

  @override
  ConsumerState<RootUI> createState() => _RootUIState();
}

class _RootUIState extends ConsumerState<RootUI> {
  bool isLoading = false;
  final _screens = [
    const HomeUI(),
    const ReferUI(),
    const TransactionsUI(),
    const MoreUI(),
  ];

  // @override
  // void initState() {
  //   super.initState();

  //   // WidgetsBinding.instance.addPostFrameCallback(
  //   //   (timeStamp) {
  //   //     if (!ref.read(isModalShown)) _showMembershipDialog();
  //   //   },
  //   // );
  // }
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (timeStamp) => _init(),
    // );
  }

  // _init() {
  //   if (!ref.read(customerProvider)!.isKycDone) {
  //     ref.read(sendNotificationRepository).localNotification(
  //           title: "KYC Pending",
  //           body: "Upload documents to complete your KYC.",
  //         );
  //   }
  // }

  // Future<void> _buyMembership() async {
  //   try {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     Map? data = await navPush(context, TPin_UI()) as Map?;

  //     if (data != null) {
  //       final res =
  //           await ref.read(clubHouseRepository).buyMembership(data["tpin"]);

  //       KSnackbar(context, content: res.message, isDanger: res.error);
  //     }
  //   } catch (e) {
  //     KSnackbar(context, content: "Something went wrong!", isDanger: true);
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  // Future<void> _showMembershipDialog() async {
  //   return await showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     elevation: 0,
  //     builder: (context) => SingleChildScrollView(
  //       child: kClubModal(
  //         context,
  //         onPressed: () async {
  //           Navigator.pop(context);
  //           await _buyMembership();
  //         },
  //       ),
  //     ),
  //   ).then(
  //     (value) {
  //       ref.read(isModalShown.notifier).state = true;
  //     },
  //   );
  // }

  bool canPop = false;
  // _popScope() {
  //   setState(() {
  //     canPop = true;
  //   });

  //   KSnackbar(
  //     context,
  //     content: "Click back again to exit...",
  //     isDanger: false,
  //     showIcon: false,
  //   );

  //   Future.delayed(
  //     const Duration(seconds: 3),
  //     () {
  //       setState(() {
  //         canPop = false;
  //       });
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final activeIndex = ref.watch(navigationProvider);

    return KScaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageTransitionSwitcher(
            transitionBuilder: (child, animation, secondaryAnimation) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                fillColor: Theme.of(context).colorScheme.surface,
                child: child,
              );
            },
            child: _screens[activeIndex],
          ),
          const Kbottomnavbar(),
        ],
      ),
    );
  }
}
