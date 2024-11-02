// ignore_for_file: unused_result

import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Screens/More/EditProfileUI.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../Utils/colors.dart';

class KProfileCard extends ConsumerStatefulWidget {
  final bool showEdit;
  final void Function(bool) isLoading;
  const KProfileCard({
    super.key,
    this.showEdit = true,
    required this.isLoading,
  });

  @override
  ConsumerState<KProfileCard> createState() => _KProfileCardState();
}

class _KProfileCardState extends ConsumerState<KProfileCard> {
  XFile? _image;
  Future<XFile?> _pickImage({required ImageSource source}) async {
    return await ImagePicker().pickImage(
      source: source,
      imageQuality: 50,
    );
  }

  Future<void> _updateDp() async {
    try {
      setState(() {
        widget.isLoading(true);
      });
      final res = await ref.read(authRepository).updateDp(_image!);
      if (!res.error) {
        ref.refresh(auth.future);
      }
      KSnackbar(context, content: res.message, isDanger: res.error);
    } finally {
      setState(() {
        widget.isLoading(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final customer = ref.watch(customerProvider);
    return customer != null
        ? kCard(
            isPremium: customer.isMember,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      elevation: 0,
                      backgroundColor: Colors.white,
                      builder: (context) => SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: SafeArea(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Update Profile Image",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                height20,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      child: IconButton(
                                        onPressed: () async {
                                          _image = await _pickImage(
                                              source: ImageSource.camera);
                                          if (_image != null) {
                                            Navigator.pop(context);
                                          }
                                          setState(() {});
                                          _updateDp();
                                        },
                                        icon: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.camera_alt,
                                              color: Light.primary,
                                            ),
                                            height20,
                                            const Text(
                                              "Camera",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: IconButton(
                                        onPressed: () async {
                                          _image = await _pickImage(
                                              source: ImageSource.gallery);
                                          if (_image != null) {
                                            Navigator.pop(context);
                                            _updateDp();
                                          }
                                          setState(() {});
                                        },
                                        icon: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.photo_sharp,
                                              color: Light.primary,
                                            ),
                                            height20,
                                            const Text(
                                              "Gallery",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: customer.dp != null
                      ? CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(customer.dp!),
                        )
                      : CircleAvatar(
                          radius: 30,
                          child: Text(customer.name[0]),
                        ),
                ),
                width20,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              customer.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          width10,
                          kWidgetPill(
                            context,
                            backgroundColor: Colors.amberAccent.shade100,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            child: Row(
                              children: [
                                if (customer.isMember)
                                  const Text(
                                    "Member | ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                    ),
                                  ),
                                Text(
                                  "Lvl. ${customer.level}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      height5,
                      Text("+91 ${customer.phone}"),
                      Text("${customer.email}"),
                      if (widget.showEdit)
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: KButton(
                            onPressed: () {
                              navPush(context, const EditProfileUI());
                            },
                            label: "Edit",
                            backgroundColor: Light.quarternary,
                            foregroundColor: Colors.black,
                          ).pill,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
