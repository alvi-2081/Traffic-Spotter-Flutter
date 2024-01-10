import 'dart:io';
import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:crime_analysis_flutter/view/Auth/widgets/textfield_widget.dart';
import 'package:crime_analysis_flutter/controllers/services/User%20Services/auth_services.dart';
import 'package:crime_analysis_flutter/resources/buttons/rounded_button_expanded.dart';
import 'package:crime_analysis_flutter/resources/buttons/text_colored_button.dart';
import 'package:crime_analysis_flutter/utilities/responsive.dart';
import 'package:crime_analysis_flutter/utilities/validator.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool loading = false;

  void handleLogin(context) async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      setState(() {
        loading = true;
      });
      await emailLogin(
              _phoneController.text.toString(),
              _emailController.text.toString(),
              _passwordController.text.toString(),
              context)
          .then((value) => setState(() {
                loading = false;
              }));
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height(50),
                    ),
                    InkWell(
                      onTap: () {
                        _phoneController.text = '031727462421';
                        _emailController.text = 'daniyal@gmail.com';
                        _passwordController.text = '12345678';
                      },
                      child: const Text(
                        'Traffic\nSpotter',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.main,
                            fontSize: 45,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // const Image(
                    //   image: AssetImage("assets/logo.png"),
                    //   width: 250,
                    //   height: 120,
                    //   fit: BoxFit.cover,
                    // ),
                    SizedBox(
                      height: height(50),
                    ),
                    TextFieldContainer(
                      title: " Phone",
                      hint: "Enter your phone",
                      icon: Icons.phone,
                      controller: _phoneController,
                      validator: Validator.requiredValidator,
                      inputType: TextInputType.number,
                    ),
                    TextFieldContainer(
                      title: " Email",
                      hint: "Enter your email",
                      icon: Icons.email,
                      controller: _emailController,
                      validator: Validator.emailValidator,
                    ),
                    TextFieldContainer(
                      title: " Password",
                      hint: "Enter your password",
                      icon: Icons.lock,
                      controller: _passwordController,
                      validator: Validator.requiredValidator,
                    ),
                    SizedBox(height: width(20)),
                    RoundedButtonExpanded(
                      title: "Sign In",
                      onPress: () => handleLogin(context),
                      loading: loading,
                    ),
                    SizedBox(
                      height: height(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have account?"),
                        TextColoredButton(
                          title: ' SignUp',
                          onPress: () =>
                              Navigator.pushNamed(context, "/SignUp"),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height(10),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
