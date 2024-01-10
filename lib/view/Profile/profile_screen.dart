import 'package:crime_analysis_flutter/controllers/globals.dart';
import 'package:crime_analysis_flutter/model/user_model.dart';
import 'package:crime_analysis_flutter/utilities/colors.dart';
import 'package:crime_analysis_flutter/utilities/responsive.dart';
import 'package:crime_analysis_flutter/view/Profile/widgets/profile_button.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // backgroundColor: AppColors.main,
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              color: AppColors.main,
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage(
                            'assets/default_user.jpg'), //replace with your own image URL
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        userModel.response!.name!.toString(),
                        style: const TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        userModel.response!.email!.toString(),
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        userModel.response!.phone!.toString(),
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ProfileScreenButton(
              icon: Icons.create_new_folder,
              onPress: () => Navigator.pushNamed(context, "/CreateComplain"),
              title: 'Create Spot',
            ),
            ProfileScreenButton(
              icon: Icons.preview_outlined,
              onPress: () => Navigator.pushNamed(context, "/PreviousComplain"),
              title: 'Previous Spots',
            ),
            // ProfileScreenButton(
            //   icon: Icons.edit,
            //   onPress: () {},
            //   title: 'Edit Profile',
            // ),
            Expanded(child: Container()),
            InkWell(
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context, "/SignIn", (route) => false)
                  .then((value) => userModel = UserModel()),
              child: const Text(
                "Logout",
                style: TextStyle(color: AppColors.main, fontSize: 24),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
