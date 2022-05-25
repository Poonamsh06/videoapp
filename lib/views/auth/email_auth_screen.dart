import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/Auth/email_controller.dart';
import '../../models/userModel.dart';
import '../../utilities/constants.dart';
import '../../utilities/myDialogBox.dart';
import '../../utilities/customButton.dart';
import '../home.dart';

class EmailAuthScreen extends StatefulWidget {
  @override
  State<EmailAuthScreen> createState() => _EmailAuthScreenState();
}

enum AuthMode { login, signUp }

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  UserCredential? userCredential;
  final _auth = FirebaseAuth.instance;
  AuthMode _authMode = AuthMode.login;
  String _email = '';
  String _confirmPwd1 = '';
  String _confirmPwd2 = '';
  bool _isError = false;
  bool _isLoading = false;
  final _form = GlobalKey<FormState>();
  bool isObscureText1 = true;
  bool isObscureText2 = true;

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: extract_email(context, _deviceSize),
    );
  }

  ModalProgressHUD extract_email(BuildContext context, Size _deviceSize) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: E_card(_deviceSize, context),
    );
  }

  AnimatedContainer E_card(Size _deviceSize, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: const Color.fromARGB(132, 255, 251, 251),
      ),
      padding: const EdgeInsets.all(13),
      height: _authMode == AuthMode.signUp
          ? _isError
              ? _deviceSize.height * 0.51
              : _deviceSize.height * 0.51
          : _isError
              ? _deviceSize.height * 0.51
              : _deviceSize.height * 0.51,
      child: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            //_deviceSize.height * 0.42
            children: [
              TextFormField(
                // --------------------------------email-----------------
                validator: (value) {
                  if (value == null) {
                    return 'please provide your email.';
                  } else if (!EmailValidator.validate(value)) {
                    return 'please provide a valid email address.';
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'email address',
                ),
                autofillHints: const [AutofillHints.email],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  _email = value.trim();
                },
              ),
              TextFormField(
                // ---------------------------------pwd 1-------------------
                validator: (value) {
                  if (value == null) {
                    return 'please provide your password.';
                  } else if (value.length <= 5) {
                    return 'password should be atleast 6 characters long.';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      isObscureText1 ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => setState(
                      () => isObscureText1 = !isObscureText1,
                    ),
                  ),
                ),
                textInputAction: _authMode == AuthMode.login
                    ? TextInputAction.done
                    : TextInputAction.next,
                obscureText: isObscureText1,
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value) {
                  _confirmPwd1 = value;
                },
                onFieldSubmitted:
                    _authMode == AuthMode.login ? (_) => _saveForm() : null,
              ),
              if (_authMode == AuthMode.signUp)
                TextFormField(
                  // ---------------------------------pwd 2-------------------
                  validator: (value) {
                    if (value == null) {
                      return 'please provide your password.';
                    } else if (value.length <= 5) {
                      return 'password should be atleast 6 characters long.';
                    } else if (_confirmPwd1 != _confirmPwd2) {
                      return 'both passwords should be same.';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        isObscureText2
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () => setState(
                        () => isObscureText2 = !isObscureText2,
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  obscureText: isObscureText2,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    _confirmPwd2 = value;
                  },
                  onFieldSubmitted:
                      _authMode == AuthMode.signUp ? (_) => _saveForm() : null,
                ),
              const SizedBox(height: 20),
              Column(
                children: [
                  //--------------------elevated---------------------------
                  CustomButton(
                    // controller: null,
                    title: _authMode == AuthMode.login ? "Login" : 'Signup',
                    icon: Icons.login_rounded,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _saveForm();
                    },
                  ),
                  //-------------------below row-------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _authMode == AuthMode.login
                            ? 'don\'t have an account ?'
                            : 'i already have an account',
                      ),
                      const SizedBox(width: 15),
                      TextButton(
                        child: Text(
                          _authMode == AuthMode.login ? 'Sign up' : 'Login',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          if (_authMode == AuthMode.login) {
                            setState(() => _authMode = AuthMode.signUp);
                          } else if (_authMode == AuthMode.signUp) {
                            setState(() => _authMode = AuthMode.login);
                          }
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                  if (success) const SizedBox(height: 7),
                  if (success)
                    ElevatedButton(
                      onPressed: showBtn
                          ? () {
                              EmailController.sendVerificationLink();
                              hideBtn();
                            }
                          : null,
                      child: Text(
                        showBtn ? 'resend link' : 'wait ${time.toString()} sec',
                        style: TextStyle(
                          color: showBtn
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool success = false;

  //========================  save form ===================================
  void _saveForm() async {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      setState(() => _isError = true);
      return;
    }
    setState(() => _isError = false);
    _form.currentState?.save();

    //==================================login
    if (_authMode == AuthMode.login) {
      try {
        setState(() => _isLoading = true);
        userCredential = await auth.signInWithEmailAndPassword(
          email: _email,
          password: _confirmPwd1,
        );

        final user = userCredential!.user;
        if (user == null) return;

        setState(() => _isLoading = false);
        Get.offAll(Home(user: user));

        setState(() => success = true);
      } on FirebaseAuthException catch (e) {
        setState(() => _isLoading = false);
        MyDialogBox.showDefaultDialog(
          e.code,
          e.message.toString(),
        );
      } catch (_) {
        setState(() => _isLoading = false);
        MyDialogBox.normalDialog();
      }
    }
    //==================================signUp
    else {
      try {
        setState(() => _isLoading = true);
        userCredential = await auth.createUserWithEmailAndPassword(
          email: _email,
          password: _confirmPwd1,
        );
        setState(() => success = true);
        FirebaseFirestore _firestore = FirebaseFirestore.instance;
        await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
          "Email": _email,
          "Status": "unavalible",
        });
      } on FirebaseAuthException catch (e) {
        setState(() => _isLoading = false);
        MyDialogBox.showDefaultDialog(
          e.code,
          e.message.toString(),
        );
      } catch (_) {
        setState(() => _isLoading = false);
        MyDialogBox.normalDialog();
      }
      setState(() => _isLoading = false);

      if (auth.currentUser != null) {
        if (auth.currentUser!.emailVerified && success) {
          newUserModel = UserModel(
            uid: auth.currentUser!.uid,
            name: '',
            profilepic: '',
            email: auth.currentUser!.email,
            phone: '',
            aboutme: '',
            followers: 0,
            following: 0,
            success: true,
            isprofilecomplete: false,
          );
          EmailController.uploadUserDataToFirestore(
            auth.currentUser,
            newUserModel!,
          );
          setState(() => isEmailVerified = true);
          _timer!.cancel();

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setStringList('listOfMyModel', newUserModel!.toList());

          Get.to(Home(user: userCredential!.user!));
        } else {
          await EmailController.sendVerificationLink();
          hideBtn();
          _timer = Timer.periodic(
            const Duration(seconds: 3),
            (timer) {
              checkEmailVerifiedOrNot();
            },
          );
        }
      }
    }
  }

  UserModel? newUserModel;
  bool isEmailVerified = false;
  Timer? _timer;
  Timer? timer10secs;
  bool showBtn = true;
  int time = 0;

  void checkEmailVerifiedOrNot() async {
    await auth.currentUser!.reload();
    setState(() => isEmailVerified = auth.currentUser!.emailVerified);
    if (isEmailVerified) {
      EmailController.uploadUserDataToFirestore(
        auth.currentUser,
        newUserModel!,
      );
      navigate();
    }
  }

  void navigate() {
    _timer!.cancel();
    Get.to(Home(user: userCredential!.user!));
  }

  void increment() {
    timer10secs = Timer.periodic(
      const Duration(seconds: 10),
      (timer) {
        setState(() {
          time = timer.tick;
        });
      },
    );
  }

  void hideBtn() async {
    setState(() => showBtn = false);
    for (int i = 0; i < 20; i++) {
      setState(() {
        time = 20 - i;
      });
      await Future.delayed(const Duration(seconds: 1));
    }
    setState(() => showBtn = true);
  }
}


// Future<void> sendVerificationLink() async {
  //   Get.snackbar(
  //     "Thanks for login",
  //     "now please check your email, we sent you a link, tap that and verify yourself",
  //     icon: const Icon(Icons.person, color: Colors.black),
  //     snackPosition: SnackPosition.BOTTOM,
  //     backgroundColor: const Color.fromARGB(76, 78, 104, 163),
  //     duration: const Duration(seconds: 5),
  //   );
  //   try {
  //     final user = auth.currentUser;
  //     await user!.sendEmailVerification();
  //     hideBtn();
  //   } on FirebaseAuthException catch (e) {
  //     MyDialogBox.showDefaultDialog(
  //       e.code,
  //       e.message.toString(),
  //     );
  //   } catch (_) {
  //     MyDialogBox.showDefaultDialog(
  //       'OOPS',
  //       'something went wrong, please try again after some time.',
  //     );
  //   }
  // }

  // Future<void> uploadUserDataToFirestore(User? user) async {
  //   if (user == null) {
  //     return;
  //   }
  //   final newUser = UserModel(
  //     uid: user.uid,
  //     name: '',
  //     profilepic: '',
  //     email: user.email,
  //     phone: '',
  //     success: false,
  //   );
  //   setState(() => _isLoading = true);
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user.uid)
  //         .set(newUser.toMap());
  //   } on FirebaseException catch (e) {
  //     setState(() => _isLoading = false);
  //     MyDialogBox.showDefaultDialog(e.code, e.message.toString());
  //   } catch (e) {
  //     setState(() => _isLoading = false);
  //     MyDialogBox.showDefaultDialog('OOPS', e.toString());
  //   }
  //   setState(() => _isLoading = false);
  // }