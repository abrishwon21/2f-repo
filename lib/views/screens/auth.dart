import 'package:authapp/blocs/auth/bloc_event.dart';
import 'package:authapp/blocs/blocs.dart';
import 'package:authapp/blocs/login/event.dart';
import 'package:authapp/blocs/login/state.dart';
import 'package:authapp/constants/constants.dart';
import 'package:authapp/utils/helpers/helpers.dart';
import 'package:authapp/views/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fname_controller = TextEditingController();
  TextEditingController lname_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  bool _isLogin = true;

  void _signUp() {
    final isValid = _formKey.currentState!.validate();
    // FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

      BlocProvider.of<LoginBloc>(context).add(EmailSignUpRequested(
          fname_controller.text.trim(),
          lname_controller.text.trim(),
          email_controller.text.trim(),
          password_controller.text.trim()));

      BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is LoginCompleteState) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => BottomNavBarScreen()));
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      });
    }
  }

  void _signIn() {
    final isValid = _formKey.currentState!.validate();
    // FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

      BlocProvider.of<LoginBloc>(context).add(EmailSignInRequested(
          email_controller.text.trim(), password_controller.text.trim()));

      BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is LoginCompleteState) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => BottomNavBarScreen()));
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("2F Capital")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 64.0.h,
                width: 100.0.w,
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 16.0.w, top: 10.0.h),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage("assets/images/gLogo.png"),
                    fit: BoxFit.fitHeight,
                  ),
                )),
            SizedBox(height: 25.0.h),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0.h, horizontal: 10.0.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isLogin ? 'Login' : 'Signup',
                          style: headText(
                              context, Colors.black, 28.0, FontWeight.w600),
                        ),
                        SizedBox(height: 30.0.h),
                        if (!_isLogin) _buildNameFields(),
                        SizedBox(
                          height: 8.0.h,
                        ),
                        _buildEmailField(),
                        SizedBox(
                          height: 8.0.h,
                        ),
                        _buildPasswordField(),
                        SizedBox(height: 16.0.h),
                        _isLogin
                            ? TextButton(
                                child: Text(
                                  "Forgot Password",
                                  style: bodyMedium(context, Colors.black,
                                      20.0.sp, FontWeight.w400),
                                ),
                                onPressed: () {})
                            : const SizedBox(height: 0.0),
                        SizedBox(height: _isLogin ? 16.0.h : 0.0),
                        Container(
                          // margin: EdgeInsets.symmetric(horizontal: 20.0),
                          width: double.maxFinite,
                          height: 50.0.h,

                          child: ElevatedButton(
                            child: Text(_isLogin ? 'Login' : 'Signup',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0.sp,
                                  fontWeight: FontWeight.w300,
                                )),
                            onPressed: _isLogin ? _signIn : _signUp,
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        MAIN_BUTTON_COLOR)),
                          ),
                        ),
                        SizedBox(
                          height: 10.0.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 12.0.w),
                          child: Row(
                            children: [
                              Text(
                                  _isLogin
                                      ? 'Don\'t Have An Account?\t'
                                      : 'Already Have An Account?\t',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.w200,
                                      fontSize: 18.0.sp)),
                              TextButton(
                                child: Text(
                                  _isLogin ? 'Register' : 'Sign In',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Divider(
                              thickness: 2.0.h,
                              color: Colors.red,
                              endIndent: 5.0.w,
                            ),
                            Text("OR"),
                            Divider(
                              thickness: 2.0.h,
                              color: PRIMARY_GREEN,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0.h,
                        ),
                        Center(
                            child: TextButton(
                                child: Row(
                                  children: [
                                    Text("Sign In By:\t"),
                                    Icon(Icons.phone_enabled_rounded),
                                    Text("\t Your Phone"),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => PhoneScreen()));
                                }))
                      ],
                    ),

                    //ie
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameFields() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "First Name",
              style:
                  bodySmall(context, Colors.black54, 14.0.sp, FontWeight.w300),
            ),
            TextFormField(
                decoration: InputDecoration(
                  hintText: 'First Name',
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.w200),
                  errorBorder: getOutlineBorder(1.0, PRIMARY_RED),
                  focusedBorder: getOutlineBorder(1.0, PRIMARY_GREEN),
                  enabledBorder: getOutlineBorder(2.0, Colors.black),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 6.0.h),
                ),
                style: bodySmall(
                    context, Colors.black, 16.0.sp, FontWeight.normal),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter your first name.';
                  return null;
                },
                controller: fname_controller),
          ],
        ),
        SizedBox(
          height: 16.0.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Last Name",
              style:
                  bodySmall(context, Colors.black54, 14.0.sp, FontWeight.w300),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Last Name',
                hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.w200),
                errorBorder: getOutlineBorder(1.0, PRIMARY_RED),
                focusedBorder: getOutlineBorder(1.0, PRIMARY_GREEN),
                enabledBorder: getOutlineBorder(2.0, Colors.black),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 6.0.h),
              ),
              style:
                  bodySmall(context, Colors.black, 16.0.sp, FontWeight.normal),
              validator: (value) {
                if (value!.isEmpty) return 'Please enter your last name.';
                return null;
              },
              controller: lname_controller,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: bodySmall(context, Colors.black54, 14.0.sp, FontWeight.w300),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Email Address',
            hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 16.0.sp,
                fontWeight: FontWeight.w200),
            errorBorder: getOutlineBorder(1.0, PRIMARY_RED),
            focusedBorder: getOutlineBorder(1.0, PRIMARY_GREEN),
            enabledBorder: getOutlineBorder(2.0, Colors.black),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 6.0.h),
          ),
          style: bodySmall(context, Colors.black, 16.0.sp, FontWeight.normal),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value!.isEmpty || !value.contains('@'))
              return 'Please enter a valid email address.';
            return null;
          },
          controller: email_controller,
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: bodySmall(context, Colors.black54, 14.0.sp, FontWeight.w300),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 16.0.sp,
                fontWeight: FontWeight.w200),
            errorBorder: getOutlineBorder(1.0, PRIMARY_RED),
            focusedBorder: getOutlineBorder(1.0, PRIMARY_GREEN),
            enabledBorder: getOutlineBorder(2.0, Colors.black),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 6.0.h),
          ),
          style: bodySmall(context, Colors.black, 16.0.sp, FontWeight.normal),
          obscureText: true,
          validator: (value) {
            if (value!.isEmpty || value.length < 6)
              return 'Password must be at least 6 characters long.';
            return null;
          },
          controller: password_controller,
        ),
      ],
    );
  }
}
