import 'package:agalarla_mac/event/event_class.dart';
import 'package:flutter/material.dart';
import 'package:agalarla_mac/themecolors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agalarla_mac/repositories/events_repository.dart';

class OpenEventsPage extends ConsumerStatefulWidget {
  const OpenEventsPage({
    Key? key,
  }) : super(key: key);

  @override
  _OpenEventsPageState createState() => _OpenEventsPageState();
}

class _OpenEventsPageState extends ConsumerState<OpenEventsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => false;

  @override
  void initState() {
    ref.refresh(eventsListProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.appSwatch.shade500,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
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
                  const SizedBox(height: 35),
                  Center(
                    child: Text('Açık Eventler',
                        style: TextStyle(
                            fontSize: 26,
                            color: neonGreen,
                            fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: RefreshIndicator(
                backgroundColor: Colors.transparent,
                color: Colors.white,
                onRefresh: () async {
                  return ref.refresh(eventsListProvider);
                },
                child: ref.watch(eventsListProvider).when(
                      data: (data) => ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        shrinkWrap: false,
                        itemBuilder: (context, index) =>
                            EventTile(event: data[index], index: index),
                        itemCount: data.length,
                      ),
                      error: (error, stackTrace) {
                        return const Text('error');
                      },
                      loading: () {
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventTile extends ConsumerStatefulWidget {
  const EventTile({
    Key? key,
    required this.event,
    required this.index,
  }) : super(key: key);

  final Event event;
  final int index;

  @override
  _EventTileState createState() => _EventTileState();
}

class _EventTileState extends ConsumerState<EventTile> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          tileColor: Palette.appSwatch.shade700,
          title: Column(
            children: [
              const Text('Event: [Event Name]',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              const SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('[Arkadas adi] acti',
                      style: TextStyle(
                          fontSize: 14, color: Colors.white)),
                  Text('01.15.2023',
                      style: TextStyle(
                          fontSize: 14, color: Colors.white.withOpacity(0.6))),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text(widget.event.lokasyon,
                    style: const TextStyle(
                        fontSize: 14, color: Colors.white)),
                  Text('21.45',
                      style: TextStyle(
                          fontSize: 14, color: Colors.white.withOpacity(0.6))),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      widget.event.arkadasGetirmekSerbestMi ? 'Arkadaş getirebilirsin' : 'Arkadaş getirme',
                      style: const TextStyle(
                          fontSize: 14, color: Colors.white)),
                ],
              ),
            ],
          ),
          contentPadding: const EdgeInsets.all(15),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          selectedTileColor: Palette.appSwatch.shade600,
          selected: ref.watch(selectedTileProvider) == widget.index,
          onTap: () {
              ref.read(selectedTileProvider.notifier).state = widget.index;
          },
        ),
        const SizedBox(
          height: 6,
        ),
      ],
    );
  }
}

final selectedTileProvider = StateProvider<int?>((ref) => null);