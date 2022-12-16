import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:agalarla_mac/basic_classes/leagues.dart';
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
                  DecoratedBox(
                    decoration: BoxDecoration(
                        color: Palette.appSwatch.shade400,
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(8),
                        ),
                        boxShadow: const [
                          BoxShadow(offset: Offset(0, 0),
                          spreadRadius: 0,
                          blurRadius: 30),
                        ]),
                    child: Column(
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
                        const TabBar(
                          indicatorSize: TabBarIndicatorSize.label,
                          labelColor: Palette.neonGreenShades,
                          indicatorColor: Palette.neonGreenShades,
                          unselectedLabelColor: Colors.grey,
                          tabs: <Tab>[
                            Tab(text: 'Takip ettiğin ligler'),
                            Tab(text: 'Arkadaşlarım'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Abone olunan ligler',
                              style: Theme.of(context).textTheme.bodySmall,
                              ),
                              SubscribedLeagueChipWrap(),
                            ],
                          ),
                        ),
                        ListView.separated(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return ExpansionTile(
                              title: Text('Ecem', style: Theme.of(context).textTheme.bodySmall),
                              iconColor: Colors.white,
                              collapsedIconColor: Colors.grey,
                              backgroundColor: Palette.appSwatch.shade300,
                              tilePadding: const EdgeInsets.symmetric(horizontal: 10),
                              childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
                              children: [
                                ListTile(leading: Text('Ortak grup:', style: Theme.of(context).textTheme.bodySmall), dense: true,),
                              ],
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

class SubscribedLeagueChipWrap extends StatefulWidget {
  const SubscribedLeagueChipWrap({
    Key? key,
  }) : super(key: key);

  @override
  State<SubscribedLeagueChipWrap> createState() => _SubscribedLeagueChipWrapState();
}

class _SubscribedLeagueChipWrapState extends State<SubscribedLeagueChipWrap> {

  final List<League> _leagues = <League>[
    League('Premier League', AssetImage('assets/Premier_League_Logo.png')),
    League('Süper Lig', AssetImage('assets/super_lig_logo.png')),
  ];

  Iterable<Widget> get leagueChips {
    return _leagues.map((League league) {
      return Chip(
        padding: const EdgeInsets.all(4) + const EdgeInsets.symmetric(horizontal: 4),
        deleteIcon: Icon(Icons.close, size: 20, color: Palette.appSwatch.shade300,),
        onDeleted: () {
          setState(() {
            _leagues.removeWhere((League entry) {
              return entry.name == league.name;
            });
          });
        },
        avatar: Image(
          image: league.image,
        ),
        label: Text(league.name, style: TextStyle(color: Palette.appSwatch.shade800, fontSize: Theme.of(context).textTheme.bodySmall!.fontSize),),
        backgroundColor: const Color(0xffa7aaaf),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      verticalDirection: VerticalDirection.down,
      spacing: 10,
      children: leagueChips.toList(),
    );
  }
}