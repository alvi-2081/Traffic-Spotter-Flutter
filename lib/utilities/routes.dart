import 'package:crime_analysis_flutter/navigation_bar.dart';
import 'package:crime_analysis_flutter/view/Auth/SignIn/sign_In.dart';
import 'package:crime_analysis_flutter/view/Auth/Signup/sign_up.dart';
import 'package:crime_analysis_flutter/view/Create%20Complain/create_complain_screen.dart';
import 'package:crime_analysis_flutter/view/Previous%20Complains/previous_complains.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> appRoutes = {
  "/NavigationBar": (BuildContext context) => const NaviGationBar(),
  "/SignUp": (BuildContext context) => const SignUp(),
  "/SignIn": (BuildContext context) => SignIn(),
  "/CreateComplain": (BuildContext context) => const CreateComplainScreen(),
  "/PreviousComplain": (BuildContext context) =>
      const PreviousComplainsScreen(),
};
