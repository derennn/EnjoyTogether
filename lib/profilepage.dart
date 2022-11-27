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
        backgroundColor: Palette.appSwatch.shade200,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.person_add_alt_outlined,
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
              SizedBox(
                height: size.height * 0.03,
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
                color: Colors.grey,
                thickness: 1,
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
                              color: Colors.grey,
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
                              color: Colors.grey,
                            );
                          },
                        )),
            ],
          ),
        ));
  }
}
