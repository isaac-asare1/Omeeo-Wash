import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ommeoWash/custom_theme/color_palette.dart';
import 'package:ommeoWash/custom_theme/custom_widgets.dart';
import 'package:ommeoWash/custom_theme/font_size.dart';

class ProfileTabScreen extends StatelessWidget {
  const ProfileTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: darkPurple,
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/omeeo_logo.png', height: 50),
                    SizedBox(width: 8),
                    CustomText('Hello, xander', color: whiteText),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: darkText,
                    backgroundColor: backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: CustomText('Help', fontSize: FontSizes.ml),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
              child: ListView(
                children: [
                  //Account section
                  CustomText(
                    'Account',
                    fontSize: FontSizes.ml,
                    color: hintTextColor,
                  ),
                  SizedBox(height: 5.0),
                  _buildListTile(
                    context: context,
                    icon: Icons.edit,
                    title: 'Edit Profile',
                    firstChild: true,
                    route: "edit_profile",
                  ),
                  divider(),
                  _buildListTile(
                    context: context,
                    icon: Icons.location_on,
                    title: 'My Locations',
                    trailingText: '2 Addresses',
                    route: "locations",
                  ),
                  divider(),
                  _buildListTile(
                    context: context,
                    icon: Icons.subscriptions,
                    title: 'My Subscriptions',
                    lastChild: true,
                    route: "subscription",
                  ),
                  //OmeeoWash section
                  SizedBox(height: 20),
                  CustomText(
                    'OmeeoWash',
                    fontSize: FontSizes.ml,
                    color: hintTextColor,
                  ),
                  SizedBox(height: 5.0),
                  _buildListTile(
                    context: context,
                    icon: Icons.help_outline,
                    title: 'Help Center',
                    firstChild: true,
                    route: "help",
                  ),
                  divider(),
                  _buildListTile(
                    context: context,
                    icon: Icons.share,
                    title: 'Share App',
                  ),
                  divider(),
                  _buildListTile(
                    context: context,
                    icon: Icons.description,
                    title: 'Terms of Service',
                  ),

                  divider(),
                  _buildListTile(
                    context: context,
                    icon: Icons.privacy_tip,
                    title: 'Privacy Policy',
                    lastChild: true,
                  ),
                  //Managing section
                  SizedBox(height: 20),
                  CustomText(
                    'Manage',
                    fontSize: FontSizes.ml,
                    color: hintTextColor,
                  ),
                  SizedBox(height: 5.0),
                  _buildListTile(
                    context: context,
                    icon: Icons.logout,
                    title: 'Sign Out',
                    firstChild: true,
                  ),
                  divider(),
                  _buildListTile(
                    context: context,
                    icon: Icons.lock,
                    title: 'Change Password',
                  ),
                  divider(),
                  _buildListTile(
                    context: context,
                    icon: Icons.delete,
                    title: 'Delete Account',
                    lastChild: true,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? route,
    VoidCallback? callBack,
    String? trailingText,
    bool firstChild = false,
    bool lastChild = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topRight: firstChild ? Radius.circular(12) : Radius.zero,
          topLeft: firstChild ? Radius.circular(12) : Radius.zero,
          bottomLeft: lastChild ? Radius.circular(12) : Radius.zero,
          bottomRight: lastChild ? Radius.circular(12) : Radius.zero,
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: icon == Icons.delete ? errorColor : darkText,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: icon == Icons.delete ? errorColor : darkText,
            fontSize: FontSizes.md,
          ),
        ),
        trailing:
            trailingText != null
                ? IntrinsicWidth(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: lightPurple,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          trailingText,
                          style: const TextStyle(
                            fontSize: FontSizes.md,
                            fontWeight: FontWeight.bold,
                            color: scaffoldBackground,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: darkText,
                      ),
                    ],
                  ),
                )
                : const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          route != null
              ? context.push('/core/${route}')
              : callBack != null
              ? callBack()
              : null;
        },
      ),
    );
  }

  Widget divider() {
    return Container(color: lighHintText, height: 1);
  }
}
