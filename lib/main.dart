import 'package:agalarla_mac/basic_classes/event_class.dart';
import 'package:agalarla_mac/repositories/events_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'fixture_screen/fixturepage.dart';
import 'package:agalarla_mac/repositories/notifications_repository.dart';
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
          )),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Palette.appSwatch,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Palette.appSwatch,
          )),
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
          icon: const NotificationCountBadge(
              icon: Icon(Icons.notifications),
              boxColor: Palette.neonGreenShades),
          inactiveIcon: const NotificationCountBadge(
              icon: Icon(Icons.notifications_none_outlined),
              boxColor: Colors.white),
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
      decoration: const NavBarDecoration(colorBehindNavBar: Palette.appSwatch),
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

class NotificationCountBadge extends ConsumerWidget {
  const NotificationCountBadge({
    required this.icon,
    required this.boxColor,
    Key? key,
  }) : super(key: key);

  final Icon icon;
  final Color boxColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uncheckedNotifCount = ref.watch(notificationsProvider);
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        icon,
        Positioned(
          right: 0,
          top: 5,
          child: uncheckedNotifCount.when(
            data: (data) {
              return Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: boxColor,
                  border: Border.all(
                    width: 1.5,
                    color: Palette.appSwatch.shade700,
                  ),
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minHeight: 12, minWidth: 12),
                height: 15,
                width: 15,
                child: Text(
                  '${data.length}',
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: Palette.appSwatch.shade700),
                  textAlign: TextAlign.center,
                ),
              );
            },
            error: (error, stackTrace) {
              return const SizedBox();
            },
            loading: () {
              return SizedBox(
                height: 15,
                width: 15,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Palette.appSwatch.shade700,
                      shape: BoxShape.circle),
                  child: const Padding(
                    padding: EdgeInsets.all(3),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/*
class NotificationCountBadge extends ConsumerWidget {
  const NotificationCountBadge({
    required this.icon,
    required this.boxColor,
    Key? key,
  }) : super(key: key);

  final Icon icon;
  final Color boxColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uncheckedNotifCount = ref.watch(eventsListProvider.future);
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        icon,
        Positioned(
          right: 0,
          top: 5,
          child: FutureBuilder(
            future: uncheckedNotifCount,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: boxColor,
                    border: Border.all(
                      width: 1.5,
                      color: Palette.appSwatch.shade700,
                    ),
                    shape: BoxShape.circle,
                  ),
                  constraints:
                      const BoxConstraints(minHeight: 12, minWidth: 12),
                  height: 16,
                  width: 16,
                  child: Text(
                    '${snapshot.data!.length}',
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        color: Palette.appSwatch.shade700),
                    textAlign: TextAlign.center,
                  ),
                );
              } else if (snapshot.hasError) {
                return const SizedBox();
              } else {
                return SizedBox(
                  height: 8,
                  width: 8,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Palette.appSwatch.shade700, shape: BoxShape.circle),
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1,
                      ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
*/
