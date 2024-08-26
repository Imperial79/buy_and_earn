import 'package:buy_and_earn/Repository/mobile_recharge_repository.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Recharge_Loading_UI extends ConsumerStatefulWidget {
  final String providerId;
  final String phone;
  final String amount;
  final String tpin;
  const Recharge_Loading_UI(
      {super.key,
      required this.providerId,
      required this.phone,
      required this.amount,
      required this.tpin});

  @override
  ConsumerState<Recharge_Loading_UI> createState() =>
      _Recharge_Loading_UIState();
}

class _Recharge_Loading_UIState extends ConsumerState<Recharge_Loading_UI> {
  bool isLoading = true;
  bool? isSuccess;
  String errorText = "";

  @override
  void initState() {
    super.initState();
    _rechargeMobile();
  }

  _rechargeMobile() async {
    try {
      final res = await ref.read(mobile_recharge_repository).rechargeMobile(
            providerId: widget.providerId,
            mobile: widget.phone,
            tpin: widget.tpin,
            rechargeAmount: widget.amount,
          );
      await Future.delayed(Duration(seconds: 5));
      if (res.error) {
        errorText = res.message;
      }
      isSuccess = !res.error;
    } catch (e) {
      errorText = "$e";
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !isLoading,
      child: Scaffold(
        backgroundColor: isSuccess == null
            ? Colors.white
            : isSuccess!
                ? Colors.green.shade100
                : Colors.red.shade100,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLoading
                      ? SizedBox(
                          height: 200,
                          width: 200,
                          child: CircularProgressIndicator(
                            strokeWidth: 10,
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: isSuccess!
                              ? Colors.greenAccent.shade700
                              : Colors.redAccent.shade700,
                          radius: 100,
                          child: isSuccess!
                              ? Icon(
                                  Icons.done,
                                  size: 100,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.error,
                                  size: 100,
                                  color: Colors.white,
                                ),
                        ),
                  height20,
                  Text(
                    isLoading
                        ? "Please Wait..."
                        : isSuccess!
                            ? "Recharge Successful!"
                            : "Recharge Failed!",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  height50,
                  Visibility(
                    visible: isLoading,
                    child: Text(
                      "Do not leave the page or exit the app",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: errorText.isNotEmpty,
                    child: Card(
                      margin: EdgeInsets.only(top: 20),
                      color: const Color(0xFFFFDEE1),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.error,
                              color: Colors.red.shade700,
                            ),
                            width10,
                            Expanded(
                              child: Text(
                                errorText,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SafeArea(
          child: Visibility(
            visible: !isLoading,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: KButton.full(
                backgroundColor: kPrimaryColor,
                onPressed: () {
                  navPopUntilPush(context, RootUI());
                },
                label: "Go Home",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
