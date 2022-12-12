import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'fixture_screen/fixturepage.dart';
import 'notificationpage.dart';
import 'profilepage.dart';
import 'themecolors.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

late BuildContext testContext;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Palette.appSwatch,
                )
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Palette.appSwatch,
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Palette.appSwatch,
                )
            ),
          hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
        ),
        primarySwatch: Palette.appSwatch,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 22.0, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 18.0, color: Colors.white),
          bodySmall: TextStyle(fontSize: 15.0, color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: const LoginScreen(),
      initialRoute: "/",
      routes: const {},
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({final Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Login Screen"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                child: const Text("Log in"),
                onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: MainPage(
                    mainScreenContext: context,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.mainScreenContext}) : super(key: key);

  final BuildContext mainScreenContext;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PersistentTabController _controller = PersistentTabController();
  bool _hideNavBar = false;

  List<Widget> _buildScreens() => [
        FixturePage(
          mainScreenContext: widget.mainScreenContext,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
        ),
        NotificationPage(
          mainScreenContext: widget.mainScreenContext,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
        ),
        ProfilePage(
          mainScreenContext: widget.mainScreenContext,
          hideStatus: _hideNavBar,
          onScreenHideButtonPressed: () {
            setState(() {
              _hideNavBar = !_hideNavBar;
            });
          },
        ),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.home),
            inactiveIcon: const Icon(Icons.home_outlined),
            title: "Home",
            activeColorPrimary: neonGreen,
            inactiveColorPrimary: Colors.white),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.notifications),
          inactiveIcon: const Icon(Icons.notifications_none_outlined),
          title: "Profile",
          activeColorPrimary: neonGreen,
          inactiveColorPrimary: Colors.white,
          routeAndNavigatorSettings: const RouteAndNavigatorSettings(
            initialRoute: "/",
            routes: {
              //"/first": (final context) => const MainScreen2(),
              //"/second": (final context) => const MainScreen3(),
            },
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          inactiveIcon: const Icon(Icons.person_outline),
          title: "Profile",
          activeColorPrimary: neonGreen,
          inactiveColorPrimary: Colors.white,
          routeAndNavigatorSettings: const RouteAndNavigatorSettings(
            initialRoute: "/",
            routes: {
              //"/first": (final context) => const MainScreen2(),
              //"/second": (final context) => const MainScreen3(),
            },
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          resizeToAvoidBottomInset: true,
          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight,
          bottomScreenMargin: kBottomNavigationBarHeight,
          selectedTabScreenContext: (final context) {
            testContext = context!;
          },
          backgroundColor: Palette.appSwatch.shade700,
          hideNavigationBar: _hideNavBar,
          decoration:
              const NavBarDecoration(colorBehindNavBar: Palette.appSwatch),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
          ),
          navBarStyle: NavBarStyle.style5,
        ));
  }
}
