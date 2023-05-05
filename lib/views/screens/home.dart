import 'package:authapp/blocs/blocs.dart';
import 'package:authapp/blocs/login/event.dart';
import 'package:authapp/blocs/login/state.dart';
import 'package:authapp/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // background image
          Positioned(top: 0, left: 0, right: 0, child: _backgroundImage()),
          // background color/banner
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildBackGround(),
          ),
          // build header
          Positioned(
            top: 20.h,
            child: _buildHeader(),
          ),
          //main body
          Positioned(
            top: 450.h,
            left: 0,
            right: 0,
            child: Container(
              height: 340.h,
              decoration: BoxDecoration(
                color: Colors.white10,
              ),
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Column(
                  //       children: [
                  //         Container(
                  //           child: Text("Departure Date",
                  //               style: TextStyle(
                  //                   color: Colors.black,
                  //                   fontSize: 20.sp,
                  //                   fontWeight: FontWeight.w500)),
                  //         ),
                  //       ],
                  //     ),
                  //     VerticalDivider(
                  //       width: 20,
                  //       thickness: 5,
                  //     ),
                  //     Column(
                  //       children: [
                  //         Container(
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: 10.w, vertical: 10.h),
                  //           margin: EdgeInsets.symmetric(
                  //               horizontal: 10.w, vertical: 10.h),
                  //           child: Text(
                  //             "Return Date",
                  //             style: TextStyle(
                  //                 color: Colors.black,
                  //                 fontSize: 20.sp,
                  //                 fontWeight: FontWeight.w500),
                  //           ),
                  //         )
                  //       ],
                  //     )
                  //   ],
                  // ),

                  Table(border: TableBorder.symmetric(), children: const [
                    TableRow(children: [
                      Text("Departure Date",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                      Text(
                        "Return Date",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        "2",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      Text(
                        "Ankit",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ]),
                  ])
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 5.w),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150.w,
                    height: 90.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/gLogo.png"))),
                  ),
                  SizedBox(
                    width: 100.w,
                  ),
                  Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white)),
                    child: Center(
                        child: IconButton(
                      icon: Icon(
                        Icons.notification_add_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 150.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r)),
                      child: Center(
                          child: Text(
                        "Return",
                      )),
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    Container(
                      width: 150.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(20.r)),
                      child: Center(
                          child: Text(
                        "One Way",
                        style: TextStyle(color: Colors.white),
                      )),
                    )
                  ]),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "From",
                        style: bodyLarge(
                            context, Colors.white, 22, FontWeight.w300),
                      ),
                      Text(
                        "ADD",
                        style: headText(
                            context, Colors.white, 28, FontWeight.w700),
                      ),
                      Text(
                        "Addis Ababa",
                        style: bodyLarge(
                            context, Colors.white, 22, FontWeight.w300),
                      ),
                      Text(
                        "Bole International Airport",
                        style: bodyLarge(
                            context, Colors.white, 16, FontWeight.w200),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 60.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.airplane_ticket),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.airplane_ticket)),
                        ),
                      ]),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "To",
                        style: bodyLarge(
                            context, Colors.white, 22, FontWeight.w300),
                      ),
                      Text(
                        "Select Destination",
                        style: bodyLarge(
                            context, Colors.white, 18, FontWeight.w300),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBackGround() {
    return Container(
      width: double.maxFinite,
      height: 450.h,
      decoration: BoxDecoration(
          color: Color.fromARGB(151, 33, 149, 243),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r))),
    );
  }

  Widget _backgroundImage() {
    return Container(
      width: double.maxFinite,
      height: 450.h,
      decoration: BoxDecoration(
          color: Color.fromARGB(19, 28, 102, 243),
          image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"), fit: BoxFit.cover)),
    );
  }
}
