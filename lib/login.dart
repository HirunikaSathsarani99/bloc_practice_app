import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_app/home.dart';
import 'package:test_app/bloc/login_bloc/login_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFail) {
          Fluttertoast.showToast(msg: 'Invalid email or password');
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is LoginSucess) {
          return HomeScreen();
        }

        return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sign in",
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),

                  //Email
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email or Phone',
                            labelStyle:
                                TextStyle(fontSize: 18, color: Colors.grey),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your email or phone number";
                            }

                            return null;
                          },
                        ),

                        SizedBox(
                          height: 10.0,
                        ),

                        //password
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your password";
                            }

                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle:
                                TextStyle(fontSize: 18, color: Colors.grey),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                  //signIn
                  Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.8, 50),
                              backgroundColor:
                                  Color.fromARGB(255, 19, 119, 201)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<LoginBloc>(context).add(
                                  LoginStart(
                                      userName: emailController.text,
                                      password: passwordController.text));
                            }
                            emailController.clear();
                            passwordController.clear();
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )))
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
