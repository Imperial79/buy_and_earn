import 'package:buy_and_earn/Repository/mobile_recharge_repository.dart';
import 'package:buy_and_earn/Screens/Services%20Screens/Mobile_Recharge_UI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Mobile_Providers_UI extends ConsumerStatefulWidget {
  const Mobile_Providers_UI({super.key});

  @override
  ConsumerState<Mobile_Providers_UI> createState() =>
      _Mobile_Providers_UIState();
}

class _Mobile_Providers_UIState extends ConsumerState<Mobile_Providers_UI> {
  @override
  Widget build(BuildContext context) {
    final providersListData = ref.watch(providersListFuture);
    return KScaffold(
      appBar: KAppBar(context, title: "Select Provider", showBack: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(kPadding),
          child: providersListData.when(
            data: (data) => ListView.separated(
              separatorBuilder: (context, index) => height10,
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  navPush(
                    context,
                    Mobile_Recharge_UI(
                      providerId: "${data[index]["providerId"]}",
                      providerName: data[index]["providerName"],
                      providerImage: data[index]["image"],
                    ),
                  );
                },
                contentPadding: EdgeInsets.all(10),
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
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            error: (error, stackTrace) => Text("Unable to load providers!"),
            loading: () => LinearProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
