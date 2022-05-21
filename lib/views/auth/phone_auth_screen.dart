import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../controllers/Auth/phone_auth_controller.dart';
import '../../utilities/myDialogBox.dart';

class PhoneAuthScreen extends StatefulWidget {
  PhoneAuthScreen({
    Key? key,
    required this.isVerify,
  }) : super(key: key);

  bool isVerify;

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

enum Mode { submit, verify }

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  Mode _mode = Mode.submit;
  bool _isError = false;
  bool _isLoading = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  CountryCode countryCode = CountryCode(code: 'IN', dialCode: '+91');
  final _form = GlobalKey<FormState>();
  String finalPhone = '';
  final _phone = PhoneController();

  //======================== save form ===================================
  void _saveForm() async {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      setState(() => _isError = true);
      return;
    }
    setState(() => _isError = false);
    _form.currentState?.save();
    finalPhone = '$countryCode${_phoneController.text}';
    setState(() => _isLoading = true);

    _mode == Mode.submit
        ? _phone.verifyWithPhoneCredentials(finalPhone)
        : _phone.verifyPhoneNumberWithOtp(otp: _otpController.text);
    setState(() => _isLoading = false);

    _mode == Mode.submit
        ? setState(() => _mode = Mode.verify)
        : setState(() => _isLoading = true);
  }

  void verifyNumberWithOtp() {
    if (_otpController.text == '' || _otpController.text.length != 6) {
      MyDialogBox.showDefaultDialog(
        'Error',
        'please enter the 6 digit otp you received to verify your number.',
      );
      return;
    }
    _phone.verifyPhoneNumberWithOtp(otp: _otpController.text);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Acard(context),
    );
  }

  AnimatedContainer Acard(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: const Color.fromARGB(132, 255, 251, 251),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 13,
      ),
      height: _isError ? 200 : 170,
      child: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(children: [
            if (_mode == Mode.submit)
              Row(
                children: [
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
                        countryCode = code;
                      },
                      initialSelection: '+91',
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextFormField(
                      // ------------------------------phone---------------
                      validator: (value) {
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
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'phone number',
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
            if (_mode == Mode.verify)
              TextFormField(
                // -------------------------------otp-----------------
                controller: _otpController,
                decoration: const InputDecoration(
                  labelText: 'otp you received',
                ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
              ),
            const SizedBox(height: 8),
            Column(
              children: [
                //--------------------elevated---------------------------
                RaisedButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0.0),
                    child: RaisedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        _mode == Mode.submit
                            ? _saveForm()
                            : verifyNumberWithOtp();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      padding: const EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, 0.6),
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 100.0,
                              minHeight:
                                  50.0), // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: Text(
                              _mode == Mode.submit ? 'Submit' : 'Verify',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)
                              // textAlign: TextAlign.center,
                              ),
                        ),
                      ),
                    )),
                const SizedBox(width: 10),
                //-------------------below row-------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('didn\'t receive otp'),
                    const SizedBox(width: 15),
                    TextButton(
                      child: const Text('Resend'),
                      onPressed: () {
                        setState(() => _mode = Mode.submit);
                        _saveForm();
                        Get.snackbar(
                          "Thanks for login",
                          "resending the otp, please wait ....",
                          icon: const Icon(Icons.person, color: Colors.black),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor:
                              const Color.fromARGB(76, 78, 104, 163),
                          duration: const Duration(seconds: 5),
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // const Text('change number ?'),
                    // const SizedBox(width: 15),
                    // TextButton(
                    //   child: const Text('Resend'),
                    //   onPressed: () {
                    //     setState(() => _mode = Mode.submit);
                    //     _saveForm();
                    //     MySnackBar.showBottomSnackBar(
                    //       context,
                    //       'resending the otp, please wait ....',
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
