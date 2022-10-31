import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layouts/home.dart';
import 'package:shop_app/modules/login/shop_login_cubit.dart';
import 'package:shop_app/modules/login/shop_login_states.dart';
import '../register/register.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/functions.dart';
import 'package:shop_app/shared/shared_pref.dart';

class Login extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              Fluttertoast.showToast(
                  msg: state.loginModel.message!,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              SharedPref.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                emailController.clear();
                passwordController.clear();
                navigateAndFinish(HomeScreen(), context);
              });
            } else {
              Fluttertoast.showToast(
                  msg: state.loginModel.message!,
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
                        'Login',
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
                        height: 15,
                      ),
                      textFormField(
                        onSuffixTap: () {
                          ShopLoginCubit.get(context).changePasswordVisibilty();
                        },
                        obscure: ShopLoginCubit.get(context).isPassWord,
                        onsubmitted: (_) {
                          if (formKey.currentState!.validate()) {
                            ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        suffix: ShopLoginCubit.get(context).suffixIcon,
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
                      state is! ShopLoginLoadingState
                          ? GestureDetector(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                                emailController.clear();
                                passwordController.clear();
                              },
                              child: defultButton(
                                  text: 'Login',
                                  onpressed: () {
                                    if (formKey.currentState!.validate()) {
                                      ShopLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  color: Colors.blue,
                                  textColor: Colors.white),
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an accout?'),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen()));
                              },
                              child: Text(
                                'register',
                                style: TextStyle(fontSize: 15),
                              ))
                        ],
                      )
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
