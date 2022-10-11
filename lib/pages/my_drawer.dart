// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:wallet/main.dart';
// ignore: unused_import
import 'package:url_launcher/url_launcher.dart';
import 'package:wallet/pages/welcome_page.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      backgroundColor: theme.textColor2,
      width: 200,
      child: ListView(
        // padding: 0,
        
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('SuiPort',
                style: TextStyle(fontWeight: FontWeight.bold)),
            decoration: BoxDecoration(
              color: theme.primaryColor2,
              image: DecorationImage(
                image: NetworkImage(
                    'https://avatars.githubusercontent.com/u/114194019?v=4'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    theme.primaryColor1, BlendMode.hardLight),
              ),
            ), accountEmail: null,
          ),
          ListTile(
            // ignore: prefer_const_constructors
            title: Text(
              'github',
              textAlign: TextAlign.right,
            ),
            // ignore: prefer_const_constructors
            // trailing: Icon(Icons.message, color: Colors.black12, size: 22.0),
            // ignore: deprecated_member_use
            onTap: () => launch('https://github.com/SuiPortDAO/SuiPort')
          ),
          ListTile(
            // ignore: prefer_const_constructors
            title: Text(
              '退出',
              textAlign: TextAlign.right,
            ),
            // ignore: prefer_const_constructors
            // trailing: Icon(Icons.favorite, color: Colors.black12, size: 22.0),
            onTap: () => {
              suiWallet.deleteWallet(),
              Navigator.push(context,MaterialPageRoute(builder:(BuildContext context)=> const WelcomePage()))
            },
          ),
        ],
      ),
    );
  }
}
