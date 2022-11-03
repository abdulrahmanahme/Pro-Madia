import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promadia/components/components.dart';
import 'package:promadia/view/login_screen.dart';
import 'package:promadia/view_model.dart/cubit/cubit.dart';
import 'package:promadia/view_model.dart/cubit/states.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GellarryScreen extends StatefulWidget {
  @override
  State<GellarryScreen> createState() => _GellarryScreenState();
}

var controlleremail = TextEditingController();
var controllerpassword = TextEditingController();
final formkey = GlobalKey<FormState>();

class _GellarryScreenState extends State<GellarryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GellaryCubit>(
       create: (BuildContext context) => GellaryCubit(),
  
      child: BlocConsumer<GellaryCubit, GellaryStatus>(
          listener: (context, state) {},
            builder:(context, state) {
              
            var cubit = GellaryCubit.get(context);
cubit.getProducts();

                return   SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/gellary2.jpeg'),
                fit: BoxFit.cover),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height:
                        Device.orientation == Orientation.portrait ? .5.h : 15.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                          child: Text(
                            'Wellcome Abdo ',
                            style: TextStyle(
                              fontSize: 21.sp,
                              // fontWeight: FontWeight.bold,
                              color: Color(0xff4A4A4A),
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.blue,
                            backgroundImage:AssetImage('assets/images/imageof.jpeg') ,
                          ),
                        ),
                      ],
                    ),
                  ),
                 
    
                  Row(
                    children: [
                      ButtonIcon(
                        heroTag: 'tag 2',
                        asset: 'assets/images/logout.png',
                        textcolor: Color(0xff4A4A4A),
                        colorbutton: Colors.white,
                        text: 'Log out',
                        function: (() {
                           navigateAndFinish(context, LoginScreen());
                        }),
                      ),
                       
                      Spacer(),
                      ButtonIcon(
                        heroTag: 'tag 1',
                        asset: 'assets/images/upload.png',
                        textcolor: Color(0xff4A4A4A),
                        colorbutton: Colors.white,
                        text: 'Upload',
                        function: (() {
                          showDialog(
                              barrierColor: Color.fromARGB(1, 2, 1, 1),
                              context: context,
                              builder: (BuildContext context) => dialog(
                                function1:()async{
                              await cubit.GelleryImage();
                                   if(cubit.gelleryImage!=null)

                                  cubit.createPost(image:cubit.gelleryImage.toString() );
                                  Navigator.pop(context);
                                } ,
                                function2: ()async{
                                     await  cubit.ImageCamera();
                                if(cubit.imageCamera!=null)
                                   cubit.createPost(image:cubit.imageCamera.toString());
                                
                                  Navigator.pop(context);
                                } ,
                              ));
                        }),
                      ),
                    ],
                  ),
   
     cubit.proudcts.length> 0
                        ?
                       
                         SizedBox(
                            // width: double.infinity,
                            child: ListView.separated(
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Row(
                                children: [
                                  CardWidget(
                                    image: cubit.proudcts[index+4],
                                  ),
                                ],
                              ),
                              separatorBuilder: (context, index) =>
                                  SizedBox(
                                height: 8.0,
                              ),
                              itemCount:  5,
                            ),
                          )
                        : Center(child: CircularProgressIndicator()),


  // Cont
                ],
              ),
            ),
          ),
        ),
      );

            },
          
      ),
     
    );
  }
}
