import 'package:agalarla_mac/themecolors.dart';
import 'package:flutter/material.dart';

class NavBarDenemeWidget extends StatefulWidget {
  const NavBarDenemeWidget({Key? key}) : super(key: key);

  @override
  State<NavBarDenemeWidget> createState() => _NavBarDenemeWidgetState();
}

class _NavBarDenemeWidgetState extends State<NavBarDenemeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blue.shade100,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          )
        ),
        child: NavigationBar(
          height: 60,
          backgroundColor: Palette.appSwatch.shade700,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.email_outlined),
              label: 'Mail',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu),
              label: 'Menu',
            )
          ],
        ),
      ),
    );
  }
}


BottomNavigationBar(
showSelectedLabels: false,
showUnselectedLabels: false,
backgroundColor: Palette.appSwatch.shade800,
unselectedItemColor: Colors.white,
selectedItemColor: neonGreen,
selectedIconTheme: IconThemeData(size: 32),
items: const [
BottomNavigationBarItem(
icon: Icon(Icons.scoreboard),
label: '',
),
BottomNavigationBarItem(
icon: Icon(Icons.apps_rounded),
label: 'icon2',
),
BottomNavigationBarItem(
icon: Icon(Icons.person),
label: 'Text',
)
],
onTap: (value) {
setState(() {
index = value;
});
if (value == 2) {
Navigator.push(context, MaterialPageRoute(builder: (context) {
return ProfilePage();
},
),
);
}
},
currentIndex: index,
elevation: 20,
),