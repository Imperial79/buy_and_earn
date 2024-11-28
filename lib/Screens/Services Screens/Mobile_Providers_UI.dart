import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Models/mobile_recharge_modal.dart';
import 'package:buy_and_earn/Repository/recharge_repository.dart';
import 'package:buy_and_earn/Screens/Services%20Screens/Recharge/Mobile%20Recharge/Mobile_Recharge_UI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Mobile_Providers_UI extends ConsumerStatefulWidget {
  final String service;
  const Mobile_Providers_UI({
    super.key,
    required this.service,
  });

  @override
  ConsumerState<Mobile_Providers_UI> createState() =>
      _Mobile_Providers_UIState();
}

class _Mobile_Providers_UIState extends ConsumerState<Mobile_Providers_UI> {
  @override
  Widget build(BuildContext context) {
    final providersListData = ref.watch(providersListFuture(widget.service));
    return KScaffold(
      appBar: KAppBar(context, title: "Select Provider", showBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPadding),
          child: providersListData.when(
            data: (data) => data.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, index) => height10,
                    itemCount: data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        navPush(
                          context,
                          Mobile_Recharge_UI(
                            masterdata: Mobile_Recharge_Model(
                              service: widget.service,
                              providerId:
                                  int.parse("${data[index]['providerId']}"),
                              providerName: data[index]['providerName'],
                              providerImage: data[index]['image'],
                            ),
                          ),
                        );
                      },
                      contentPadding: const EdgeInsets.all(10),
                      tileColor: Colors.white,
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              data[index]["image"],
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      title: Text(
                        data[index]["providerName"],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  )
                : kNoData(
                    title: "No Providers!", subtitle: "Check back later!"),
            error: (error, stackTrace) =>
                const Text("Unable to load providers!"),
            loading: () => const LinearProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
