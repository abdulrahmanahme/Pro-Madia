
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dio/dio.dart';
import 'package:promadia/model/data_model.dart' as getData;
import 'package:promadia/model/user_model.dart' as getuser;
import 'package:promadia/view_model.dart/cubit/states.dart';
import 'package:promadia/view_model.dart/dio/dio.dart';
import 'package:promadia/view_model.dart/dio/end_points.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

class GellaryCubit extends Cubit<GellaryStatus> {
  GellaryCubit() : super(InitialLoadingStatus());
  static GellaryCubit get(context) => BlocProvider.of(context);


 var token='eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYTE3MTBmNTA4MzFmY2NiNDYwNGExMzY0ODJmNDFiZjU5OTEzY2JkY2ZhZmU2ZDY1OWJmZmQ5OGVkODE1MDk5MTRmNTRmMjZmZDA2NGZjZDIiLCJpYXQiOjE2NjcyODk3ODUuMDMzMTk5LCJuYmYiOjE2NjcyODk3ODUuMDMzMjAzLCJleHAiOjE2OTg4MjU3ODUuMDI2MzI0LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.bWImC0xkzNQe8iKxL1Scg0tGGZGUy3vWsiX1vBzj1gLvynIMJcOqVkEVZc2C3MgSaCHjyqGkN7zWyqYVqLasAaKKFmj9JiQgXozvPcHJPoJCGQQvogt-gnM0DPeFMF-g_CVJPNZ3nUkXpOLl3Os5DhvW53OVT1n5pisoNyvsrEJURWTXxt1EIxwnmoj0An8y9kq2WSX4Zn2RoVGKe3QnL-KOGKksfv2ahj7hG-ZNwVYazI6TXCIxZBCYGoZtfvq9CjTrVUcCBSiGgdyaJzAZi0lNR2c2zcZxWGbBQ_QvfTFDZmmPyogScE5cgy4MGsnYe4Sw7qLmHIrSsrMaJxRgQ_b7xobq9ob1vDhw9O-VcPpiCllEFyjMkdKOFC8UffoYZB3bafp9KZB6Dr3tS7fo6f4ojAKnj-b8g6AigjuFb4FAYlC0vxT76mtvvYFm8MjH1kH2QmJ0HzvhBxv45K9Cdtuvr3DdrwyDaoROR4eZ6S-Xp-LYuCkZ-e4UenLJC4mDUu8u6xoyLHKul3FhNlAUMj-oScKZgJxRUYhbVxzXruHwaycKdlX284-Y6cfSAf3AjIvfaXYeB1ajGuuCtYceBVGM5tDxY4i9I7kthk3DNRjaRQPIl5c8GQlYV3I3p-RItB33Y-ECNiG92U2fgB8fAVw5urOuFX7pIZZ0NEc6VAY';
  getuser.UserModel ?userModel;
 getData.Data? data;
  List<String> proudcts = [];
getData.DataModel? dataModel;


 void getProducts() {
    emit(GellaryDataLodingState());
    DioHelper.getData(url: MyGellary, token: token
).then((value) {
  dataModel =getData.DataModel.fromJson(value.data);
  print('ddddddddddddddddddddddddddddd${dataModel!.data!.images!}');
  proudcts=dataModel!.data!.images!;


      emit(GellaryDataSuccessState());
    }).catchError((error) {
      if (error is DioError) {
     
        emit(GellaryDataErrorState());
      }
    });
  }
  
    


  void userLogin({
    required String? email,
    required String? password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      "email": email,
      "password": password,
    }).then((value) {
      userModel = getuser.UserModel.fromJson(value.data);
            // userData = UserData.fromJson(value.data);
      print('LLLLLL ${userModel!.user!.name!}  LL');
      print('LLLLLL ${userModel!.user!.email!}  LL');
      print('LLLLLL ${userModel!.user!.createdAt!}  LL');
      emit(LoginSuccessState());
    }).catchError((error) {
      if (error is DioError) {
        print(
            'eeeeeeeeeeeeeeeL${error.response!.data['message']}eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
        emit(LoginErrorState(error.response!.data['message']));
      }
    });

   

 
  }

File? imageCamera;
  Future<void> ImageCamera() async {
    final ImagePicker _pickerCamera = ImagePicker();
    final XFile? pickedCameraFile =
        await _pickerCamera.pickImage(source: ImageSource.camera);

    if (pickedCameraFile != null) {
     imageCamera = File(pickedCameraFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('NO Image print');
      emit(PostImagePickedErrorState());
    }
  }

  File? gelleryImage;

  Future<void> GelleryImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      gelleryImage = File(pickedFile.path);
      
  
       emit(GetImageSuccessStateState());
    } else {
      print('NO Image print');
            emit(GetImageErrorStateState ());

    }
  }
 void createPost({
   
    required String? image,

  }) {
    emit(UploadImageLodingStateState());
    DioHelper.postData(url: UPload, data: {
      "img": image!,
    },
    token: token)
    .then((value) {   
    
      emit(UploadImageSucessStateState());
      print('------------------UPLOAD DONE -----------------------');

    }).catchError((error) {
      if (error is DioError) {
     
        emit(UploadImageErrorStateState());
      }
    });
  }

}



  