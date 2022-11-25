import 'package:flutter/material.dart';
import 'profilepage.dart';
import 'themecolors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Palette.appSwatch,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 22.0, color: Colors.white),
          bodyMedium: TextStyle(fontSize: 18.0, color: Colors.white),
          bodySmall: TextStyle(fontSize: 14.0,color: Colors.white),
        ),
      ),
      home: const MyHomePage(title: 'Agalarla Maç v.0.0.1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;

  final screens = [
    FixturePage(),
    ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
        backgroundColor: Palette.appSwatch.shade100,
      ),
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
          selectedIndex: index,
          onDestinationSelected: (value) =>
          setState(() {
            index = value;
          }),
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
      backgroundColor: Palette.appSwatch.shade200,
      body: screens[index],
    );
  }
}

class FixturePage extends StatelessWidget {
  const FixturePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView.separated(
              itemCount: 12,
              itemBuilder: (context, index) {
                return FixtureBlock();
              },
              separatorBuilder: (context, index) => SizedBox(height: 8,),
            ),
          ),
        ],
      ),
    );
  }
}

class FixtureBlock extends StatelessWidget {
  const FixtureBlock({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18),),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Palette.appSwatch.shade300,
              Palette.appSwatch.shade500,
            ],
          ),
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Text('Super Lig',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: 5),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Galatasaray',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text('-',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text('Fenerbahçe',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: 10),
          Text('19.00',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                  onPressed: () {},
                  child: Text('Açık Eventler',
                  style: TextStyle(color: Color(0xff1be2c7))),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))), backgroundColor: Color(0xff1be2c7)),
                onPressed: () {},
                child: Text('Event Aç >',
                  style: TextStyle(color: Palette.appSwatch.shade300),
                )
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}