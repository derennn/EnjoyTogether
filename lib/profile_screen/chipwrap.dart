import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agalarla_mac/repositories/leagues_repository.dart';
import 'package:agalarla_mac/basic_classes/leagues_class.dart';
import '../themecolors.dart';

class SubscribedLeagueChipWrap extends ConsumerStatefulWidget {
  const SubscribedLeagueChipWrap({
    Key? key,
  }) : super(key: key);

  @override
  _SubscribedLeagueChipWrapState createState() => _SubscribedLeagueChipWrapState();
}

class _SubscribedLeagueChipWrapState extends ConsumerState<SubscribedLeagueChipWrap> {

  Iterable<Widget> get leagueChips {
    return ref.watch(userSubscribedLeaguesRepository).map((League league) {
      return Chip(
        padding: const EdgeInsets.all(4) + const EdgeInsets.symmetric(horizontal: 4),
        deleteIcon: Icon(Icons.close, size: 20, color: Palette.appSwatch.shade300,),
        onDeleted: () {
          ref.watch(userSubscribedLeaguesRepository.notifier).update((state) {
            List<League> newState = state.where((league) => league != state.last).toList();
            return newState;
          });
        },
        avatar: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image(
            image: league.image,
          ),
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