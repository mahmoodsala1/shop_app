import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layouts/cubit/app_cubit.dart';
import 'package:shop_app/layouts/cubit/app_states.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/functions.dart';
import 'package:shop_app/shared/shared_pref.dart';

import '../../shared/constants.dart';

class SettingsScreen extends StatelessWidget {
  @override
  var nameController = TextEditingController();
  var emailController = TextEditingController();

  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var modelSheetFormKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is UpdatUserDataSucessState) {
        Fluttertoast.showToast(
            msg: state.updateUserDataModel!.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }, builder: (context, state) {
      var model = AppCubit.get(context).userData;

      if (model != null) {
        nameController.text = model.data!.name ?? '';
        emailController.text = model.data!.email ?? '';
        phoneController.text = model.data!.phone ?? '';
      }

      return model != null
          ? Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (state is UpdatUserDataOnLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      textFormField(
                          controller: nameController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'name must be not empty';
                            }
                            return null;
                          },
                          textInputType: TextInputType.name,
                          lable: 'Name',
                          prefix: Icons.person),
                      SizedBox(
                        height: 20,
                      ),
                      textFormField(
                          controller: emailController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'email must be not empty';
                            }
                            return null;
                          },
                          textInputType: TextInputType.emailAddress,
                          lable: 'email',
                          prefix: Icons.email),
                      SizedBox(
                        height: 20,
                      ),
                      textFormField(
                          controller: phoneController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'phone must be not empty';
                            }
                            return null;
                          },
                          textInputType: TextInputType.phone,
                          lable: 'Phone',
                          prefix: Icons.phone),
                      SizedBox(
                        height: 20,
                      ),
                      textFormField(
                        validate: (value) {
                          if (value!.isEmpty) return 'can not be empty';
                        },
                        obscure: AppCubit.get(context).isPassword,
                        onSuffixTap: () {
                          AppCubit.get(context).changIcon();
                        },
                        prefix: Icons.email_outlined,
                        suffix: AppCubit.get(context).suffixIcon,
                        controller: passwordController,
                        lable: 'enter ur password',
                        textInputType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          defultButton(
                              width: 130,
                              text: 'Update',
                              color: Colors.blue,
                              onpressed: () {
                                if (formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  AppCubit.get(context).updateUserData(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                      name: nameController.text);
                                }
                              }),
                          Spacer(),
                          defultButton(
                              width: 130,
                              color: Colors.blue,
                              onpressed: () {
                                SharedPref.remove(key: 'token').then((value) {
                                  token = null;

                                  Phoenix.rebirth(context);
                                });
                              },
                              text: 'Logout'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(child: CircularProgressIndicator());
    });
  }
}
