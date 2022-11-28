import 'package:flutter/material.dart';
import 'fixturepage.dart';
import 'themecolors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool whichPage = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Palette.appSwatch.shade400,
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      constraints: BoxConstraints(),
                      onPressed: () {},
                      icon: Icon(
                        Icons.person_add_alt_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    IconButton(
                      constraints: BoxConstraints(),
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
                const InkWell(
                  child: CircleAvatar(
                    radius: 60,
                    child: FractionallySizedBox(
                      widthFactor: 0.65,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text('DB'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text('Deren Bayar'),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)))
                  ),
                  onPressed: () {},
                  child: Text('Profili Düzenle'),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          whichPage = !whichPage;
                        });
                      },
                      child: Text(
                        'Eventlerim',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          whichPage = !whichPage;
                        });
                      },
                      child: Text(
                        'Arkadaşlarım',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.white,
                ),
                Expanded(
                    child: whichPage == true
                        ? ListView.separated(
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text('Aktivite X',
                                    style: Theme.of(context).textTheme.bodySmall),
                                trailing: Icon(Icons.add, color: Colors.white),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Colors.white,
                                endIndent: 10,
                                indent: 10,
                                height: 0,
                              );
                            },
                          )
                        : ListView.separated(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text('Ecem',
                                    style: Theme.of(context).textTheme.bodySmall),
                                trailing: Icon(Icons.add, color: Colors.white),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                color: Colors.white,
                                endIndent: 10,
                                indent: 10,
                                height: 0,
                              );
                            },
                          )),
              ],
            ),
          ),
        ));
  }
}
