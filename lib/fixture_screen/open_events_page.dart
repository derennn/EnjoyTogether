import 'dart:ui';

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
  bool idc = false;

  void toggleIdc () {
    setState(() {
      idc = !idc;
    });
  }

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
        child: Stack(
          children: [
            Column(
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
                            EventTile(event: data[index], index: index, idc: toggleIdc),
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
            Positioned(
              top: 200, left: 0, right: 0,
              child: Center(
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 200),
                  opacity: idc ? 1 : 0,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: AnimatedContainer(
                      height: idc ? 150 : 50,
                      width: idc ? MediaQuery.of(context).size.width : 50,
                      duration: Duration(milliseconds: 200),
                      color: Palette.appSwatch.shade700,
                      child: idc
                          ? OpenEventsPageTileColumn(var1: 'denemelik lokasyon', var2: false)
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OpenEventsPageTileColumn extends StatelessWidget {
  const OpenEventsPageTileColumn({
    required this.var1,
    required this.var2,
    Key? key,
  }) : super(key: key);

  final String var1;
  final bool var2;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            Text(var1,
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
                var2 ? 'Arkadaş getirebilirsin' : 'Arkadaş getirme',
                style: const TextStyle(
                    fontSize: 14, color: Colors.white)),
          ],
        ),
      ],
    );
  }
}

class EventTile extends ConsumerStatefulWidget {
  const EventTile({
    Key? key,
    required this.idc,
    required this.event,
    required this.index,
  }) : super(key: key);

  final VoidCallback idc;
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
          title: OpenEventsPageTileColumn(var1: widget.event.lokasyon, var2: widget.event.arkadasGetirmekSerbestMi),
          contentPadding: const EdgeInsets.all(15),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          selectedTileColor: Palette.appSwatch.shade600,
          selected: ref.watch(selectedTileProvider) == widget.index,
          onTap: () {
            widget.idc();
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