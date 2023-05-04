import 'package:authapp/blocs/login/bloc.dart';
import 'package:authapp/blocs/login/event.dart';
import 'package:authapp/utils/helpers/form_helpers/all_form_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpForm extends StatelessWidget {
  OtpForm({super.key});
  String getTime() {
    var msg;

    return msg;
  }

  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();
  TextEditingController pin5 = TextEditingController();
  TextEditingController pin6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop;
        },
        icon: Icon(Icons.close),
      )),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                    "We have sent verification\n to phone number +2519....36"),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              margin: EdgeInsets.only(top: 10.h),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildInputBox(context, pin1),
                        _buildInputBox(context, pin2),
                        _buildInputBox(context, pin3),
                        _buildInputBox(context, pin4),
                        _buildInputBox(context, pin5),
                        _buildInputBox(context, pin6),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    _verifyPhone(context),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(child: _resendBtn())
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildInputBox(BuildContext context, pinId) {
    return SizedBox(
      height: 54,
      width: 44,
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        controller: pinId,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.black),
      ),
    );
  }

//verify button
  _verifyPhone(BuildContext context) {
    return ElevatedButton(
      child: Text("Verify"),
      onPressed: () {
        String otp = pin1.text.trim() +
            pin2.text.trim() +
            pin3.text.trim() +
            pin4.text.trim() +
            pin5.text.trim() +
            pin6.text.trim();
        BlocProvider.of<LoginBloc>(context).add(VerifyOtpEvent(otp: otp));
      },
    );
  }

  _resendBtn() {
    return TextButton(onPressed: () {}, child: Text("Resend"));
  }
}
