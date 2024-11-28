import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Models/mobile_recharge_modal.dart';
import 'package:buy_and_earn/Models/recharge_model.dart';
import 'package:buy_and_earn/Repository/recharge_repository.dart';
import 'package:buy_and_earn/Screens/Services%20Screens/Recharge/Mobile%20Recharge/Mobile_Recharge_UI.dart';
import 'package:buy_and_earn/Screens/Services%20Screens/Recharge/Recharge_UI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Providers_UI extends ConsumerStatefulWidget {
  final String service;
  const Providers_UI({
    super.key,
    required this.service,
  });

  @override
  ConsumerState<Providers_UI> createState() => _Mobile_Providers_UIState();
}

class _Mobile_Providers_UIState extends ConsumerState<Providers_UI> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    // ignore: unused_result
    await ref.refresh(providersListFuture(widget.service).future);
  }

  @override
  Widget build(BuildContext context) {
    final providersListData = ref.watch(providersListFuture(widget.service));
    return RefreshIndicator(
      onRefresh: () => ref.refresh(providersListFuture(widget.service).future),
      child: KScaffold(
        appBar: KAppBar(
          context,
          title: "Select Provider",
          showBack: true,
          isLoading: providersListData.isLoading,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kPadding),
            child: providersListData.when(
              data: (data) => data.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (context, index) => height10,
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          if (["Prepaid", "Postpaid"]
                              .contains(widget.service)) {
                            navPush(
                              context,
                              Mobile_Recharge_UI(
                                masterdata: Mobile_Recharge_Model(
                                  service: widget.service,
                                  providerId: data[index]['providerId'],
                                  providerName:
                                      "${data[index]['providerName']}",
                                  providerImage: "${data[index]['image']}",
                                ),
                              ),
                            );
                          } else if (["DTH"].contains(widget.service)) {
                            navPush(
                              context,
                              Recharge_UI(
                                masterdata: Recharge_Model(
                                  service: widget.service,
                                  providerId:
                                      int.parse("${data[index]['providerId']}"),
                                  providerName: data[index]['providerName'],
                                  providerImage: data[index]['image'],
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          color: Light.card,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 45,
                                height: 45,
                                child: CachedNetworkImage(
                                  imageUrl: data[index]["image"],
                                  fit: BoxFit.contain,
                                ),
                              ),
                              width20,
                              Expanded(
                                child: Text(
                                  data[index]["providerName"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : kNoData(
                      title: "No providers right now!",
                      subtitle: "Please come back later!"),
              error: (error, stackTrace) =>
                  const Text("Unable to load providers!"),
              loading: () => const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}
