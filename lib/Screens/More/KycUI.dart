import 'dart:io';

import 'package:buy_and_earn/Components/widgets.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kButton.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kScaffold.dart';
import 'package:buy_and_earn/Utils/Common%20Widgets/kTextfield.dart';
import 'package:buy_and_earn/Utils/colors.dart';
import 'package:buy_and_earn/Utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class KycUI extends StatefulWidget {
  const KycUI({super.key});

  @override
  State<KycUI> createState() => _KycUIState();
}

class _KycUIState extends State<KycUI> {
  XFile? _aadharFront;
  XFile? _aadharBack;
  XFile? _pan;
  XFile? _passbook;
  final _nomName = new TextEditingController();
  final _nomPhone = new TextEditingController();
  String _nomRelation = "";
  XFile? _nomId;
  final _formKey = GlobalKey<FormState>();

  Future<XFile?> _pickImage({required ImageSource source}) async {
    return await ImagePicker().pickImage(
      source: source,
      imageQuality: 50,
    );
  }

  @override
  void dispose() {
    _nomName.dispose();
    _nomPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
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
                      Text(
                        "Upload Aadhaar card",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Photos must be clear and should be taken in a well lit room.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kLabel("Front Side"),
                      _imageCard(
                        onTap: () async {
                          _aadharFront =
                              await _pickImage(source: ImageSource.gallery);
                          setState(() {});
                        },
                        image: _aadharFront,
                      ),
                      kLabel("Back Side"),
                      _imageCard(
                        onTap: () async {
                          _aadharBack =
                              await _pickImage(source: ImageSource.gallery);
                          setState(() {});
                        },
                        image: _aadharBack,
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
                      Text(
                        "Upload PAN card",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Photos must be clear and should be taken in a well lit room.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kLabel("Front Side"),
                      _imageCard(
                        onTap: () async {
                          _pan = await _pickImage(source: ImageSource.gallery);
                          setState(() {});
                        },
                        image: _pan,
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
                      Text(
                        "Upload Bank Passbook / Cancelled Cheque",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Photos must be clear and should be taken in a well lit room.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      kLabel("Front Side"),
                      _imageCard(
                        onTap: () async {
                          _passbook =
                              await _pickImage(source: ImageSource.gallery);
                          setState(() {});
                        },
                        image: _passbook,
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
                      Text(
                        "Nominee Details",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Photos must be clear and should be taken in a well lit room.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      height20,
                      KTextfield.regular(
                        context,
                        hintText: "Eg. John Doe",
                        label: "Nominee Name",
                      ),
                      height20,
                      KTextfield.regular(
                        context,
                        hintText: "Eg. 909XXXXXXX",
                        label: "Nominee Phone",
                      ),
                      height20,
                      KTextfield.dropdown(
                        hintText: "Eg. Father, Son",
                        label: "Relation",
                        items: [
                          DropdownMenuEntry(value: "Father", label: "Father"),
                        ],
                        onSelect: (val) {
                          setState(() {
                            _nomRelation = "$val";
                          });
                        },
                      ),
                      kLabel("Nominee ID Proof (PAN / Aadhaar / Voter)"),
                      _imageCard(
                        onTap: () async {
                          _nomId =
                              await _pickImage(source: ImageSource.gallery);
                          setState(() {});
                        },
                        image: _nomId,
                      ),
                    ],
                  ),
                ),
                height20,
                KButton.full(
                  onPressed: () {},
                  backgroundColor: kColor4,
                  label: "Send for verification",
                  textColor: Colors.black,
                ),
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
              : null,
        ),
        child: image == null
            ? Center(
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
