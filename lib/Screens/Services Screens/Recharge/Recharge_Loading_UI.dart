// ignore_for_file: unused_result

import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Repository/notification_methods.dart';
import 'package:buy_and_earn/Repository/recharge_repository.dart';
import 'package:buy_and_earn/Repository/wallet_repository.dart';
import 'package:buy_and_earn/Screens/RootUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Recharge_Loading_UI extends ConsumerStatefulWidget {
  final String service;
  final int providerId;
  final String consumerNo;
  final double amount;
  final String tpin;
  const Recharge_Loading_UI(
      {super.key,
      required this.service,
      required this.providerId,
      required this.consumerNo,
      required this.amount,
      required this.tpin});

  @override
  ConsumerState<Recharge_Loading_UI> createState() =>
      _Recharge_Loading_UIState();
}

class _Recharge_Loading_UIState extends ConsumerState<Recharge_Loading_UI> {
  bool isLoading = true;
  bool isSuccess = false;
  String errorText = "";

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (["Prepaid", "Postpaid"].contains(widget.service)) {
          _rechargeMobile();
        } else {
          _recharge();
        }
      },
    );
  }

  _recharge() async {
    try {
      final res = await ref.read(mobile_recharge_repository).recharge(
            providerId: widget.providerId,
            consumerNo: widget.consumerNo,
            tpin: widget.tpin,
            rechargeAmount: widget.amount,
          );

      if (!res.error) {
        await ref.read(sendNotificationRepository).localNotification(
              title: "Recharge Successful!",
              body:
                  "Recharge successful of ₹${widget.amount} on +91 ${widget.consumerNo}.",
            );
      } else {
        await ref.read(sendNotificationRepository).localNotification(
              title: "Recharge Failed!",
              body:
                  "Recharge failed for ₹${widget.amount} on +91 ${widget.consumerNo}.",
            );
        errorText = res.message;
      }

      isSuccess = !res.error;

      if (ref.read(customerProvider)!.status == "Pending") {
        await ref.refresh(auth.future);
      }
      await ref.refresh(walletFuture.future);
    } catch (e) {
      errorText = "$e";
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _rechargeMobile() async {
    try {
      final res = await ref.read(mobile_recharge_repository).rechargeMobile(
            providerId: widget.providerId,
            consumerNo: widget.consumerNo,
            tpin: widget.tpin,
            rechargeAmount: widget.amount,
          );

      if (!res.error) {
        await ref.read(sendNotificationRepository).localNotification(
              title: "Recharge Successful!",
              body:
                  "Recharge successful of ₹${widget.amount} on +91 ${widget.consumerNo}.",
            );
      } else {
        await ref.read(sendNotificationRepository).localNotification(
              title: "Recharge Failed!",
              body:
                  "Recharge failed for ₹${widget.amount} on +91 ${widget.consumerNo}.",
            );
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
      canPop: true,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLoading
                      ? const SizedBox(
                          height: 200,
                          width: 200,
                          child: CircularProgressIndicator(
                            strokeWidth: 10,
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: isSuccess
                              ? Colors.green.shade700
                              : Colors.red.shade700,
                          radius: 50,
                          child: isSuccess
                              ? const Icon(
                                  Icons.done,
                                  size: 50,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.error,
                                  size: 50,
                                  color: Colors.white,
                                ),
                        ),
                  height20,
                  ["Prepaid", "Postpaid"].contains(widget.service)
                      ? Text(
                          isLoading
                              ? "Please Wait..."
                              : isSuccess
                                  ? "Recharge successful of ₹${widget.amount} on\n+91 ${widget.consumerNo}."
                                  : "Recharge failed of ₹${widget.amount} on\n+91 ${widget.consumerNo}.",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          isLoading
                              ? "Please Wait..."
                              : isSuccess
                                  ? "Recharge successful of ₹${widget.amount} on\n${widget.consumerNo}."
                                  : "Recharge failed for ₹${widget.amount} on\n${widget.consumerNo}.",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                  height50,
                  Visibility(
                    visible: isLoading,
                    child: const Text(
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
                      margin: const EdgeInsets.only(top: 20),
                      color: const Color(0xFFFFDEE1),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
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
              padding: const EdgeInsets.all(20.0),
              child: KButton(
                backgroundColor: kSecondaryColor,
                onPressed: () {
                  navPopUntilPush(context, const RootUI());
                },
                label: "Go Home",
              ).full,
            ),
          ),
        ),
      ),
    );
  }
}
