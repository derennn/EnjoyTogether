import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'fixture_screen/fixturepage.dart';
import 'themecolors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
    required this.mainScreenContext,
    required this.onScreenHideButtonPressed,
    required this.hideStatus,
  }) : super(key: key);

  final BuildContext mainScreenContext;
  final VoidCallback onScreenHideButtonPressed;
  final bool hideStatus;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool whichPage = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Palette.appSwatch.shade500,
          body: SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        constraints: const BoxConstraints(),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.person_add_alt_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      IconButton(
                        constraints: const BoxConstraints(),
                        onPressed: () {},
                        icon: const Icon(
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
                    height: 10,
                  ),
                  const Text('Deren Bayar'),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)))),
                    onPressed: () {},
                    child: const Text('Profili Düzenle'),
                  ),
                  const SizedBox(height: 10,),
                  const TabBar(
                    labelColor: Palette.neonGreenShades,
                    indicatorColor: Palette.neonGreenShades,
                    unselectedLabelColor: Colors.grey,
                    tabs: <Tab>[
                      Tab(text: 'Event Geçmişim'),
                      Tab(text: 'Arkadaşlarım'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ListView.separated(
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('Aktivite X',
                                  style:
                                  Theme.of(context).textTheme.bodySmall),
                              trailing: const Icon(Icons.add, color: Colors.white),
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: Colors.white,
                              endIndent: 10,
                              indent: 10,
                              height: 0,
                            );
                          },
                        ),
                        ListView.separated(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('Ecem',
                                  style:
                                  Theme.of(context).textTheme.bodySmall),
                              trailing: const Icon(Icons.add, color: Colors.white),
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: Colors.white,
                              endIndent: 10,
                              indent: 10,
                              height: 0,
                            );
                          },
                        ),
                      ]
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}