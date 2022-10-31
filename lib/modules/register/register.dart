import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/register/register_cubbit.dart';
import 'package:shop_app/modules/register/register_states.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/functions.dart';

import '../../layouts/home.dart';
import '../../shared/components.dart';
import '../../shared/shared_pref.dart';

class RegisterScreen extends StatelessWidget {
  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel.status) {
              Fluttertoast.showToast(
                  msg: state.registerModel.message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              SharedPref.saveData(
                      key: 'token', value: state.registerModel.data!.token)
                  .then((value) {
                token = state.registerModel.data!.token;
                navigateAndFinish(HomeScreen(), context);
              });
            } else {
              Fluttertoast.showToast(
                  msg: state.registerModel.message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Register',
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      textFormField(
                        validate: (value) {
                          if (value!.isEmpty) return 'can not be empty';
                        },
                        prefix: Icons.email_outlined,
                        controller: emailController,
                        lable: 'enter ur email',
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      textFormField(
                        validate: (value) {
                          if (value!.isEmpty) return 'can not be empty';
                        },
                        prefix: Icons.person,
                        controller: nameController,
                        lable: 'enter ur name',
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      textFormField(
                        validate: (value) {
                          if (value!.isEmpty) return 'can not be empty';
                        },
                        prefix: Icons.phone,
                        controller: phoneController,
                        lable: 'enter urphone',
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      textFormField(
                        onSuffixTap: () {
                          ShopRegisterCubit.get(context)
                              .changePasswordVisibilty();
                        },
                        obscure: ShopRegisterCubit.get(context).isPassWord,
                        onsubmitted: (_) {
                          if (formKey.currentState!.validate()) {
                            ShopRegisterCubit.get(context).userRegister(
                                phone: phoneController.text,
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        suffix: ShopRegisterCubit.get(context).suffixIcon,
                        validate: (value) {
                          if (value!.isEmpty) return 'can not be empty';
                        },
                        prefix: Icons.lock,
                        controller: passwordController,
                        lable: 'enter ur password',
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      state is! ShopRegisterLoadingState
                          ? defultButton(
                              text: 'Register',
                              onpressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      name: nameController.text,
                                      password: passwordController.text);
                                }
                              },
                              color: Colors.blue,
                              textColor: Colors.white)
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
