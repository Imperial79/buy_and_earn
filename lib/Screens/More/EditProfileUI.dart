// ignore_for_file: unused_result

import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Screens/More/KProfileCard.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kTextfield.dart';
import 'package:buy_and_earn/Utils/api_config.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Components/constants.dart';

class EditProfileUI extends ConsumerStatefulWidget {
  const EditProfileUI({super.key});

  @override
  ConsumerState<EditProfileUI> createState() => _EditProfileUIState();
}

class _EditProfileUIState extends ConsumerState<EditProfileUI> {
  bool isLoading = false;
  final name = TextEditingController();
  final email = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  final pincode = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final user = ref.read(customerProvider);
        if (user != null) {
          name.text = user.name;
          email.text = user.email ?? "";
          state.text = user.state;
          city.text = user.city;
          pincode.text = user.pinCode;
          setState(() {});
        }
      },
    );
  }

  _update() async {
    try {
      FocusScope.of(context).unfocus();
      setState(() {
        isLoading = true;
      });

      final res = await apiCallBack(
        path: "/users/update-profile",
        body: {
          "name": name.text,
          "email": email.text,
          "state": state.text,
          "city": city.text,
          "pincode": pincode.text,
        },
      );

      if (!res.error) {
        await ref.refresh(auth.future);
      }

      KSnackbar(context, content: res.message, isDanger: res.error);
    } catch (e) {
      kErrorSnack(context);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    state.dispose();
    city.dispose();
    pincode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final customer = ref.watch(customerProvider);
    return RefreshIndicator(
      onRefresh: () => ref.refresh(auth.future),
      child: KScaffold(
        isLoading: isLoading,
        loadingText: "Updating profile details...",
        appBar: KAppBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(kPadding),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KProfileCard(
                    isLoading: (loading) {},
                    showEdit: false,
                  ),
                  height20,
                  KTextfield(
                    controller: name,
                    label: "Name",
                    hintText: "${customer?.name}",
                    validator: (val) {
                      if (val!.isEmpty) return "Required!";
                      return null;
                    },
                  ).regular,
                  height10,
                  KTextfield(
                    controller: email,
                    label: "Email",
                    keyboardType: TextInputType.emailAddress,
                    hintText: "${customer?.name}",
                    validator: (val) => KValidation.email(val),
                  ).regular,
                  height10,
                  KTextfield(
                    controller: state,
                    label: "State",
                    hintText: "Select State",
                  ).dropdown(
                    dropdownMenuEntries: List.generate(
                      kStatesList.length,
                      (index) => DropdownMenuEntry(
                        label: kStatesList[index],
                        value: kStatesList[index],
                      ),
                    ),
                  ),
                  height10,
                  Row(
                    children: [
                      Flexible(
                        child: KTextfield(
                          controller: city,
                          label: "City",
                          keyboardType: TextInputType.text,
                          hintText: "Eg. Durgapur",
                          validator: (val) {
                            if (val!.isEmpty) return "Required!";
                            return null;
                          },
                        ).regular,
                      ),
                      width10,
                      Flexible(
                        child: KTextfield(
                          controller: pincode,
                          label: "Pincode",
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          hintText: "Eg. 7XXXX3",
                          validator: (val) {
                            if (val!.isEmpty || val.length != 6) {
                              return "Required!";
                            }
                            return null;
                          },
                        ).regular,
                      ),
                    ],
                  ),
                  height20,
                  KButton(
                    onPressed: () {
                      _update();
                    },
                    label: "Update",
                    icon: const Icon(
                      Icons.update,
                      color: Colors.black,
                    ),
                    backgroundColor: kColor4,
                    foregroundColor: Colors.black,
                  ).withIcon,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
