import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';
import 'package:agalarla_mac/basic_classes/leagues_class.dart';
import 'package:agalarla_mac/repositories/leagues_repository.dart';
import 'package:agalarla_mac/profile_screen/chipwrap.dart';
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
                                  'Abone olunan ligler',
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

class AddLeagueButton extends ConsumerWidget {
  const AddLeagueButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSubscribedLeagues =
        ref.watch(userSubscribedLeaguesRepository.notifier);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.appSwatch.shade100,
        shape: const StadiumBorder(),
      ),
      onPressed: () {
        buildShowGeneralDialog(context);
        userSubscribedLeagues.update((state) {
          return state +
              [
                League('add ile eklendi',
                    AssetImage('assets/Premier_League_Logo.png'))
              ];
        });
      },
      child: Text(
        'add+',
        style: TextStyle(fontSize: 14, color: neonGreen),
      ),
    );
  }

  Future<Object?> buildShowGeneralDialog(BuildContext context) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      color: Palette.appSwatch.shade600),
                  padding: const EdgeInsets.all(12),
                  child: Material(
                    type: MaterialType.transparency,
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    child: const AddLeagueDialog(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 200),
    );
  }
}

enum SportsType {futbol, basketbol, voleybol}
enum Leagues {superlig, premierleague, bundesliga, ligue1}

class AddLeagueDialog extends StatefulWidget {
  const AddLeagueDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<AddLeagueDialog> createState() => _AddLeagueDialogState();
}

class _AddLeagueDialogState extends State<AddLeagueDialog> {

  final Map<String, dynamic> leagueValues = {};
  final _addLeagueFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: _addLeagueFormKey,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
                child: Text('Spor',)),
            const SizedBox(height: 10,),
            DropdownButtonFormField(
              hint: const Text(
                'spor seç',
                style:
                TextStyle(fontSize: 14, color: Colors.grey,),
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                border: Theme.of(context).inputDecorationTheme.border,
                enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                constraints: const BoxConstraints(maxWidth: double.infinity, maxHeight: 60)
              ),
              dropdownColor: Palette.appSwatch.shade500,
                items: [
                  DropdownMenuItem(
                    value: SportsType.basketbol,
                    child: Text('Basketbol',
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                  DropdownMenuItem(
                    value: SportsType.futbol,
                    child: Text('Futbol',
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                  DropdownMenuItem(
                    value: SportsType.voleybol,
                    child: Text('Voleybol',
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                ],
                onChanged: (value) {},
                validator: (value) {
                  if (value == null) {
                    return 'Bir spor seç';
                  }
                },
                onSaved: (newValue) {
                  setState(() {
                    leagueValues['arkadasGrubu'] = newValue;
                  });
                },
            ),
            const SizedBox(height: 18,),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text('Lig seç',),
            ),
            const SizedBox(height: 10,),
            DropdownButtonFormField(
              hint: const Text(
                'spor seç',
                style:
                TextStyle(fontSize: 14, color: Colors.grey,),
              ),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                  border: Theme.of(context).inputDecorationTheme.border,
                  enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                  focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                  constraints: const BoxConstraints(maxWidth: double.infinity, maxHeight: 60)
              ),
              dropdownColor: Palette.appSwatch.shade500,
              items: [
                DropdownMenuItem(
                  value: SportsType.basketbol,
                  child: Text('Basketbol',
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                DropdownMenuItem(
                  value: SportsType.futbol,
                  child: Text('Futbol',
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                DropdownMenuItem(
                  value: SportsType.voleybol,
                  child: Text('Voleybol',
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ],
              onChanged: (value) {},
              validator: (value) {
                if (value == null) {
                  return 'Bir spor seç';
                }
              },
              onSaved: (newValue) {
                setState(() {
                  leagueValues['arkadasGrubu'] = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
