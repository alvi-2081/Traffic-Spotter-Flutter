import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:crime_analysis_flutter/view/Auth/widgets/signup_textfield.dart';
import 'package:crime_analysis_flutter/view/Auth/widgets/textfield_widget.dart';
import 'package:crime_analysis_flutter/controllers/services/User%20Services/auth_services.dart';
import 'package:crime_analysis_flutter/resources/buttons/rounded_button_expanded.dart';
import 'package:crime_analysis_flutter/resources/buttons/text_colored_button.dart';
import 'package:crime_analysis_flutter/utilities/responsive.dart';
import 'package:crime_analysis_flutter/utilities/validator.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool loading = false;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void handleSignup(context) {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      setState(() {
        loading = true;
      });
      signUp(
              _fullNameController.text.toString(),
              _emailController.text.toString(),
              _phoneController.text.toString(),
              _passwordController.text.toString(),
              context)
          .then((value) {
        setState(() {
          loading = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/SignIn");
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: _formkey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height(25),
                    ),
                    const Text(
                      'Traffic\nSpotter',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.main,
                          fontSize: 45,
                          fontWeight: FontWeight.bold),
                    ),
                    // const Image(
                    //   image: AssetImage("assets/logo.png"),
                    //   width: 250,
                    //   height: 120,
                    //   fit: BoxFit.cover,
                    // ),
                    SizedBox(
                      height: height(25),
                    ),
                    TextFieldContainer(
                      title: " Full Name",
                      hint: "Enter your full name",
                      icon: Icons.person,
                      controller: _fullNameController,
                      validator: Validator.requiredValidator,
                    ),
                    TextFieldContainer(
                      title: " Email",
                      hint: "Enter your email",
                      icon: Icons.email,
                      controller: _emailController,
                      validator: Validator.emailValidator,
                    ),
                    TextFieldContainer(
                      title: " Phone",
                      hint: "Enter your phone number",
                      icon: Icons.phone,
                      controller: _phoneController,
                      validator: Validator.requiredValidator,
                      inputType: TextInputType.number,
                    ),
                    PasswordSignUp(
                      title: " Password",
                      hint: "Enter your password",
                      icon: Icons.lock,
                      controller: _passwordController,
                    ),
                    SizedBox(height: width(10)),
                    RoundedButtonExpanded(
                      title: "Sign Up",
                      onPress: () => handleSignup(context),
                      loading: loading,
                    ),
                    SizedBox(
                      height: height(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have account?"),
                        TextColoredButton(
                          title: ' SignIn',
                          onPress: () =>
                              Navigator.pushNamed(context, "/SignIn"),
                        ),
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
