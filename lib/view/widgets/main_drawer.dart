import 'package:flutter/material.dart';
import 'package:playz/view/developer_view.dart';
import 'package:playz/view/game_view.dart';
import 'package:playz/view/platform_view.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            width: 60,
            child: const Image(
              image: AssetImage('assets/Logo.png'),
            ),
          ),
          ListTile(
              title: TextButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameView(),
                  ))
            },
            child: const Text("Add Game"),
          )),
          ListTile(
              title: TextButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeveloperView(),
                  ))
            },
            child: const Text("Add Developer"),
          )),
          ListTile(
              title: TextButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlatformView(),
                  ))
            },
            child: const Text("Add Platform"),
          )),
        ],
      ),
    );
  }
}
