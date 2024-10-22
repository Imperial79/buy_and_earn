// ignore_for_file: unused_result

import 'dart:io';
import 'package:buy_and_earn/Components/constants.dart';
import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Repository/auth_repository.dart';
import 'package:buy_and_earn/Repository/kyc_repository.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kTextfield.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class KycUI extends ConsumerStatefulWidget {
  const KycUI({super.key});

  @override
  ConsumerState<KycUI> createState() => _KycUIState();
}

class _KycUIState extends ConsumerState<KycUI> {
  bool isLoading = false;
  XFile? _adhaarFront;
  XFile? _adhaarBack;
  XFile? _panFront;
  final _pan = TextEditingController();
  XFile? _bankFront;
  final _nomineeName = TextEditingController();
  final _nomineePhone = TextEditingController();
  final _relation = TextEditingController();
  XFile? _nomineeId;
  final _formKey = GlobalKey<FormState>();
  Map? serverData;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    setState(() {
      isLoading = true;
    });
    final res = await ref.read(kyc_repository).fetchKycData();
    if (!res.error) {
      serverData = res.response;
      _pan.text = res.response["pan"];
      _nomineeName.text = res.response["nomineeName"];
      _nomineePhone.text = res.response["nomineePhone"];
      _relation.text = res.response["relation"];
      setState(() {});
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<XFile?> _pickImage({required ImageSource source}) async {
    return await ImagePicker().pickImage(
      source: source,
      imageQuality: 50,
    );
  }

  Future<void> _uploadData() async {
    try {
      setState(() {
        isLoading = true;
      });

      final res = await ref.read(kyc_repository).uploadKycData(
        body: {
          "adhaarFront": _adhaarFront != null
              ? await MultipartFile.fromFile(_adhaarFront!.path)
              : "",
          "adhaarBack": _adhaarBack != null
              ? await MultipartFile.fromFile(_adhaarBack!.path)
              : "",
          "panFront": _panFront != null
              ? await MultipartFile.fromFile(_panFront!.path)
              : "",
          "pan": _pan.text.trim(),
          "nomineeName": _nomineeName.text.trim(),
          "nomineePhone": _nomineePhone.text.trim(),
          "relation": _relation.text.trim(),
          "bankFront": _bankFront != null
              ? await MultipartFile.fromFile(_bankFront!.path)
              : "",
          "nomineeId": _nomineeId != null
              ? await MultipartFile.fromFile(_nomineeId!.path)
              : "",
        },
      );
      if (!res.error) {
        ref.refresh(auth.future);
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
    _nomineeName.dispose();
    _nomineePhone.dispose();
    _pan.dispose();
    _relation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      isLoading: isLoading,
      loadingText: "Uploading data...",
      appBar: KAppBar(context, title: "kyc"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(kPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kCard(
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Upload Aadhaar card",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "Photos must be clear and should be taken in a well lit room.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kLabel("Front Side"),
                      _imageCard(
                        onTap: () async {
                          _adhaarFront =
                              await _pickImage(source: ImageSource.gallery);
                          setState(() {});
                        },
                        image: _adhaarFront,
                        imageLink: serverData?["adhaarFront"],
                      ),
                      kLabel("Back Side"),
                      _imageCard(
                        onTap: () async {
                          _adhaarBack =
                              await _pickImage(source: ImageSource.gallery);
                          setState(() {});
                        },
                        image: _adhaarBack,
                        imageLink: serverData?["adhaarBack"],
                      ),
                    ],
                  ),
                ),
                height20,
                kCard(
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Upload PAN card",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "Photos must be clear and should be taken in a well lit room.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kLabel("Front Side"),
                      _imageCard(
                        onTap: () async {
                          _panFront =
                              await _pickImage(source: ImageSource.gallery);
                          setState(() {});
                        },
                        image: _panFront,
                        imageLink: serverData?["panFront"],
                      ),
                      height15,
                      KTextfield(
                        controller: _pan,
                        textCapitalization: TextCapitalization.characters,
                        hintText: "Eg. CHDPXXXXXA",
                        maxLength: 10,
                        label: "PAN Number",
                        validator: (val) {
                          if (val!.isEmpty) return "Required!";
                          return null;
                        },
                      ).regular,
                    ],
                  ),
                ),
                height20,
                kCard(
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Upload Bank Passbook / Cancelled Cheque",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "Photos must be clear and should be taken in a well lit room.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kLabel("Front Side"),
                      _imageCard(
                        onTap: () async {
                          _bankFront =
                              await _pickImage(source: ImageSource.gallery);
                          setState(() {});
                        },
                        image: _bankFront,
                        imageLink: serverData?["bankFront"],
                      ),
                    ],
                  ),
                ),
                height20,
                kCard(
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Nominee Details",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "Photos must be clear and should be taken in a well lit room.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      height20,
                      KTextfield(
                        controller: _nomineeName,
                        hintText: "Eg. John Doe",
                        label: "Nominee Name",
                        validator: (val) {
                          if (val!.isEmpty) return "Required!";
                          return null;
                        },
                      ).regular,
                      height20,
                      KTextfield(
                        controller: _nomineePhone,
                        keyboardType: TextInputType.phone,
                        prefixText: "+91",
                        hintText: "Eg. 909XXXXXXX",
                        label: "Nominee Phone",
                        maxLength: 10,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Required!";
                          } else if (val.length != 10)
                            return "Length must be 10!";
                          return null;
                        },
                      ).regular,
                      height20,
                      KTextfield(
                        controller: _relation,
                        hintText: "Eg. Mother or Son",
                        label: "Relation",
                      ).dropdown(
                        dropdownMenuEntries: List.generate(
                          kRelationList.length,
                          (index) => DropdownMenuEntry(
                            value: kRelationList[index],
                            label: kRelationList[index],
                          ),
                        ),
                      ),
                      kLabel("Nominee ID Proof (PAN / Aadhaar / Voter)"),
                      _imageCard(
                        onTap: () async {
                          _nomineeId =
                              await _pickImage(source: ImageSource.gallery);
                          setState(() {});
                        },
                        image: _nomineeId,
                        imageLink: serverData?["nomineeId"],
                      ),
                    ],
                  ),
                ),
                height20,
                KButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_relation.text.isNotEmpty) {
                        _uploadData();
                      } else {
                        KSnackbar(context,
                            content: "Select relation!", isDanger: true);
                      }
                    }
                  },
                  backgroundColor: kColor4,
                  label: "Update KYC Details",
                  foregroundColor: Colors.black,
                ).full,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageCard({
    void Function()? onTap,
    XFile? image,
    String? imageLink,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: kRadius(10),
          color: Colors.grey.shade300,
          image: image != null
              ? DecorationImage(image: FileImage(File(image.path)))
              : imageLink != null
                  ? DecorationImage(image: NetworkImage(imageLink))
                  : null,
        ),
        child: image == null && imageLink == null
            ? const Center(
                child: Text(
                  "Choose Image",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
