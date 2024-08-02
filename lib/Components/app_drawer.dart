import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  void exitApp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.orange[50],
        title: Text("Exit Application ??"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
                SystemNavigator.pop();
              });
            },
            child: Text("Sure"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child: Text("Not Yet"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.orange[50],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Image.asset(
                  r"lib\assets\ball.png",
                  width: 55,
                  height: 55,
                ),
              ),
              ListTile(
                title: Text("H O M E"),
                leading: Icon(Icons.home_rounded),
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                title: Text("P L A Y E R S"),
                leading: Icon(Icons.people_outline_outlined),
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/players");
                  });
                },
              ),
            ],
          ),
          // exit app --
          ListTile(
            title: Text("E X I T"),
            leading: Icon(Icons.exit_to_app_rounded),
            onTap: exitApp,
          ),
        ],
      ),
    );
  }
}
