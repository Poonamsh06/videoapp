import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../controllers/Auth/email_controller.dart';
import '../../controllers/Video/profile_controller.dart';
import '../../helpers/firebase_helper.dart';
import '../../models/userModel.dart';
import '../../utilities/constants.dart';
import '../../utilities/myDialogBox.dart';
import '../home.dart';

class ProfileFillUpScreen extends StatefulWidget {
  User user;

  ProfileFillUpScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ProfileFillUpScreen> createState() => _ProfileFillUpScreenState();
}

class _ProfileFillUpScreenState extends State<ProfileFillUpScreen> {
  File? imageFile;
  bool isImage = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _profScr = ProfileController();
  CountryCode countryCode = CountryCode(code: 'IN', dialCode: '+91');
  bool settingDataOver = false;

  void showPhotoOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: const Text('Choose a photo'),
            onTap: () {
              _selectImage(ImageSource.gallery);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera_rounded),
            title: const Text('Take a photo'),
            onTap: () {
              _selectImage(ImageSource.camera);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _setUserData() async {
    final userModel =
        await FirebaseHelper.fetchUserDetailsByUid(uid: widget.user.uid);

    if (userModel == null) return;

    _emailController.text = userModel.email!;
    if (userModel.phone == '') {
      _phoneController.text = userModel.phone!;
    } else {
      _phoneController.text = userModel.phone!.substring(3);
    }

    setState(() => settingDataOver = true);
  }

  void _selectImage(ImageSource source) async {
    var imageFileRec = await _profScr.selectImageOfController(source);

    if (imageFileRec == null) return;

    setState(() {
      isImage = true;
      imageFile = imageFileRec;
    });
  }

  void _checkValues() {
    if (imageFile == null || isImage == false) {
      MyDialogBox.showDefaultDialog(
        'OOPS',
        'please make sure that you have added your profile photo.',
      );
    } else {
      _saveForm();
    }
  }

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    uploadUserData();
  }

  void uploadUserData() async {
    if (imageFile == null) return;

    try {
      MyDialogBox.loading();
      TaskSnapshot taskSnapshot = await store
          .ref()
          .child('profilepictures')
          .child(widget.user.uid)
          .putFile(imageFile!);

      String imageDownloadUrl = await taskSnapshot.ref.getDownloadURL();

      final fetchedBeforeUserModel =
          await FirebaseHelper.fetchUserDetailsByUid(uid: widget.user.uid);

      if (fetchedBeforeUserModel == null) return;

      UserModel newlyCompletedUserModel = UserModel(
        uid: widget.user.uid,
        name: _nameController.text,
        profilepic: imageDownloadUrl,
        email: _emailController.text,
        phone: _phoneController.text,
        aboutme: _aboutController.text,
        followers: 0,
        following: 0,
        success: true,
        isprofilecomplete: true,
      );

      Get.back();
      EmailController.uploadUserDataToFirestore(
        widget.user,
        newlyCompletedUserModel,
      );

      MyDialogBox.showDefaultDialog(
        'Hurray !',
        'your profile updated successfully.',
      );

      Get.offAll(Home(user: widget.user));
    } on FirebaseException catch (e) {
      MyDialogBox.showDefaultDialog(e.code, e.message.toString());
    } catch (e) {
      MyDialogBox.showDefaultDialog('OOPS', e.toString());
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => _setUserData());
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _aboutController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ModalProgressHUD(
      inAsyncCall: !settingDataOver,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('my profile'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  InkWell(
                    // ----------------circle Avatar----------------------
                    customBorder: const CircleBorder(),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      showPhotoOptions();
                    },
                    borderRadius: BorderRadius.circular(60),
                    splashColor: theme.primaryColor.withOpacity(0.5),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: theme.primaryColor.withOpacity(0.25),
                      backgroundImage: isImage ? FileImage(imageFile!) : null,
                      child: imageFile == null
                          ? Icon(
                              Icons.add_a_photo_rounded,
                              size: 50,
                              color: theme.colorScheme.secondary,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    // ----------------name----------------------
                    validator: (v) {
                      final value = v.toString().trim();
                      if (value == null) {
                        return 'please provide your name.';
                      } else {
                        final val = value.trim();
                        if (val == '') {
                          return 'please provide your name.';
                        }
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'name',
                      icon: Icon(
                        Icons.person_rounded,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                  ),
                  TextFormField(
                    // ----------------about me----------------------
                    decoration: InputDecoration(
                      labelText: 'about me',
                      icon: Icon(
                        Icons.notes_rounded,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    controller: _aboutController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                  ),
                  TextFormField(
                    // ----------------e mail----------------------
                    validator: (v) {
                      final value = v.toString().trim();
                      if (value == null) {
                        return 'please provide your email.';
                      } else if (!EmailValidator.validate(value)) {
                        return 'please provide a valid email address.';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'e mail',
                      icon: Icon(
                        Icons.email_outlined,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    readOnly: _emailController.text == '' ? false : true,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextFormField(
                          // ----------------phone number----------------------
                          validator: (v) {
                            final value = v.toString().trim();
                            if (value == null) {
                              return 'please provide your phone number.';
                            } else if (value.length != 10) {
                              return 'your number must be 10 digits long.';
                            } else if (double.tryParse(value) == null) {
                              return 'please provide a valid phone number.';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'phone number',
                            icon: Icon(
                              Icons.phone_in_talk_rounded,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          controller: _phoneController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          readOnly: _phoneController.text == '' ? false : true,
                        ),
                      ),
                      Container(
                        // ----------------------------country code---------------
                        decoration: BoxDecoration(
                          border: Border.all(
                            // color: Theme.of(context).primaryColor,
                            color: const Color.fromARGB(137, 101, 145, 196),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 100,
                        height: 50,
                        child: CountryCodePicker(
                          onChanged: (code) {
                            FocusScope.of(context).unfocus();
                            countryCode = code;
                          },
                          initialSelection: '+91',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    // ----------------elevated button----------------------
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        _checkValues();
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
