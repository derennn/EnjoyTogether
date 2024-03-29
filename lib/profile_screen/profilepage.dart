import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';
import 'package:agalarla_mac/profile_screen/chipwrap.dart';
import 'package:agalarla_mac/profile_screen/addleague_dialog.dart';
import '../themecolors.dart';

class ProfilePage extends ConsumerStatefulWidget {
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
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  bool whichPage = true;

  @override
  Widget build(BuildContext context) {
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
                        BoxShadow(
                            offset: Offset(0, 0),
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
                  child: TabBarView(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Takip ettiğin ligler',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(width: 10),
                                const AddLeagueButton(),
                              ],
                            ),
                            const SubscribedLeagueChipWrap(),
                          ],
                        ),
                      ),
                    ),
                    ListView.separated(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          title: Text('Ecem',
                              style: Theme.of(context).textTheme.bodySmall),
                          iconColor: Colors.white,
                          collapsedIconColor: Colors.grey,
                          backgroundColor: Palette.appSwatch.shade300,
                          tilePadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          childrenPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          children: [
                            ListTile(
                              leading: Text('Ortak grup:',
                                  style: Theme.of(context).textTheme.bodySmall),
                              dense: true,
                            ),
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
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}