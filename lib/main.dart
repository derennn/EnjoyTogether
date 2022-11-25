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
          bodySmall: TextStyle(fontSize: 14.0, color: Colors.white),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
        backgroundColor: Palette.appSwatch.shade100,
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ProfilePage();
                },
              ),
            );
          }
        },
        currentIndex: index,
        elevation: 20,
      ),
      backgroundColor: Palette.appSwatch.shade200,
      body: FixturePage(),
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
              separatorBuilder: (context, index) => SizedBox(
                height: 8,
              ),
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
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
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
          Text(
            'Super Lig',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: 5),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Galatasaray',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '-',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Fenerbahçe',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '19.00',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: () {},
                child: Text('Açık Eventler',
                    style: TextStyle(color: Color(0xff1be2c7))),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      backgroundColor: Color(0xff1be2c7)),
                  onPressed: () {},
                  child: Text(
                    'Event Aç >',
                    style: TextStyle(color: Palette.appSwatch.shade300),
                  )),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
