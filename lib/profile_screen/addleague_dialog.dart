import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';
import 'package:agalarla_mac/basic_classes/leagues_class.dart';
import 'package:agalarla_mac/repositories/leagues_repository.dart';
import '../themecolors.dart';
import 'package:agalarla_mac/available_leagues.dart';

class AddLeagueButton extends ConsumerWidget {
  const AddLeagueButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.appSwatch.shade100,
        shape: const StadiumBorder(),
      ),
      onPressed: () {
        buildShowGeneralDialog(context);
      },
      child: Text(
        'ekle+',
        style: TextStyle(fontSize: 14, color: neonGreen),
      ),
    );
  }

  Future<Object?> buildShowGeneralDialog(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      transitionBuilder:
          (context, animation, secondaryAnimation, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5 * animation.value, sigmaY: 5 * animation.value),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
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

class AddLeagueDialog extends ConsumerStatefulWidget {
  const AddLeagueDialog({
    Key? key,
  }) : super(key: key);

  @override
  _AddLeagueDialogState createState() => _AddLeagueDialogState();
}

class _AddLeagueDialogState extends ConsumerState<AddLeagueDialog> {

  final Map<String, dynamic> leagueValues = {};
  final _addLeagueFormKey = GlobalKey<FormState>();

  Iterable<DropdownMenuItem> get dropDownSportsItems {
    final sportsItems = ref.read(availableSportsProvider).toList();
    return sportsItems.map((value) {
      return DropdownMenuItem(
          value: value,
          child: Text(value,
              style: const TextStyle(fontSize: 14)),
      );
    });
  }

  Iterable<DropdownMenuItem> get dropDownLeagueItems {
    final leagueItems = ref.read(availableFootballLeaguesProvider).toList();
    return leagueItems.map((value) {
      return DropdownMenuItem(
          value: value,
          child: Text(value,
            style: const TextStyle(fontSize: 14)),
      );
    });
  }

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
            const SizedBox(height: 12,),
            DropdownButtonFormField(
              hint: const Text(
                'spor seç',
                style:
                TextStyle(fontSize: 14, color: Colors.grey,),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  border: Theme.of(context).inputDecorationTheme.border,
                  enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                  focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                  constraints: const BoxConstraints(maxWidth: double.infinity, maxHeight: 60)
              ),
              dropdownColor: Palette.appSwatch.shade400,
              items: dropDownSportsItems.toList(),
              onChanged: (value) {},
              validator: (value) {
                if (value == null) {
                  return 'Bir spor seç';
                }
              },
              onSaved: (newValue) {
                setState(() {
                  leagueValues['sports'] = newValue;
                });
              },
            ),
            const SizedBox(height: 18,),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Lig',),
            ),
            const SizedBox(height: 12,),
            DropdownButtonFormField(
              hint: const Text(
                'lig seç',
                style:
                TextStyle(fontSize: 14, color: Colors.grey,),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  border: Theme.of(context).inputDecorationTheme.border,
                  enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
                  focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
                  constraints: const BoxConstraints(maxWidth: double.infinity, maxHeight: 60)
              ),
              dropdownColor: Palette.appSwatch.shade400,
              items: dropDownLeagueItems.toList(),
              onChanged: (value) {},
              validator: (value) {
                if (value == null) {
                  return 'Bir lig seç';
                }
              },
              onSaved: (newValue) {
                setState(() {
                  leagueValues['league'] = newValue;
                });
              },
            ),
            const SizedBox(height: 18,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Palette.neonGreenShades, padding: const EdgeInsets.symmetric(horizontal: 30)),
              onPressed: () {
                final formState = _addLeagueFormKey.currentState;
                if (formState == null) return;
                if (formState.validate() == true) {
                  formState.save();
                  saveFormFunc(leagueValues);
                }
              },
              child: Text('Ekle',
                style: TextStyle(color: Palette.appSwatch.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveFormFunc(Map<String, dynamic> leagueValues) {
    switch (leagueValues['league']) {
      case 'Süper Lig': {
        leagueValues['image'] = const AssetImage('assets/super_lig_logo.png');
      }
      break;
      case 'Premier League': {
        leagueValues['image'] = const AssetImage('assets/Premier_League_Logo.png');
      }
      break;
      case 'Bundesliga' : {
        leagueValues['image'] = const AssetImage('assets/bundesliga_logo.png');
      }
      break;
      case 'Ligue1' : {
        leagueValues['image'] = const AssetImage('assets/ligue1_uber_eats_logo.png');
      }
      break;
      default : {
        leagueValues['image'] = const AssetImage('assets/image_not_found.png');
      }
    }
    ref.read(userSubscribedLeaguesRepository.notifier).update((state) {
      return state + [SportsLeague.fromMap(leagueValues)];
    });
    if (!mounted) return;
    Navigator.pop(context);
  }
}