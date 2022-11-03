import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promadia/components/components.dart';
import 'package:promadia/view/gellary_screen.dart';
import 'package:promadia/view_model.dart/cubit/cubit.dart';
import 'package:promadia/view_model.dart/cubit/states.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
  var controlleremail = TextEditingController();
  var controllerpassword = TextEditingController();
  final formkey = GlobalKey<FormState>();


class _LoginScreenState extends State<LoginScreen> {


  @override
  Widget build(BuildContext context) {
    return  BlocProvider<GellaryCubit>(
       create: (BuildContext context) => GellaryCubit(),
  
      child: BlocConsumer<GellaryCubit, GellaryStatus>(
          listener: (context, state) {
              if (state is LoginSuccessState) {
            // CacheHelper.setData(key:SharedKeys.token , value: '${state.userData!.data!.accessToken}');
            print('ssssssssssssssssssssssssssssssssssssssssssssssss');
              navigateAndFinish(context, GellarryScreen());

              // showToast(text: '${state.userData!.message}', state: ToastStates.SUCCESS);
          }
          },
          builder:(context, state) {
            var cubit = GellaryCubit.get(context);

             return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/login(7).png'),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Form(
              key:formkey  ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: Device.orientation == Orientation.portrait?
            22.h:15.h,
                  ),
                    
                  Text(
                    'My ',
                    style: TextStyle(
                      fontSize: 31.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4A4A4A),
                    ),
                  ),
                  Text(
                    'Gellary',
                    style: TextStyle(
                      fontSize: 31.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4A4A4A),
                    ),
                  ),
                    
                 
                    
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        height: Device.orientation == Orientation.portrait? 43.h:110.h,
                        width: Device.orientation == Orientation.portrait? 90.w:100.w,
                        //  color: Colors.white.withOpacity(.8),
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(18),
                        //  decoration: ,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.4),
                          // color: Color(0xffFFFFFF),
                    
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'LOG IN',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff4A4A4A),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
            
                            defaultFormField(
            
                                controller: controlleremail,
                                
                            hintText: 'User Name',
                                validate: (value) {
                                  if (!value!.contains('@') ||
                                     
                                      value.isEmpty) {
                                    return 'Invalid Email!';
                                  }
            
                                  return null;
                                },
            
                                type: TextInputType.emailAddress,
                              ),
                            
                              SizedBox(
                                height: Device.orientation == Orientation.portrait? 2.h:7.h,
                              ),
                           defaultFormField(
    
                              controller: controllerpassword,
                            hintText: 'Password',
    
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
    
                                return null;
                              },
    
                              type: TextInputType.visiblePassword,
                            ),
                             SizedBox(
                                height: Device.orientation == Orientation.portrait? 3.h:7.h,
                              ),
                              
    
                            ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                              primary: Color(0xff7BB3FF),
    
                                      padding: EdgeInsets.only(
                                          top: Device.orientation == Orientation.portrait?1.7.h:6.h,
                                          bottom: Device.orientation == Orientation.portrait?1.7.h:5.h,
                                          left: Device.orientation == Orientation.portrait?11.h:62.h,
                                          right: Device.orientation == Orientation.portrait?11.h:62.h),
    
    
                                      elevation: 6,
    
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      'SUBMIT',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (formkey.currentState!.validate()) {
                                         cubit.userLogin(email:controlleremail.text , password: controllerpassword.text);
                                          // Navigator.push(context, MaterialPageRoute(builder: ((context) =>GellarryScreen() )));
                                        // provider.userLogin(
                                        //     email: controlleremail.text,
                                        //     password: controllerpassword.text,
                                        //     context: context);
                                      }
                                    
                                    },
                                  ),
       
            
                //               TextFormField(
                //   decoration: InputDecoration(
                //       prefixIcon: Icon(
                //         Icons.person,
                //         color: Colors.white,
                //       ),
                //       border: OutlineInputBorder(
                //         // width: 0.0 produces a thin "hairline" border
                //         borderRadius: BorderRadius.all(Radius.circular(90.0)),
                //         borderSide: BorderSide.none,
                //       ),
                    
                //       hintStyle: TextStyle(color: Colors.black,fontFamily: "WorkSansLight"),
                //       filled: true,
                //       fillColor: Colors.white,
                //       hintText: 'Password'),
                // ),
                            
                            //  Text("Hello Everyone! This is FlutterCampus",
                            //       style: TextStyle(fontSize: 25, color: Colors.black),),
                          ],
                        ),
                      ),
                    ),
                  ),
                    
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: const [
                  //     Text(
                  //       'Oranos',
                  //       style: TextStyle(
                  //         fontSize: 45,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //     Text(
                  //       '.',
                  //       style: TextStyle(
                  //         fontSize: 50,
                  //         fontWeight: FontWeight.bold,
                  //         color: Color(0xff16919b),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                    
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  // const Text(
                  //   'Expert From Every planet',
                  //   style: TextStyle(
                  //     fontSize: 17,
                  //     fontFamily: 'Poppins',
                    
                  //     color: Colors.black,
                  //   ),
                  // ),
                  // Spacer(),
                    
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Color(0xff16919b),
                  //     padding: const EdgeInsets.only(
                  //         top: 20, bottom: 20, left: 120, right: 120),
                  //     elevation: 6,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  //   child: const Text(
                  //     'Get Started',
                  //     style: TextStyle(
                  //       fontSize: 17,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     //  Navigator.push(
                  //     //         context,
                  //     //         MaterialPageRoute(
                  //     //             builder: (context) => GetStartScreen()),
                  //     //       );
                  //   },
                  // ),
                  // // Spacer(),
                  // SizedBox(
                  //   height: 4.h,
                  // ),
                    
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 15, right: 5),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       const Text(
                  //         'Don\'t have an account? ',
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           color: Colors.black,
                  //            fontFamily: 'Poppins',
                  //           // fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //       InkWell(
                  //         onTap: () {
                    
                  //         },
                  //         child: const Text(
                  //           'SignUp',
                  //           style: TextStyle(
                  //             fontSize: 15,
                  //             fontFamily: 'Poppins',
                  //             color: Color(0xff16919b),
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 3.h,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 15, right: 5),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: const [
                  //       // Icon(MyFlutterApp.blur_circular),
                  //       SizedBox(
                  //         width: 8,
                  //       ),
                  //       Text(
                  //         'English',
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           color: Colors.black,
                  //           fontFamily: 'Poppins',
                  //           // fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 1.h,
                  // ),
                ],
              ),
            ),
          ),
        ),
      );

          } ,
      )
          
    );
  }
}
