import 'package:flutter/material.dart';
import 'package:fresh_store_ui/constants.dart';
import 'package:fresh_store_ui/screens/profile/profile_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    context.setLocale(Locale("ar"));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
      child: Row(
        children: [
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            onTap: () => Navigator.pushNamed(context, ProfileScreen.route()),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('$kImagesPath/logo.png'),
              radius: MediaQuery.of(context).size.width * 0.08,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Good Morning 👋",
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.w500,
                    ),
                  ).tr(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.0005),
                  const Text(
                    "In Habouba store",
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ).tr(),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Image.asset('$kIconPath/notification.png'),
            onPressed: () {},
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          IconButton(
            icon: Image.asset('$kIconPath/light/heart@2x.png'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
