import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserSettingPage extends StatefulWidget {
  @override
  _UserSettingPage createState() => _UserSettingPage();
}

class _UserSettingPage extends State<UserSettingPage> {
  final user = FirebaseAuth.instance.currentUser;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            userProfile(),
            HomeTitle("Account"),
            SettingButton(buttonText: "User Settings"),
            SettingButton(
                buttonText: "Logout",
                textColor: Colors.red,
                icon: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                onTap: () {
                  signUserOut();
                  Navigator.pop(context);
                }),
            HomeTitle("General"),
            SettingButton(buttonText: "Settings"),
            SettingButton(buttonText: "Language"),
            SettingButton(buttonText: "Terms & Privacy"),
            SettingButton(buttonText: "Help & Support"),
          ],
        ),
      ),
    );
  }

  Padding userProfile() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          user?.photoURL != null
              ? Container(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user?.photoURL ?? ''),
                  ),
                )
              : Container(
                  child: Icon(
                    Icons.account_circle,
                    size: 100,
                  ),
                ),
          Text(
            user?.email ?? '',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget SettingButton({
    required String buttonText,
    VoidCallback? onTap,
    Color? textColor,
    Icon? icon, // New optional parameter for the icon
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        color: textColor ?? Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: icon,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget HomeTitle(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 16.0, top: 32.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
