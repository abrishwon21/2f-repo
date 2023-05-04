import 'package:authapp/blocs/login/bloc.dart';
import 'package:authapp/blocs/login/event.dart';
import 'package:authapp/blocs/login/state.dart';
import 'package:authapp/constants/constants.dart';
import 'package:authapp/utils/helpers/helpers.dart';
import 'package:authapp/views/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phone = TextEditingController();

  void _phoneAuth() {
    final isValid = _formKey.currentState!.validate();
    // FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      BlocProvider.of<LoginBloc>(context)
          .add(SendOtpEvent(phoNo: _phone.text.trim()));

      BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is VerifyOtpEvent) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => OtpForm()));
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      });
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => OtpForm()));

// Perform login or signup here
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
    
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 160.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/gLogo.png"),
                    fit: BoxFit.fitHeight,
                  )),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Container(
                  child: Text(
                    "Phone Auth",
                    style: bodyLarge(
                        context, Colors.black, 28.sp, FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildPhoneField(),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            // margin: EdgeInsets.symmetric(horizontal: 20.0),
                            width: double.maxFinite,
                            height: 50,

                            child: ElevatedButton(
                              child: Text('Sign In'),
                              onPressed: _phoneAuth,
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          MAIN_BUTTON_COLOR)),
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Divider(
                      thickness: 2.h,
                      color: PRIMARY_GREEN,
                    ),
                    Text("OR"),
                    Divider(
                      thickness: 2.h,
                      color: PRIMARY_GREEN,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                    child: TextButton(
                        child: Text("Sign In By Email",style: bodySmall(context, Colors.black54, 18.sp, FontWeight.w400),),
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => AuthScreen()));
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone Number",
          style: bodySmall(context, Colors.black54, 16.sp, FontWeight.w300),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: '+251912*******',
            errorBorder: getOutlineBorder(1, PRIMARY_RED),
            focusedBorder: getOutlineBorder(1, PRIMARY_GREEN),
            enabledBorder: getOutlineBorder(2, Colors.black),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          ),
          style: bodySmall(context, Colors.black, 16.sp, FontWeight.normal),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value!.isEmpty)
              return 'mobile number is required!';
            else if (value.length < 10) {
              return 'mobile number should be 10 digits!';
            }
            return null;
          },
          controller: _phone,
        ),
      ],
    );
  }
}
