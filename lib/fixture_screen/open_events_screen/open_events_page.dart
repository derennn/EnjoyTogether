import 'dart:ui';
import 'package:agalarla_mac/basic_classes/event_class.dart';
import 'package:flutter/material.dart';
import 'package:agalarla_mac/themecolors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agalarla_mac/repositories/events_repository.dart';
import 'package:agalarla_mac/fixture_screen/open_events_screen/open_event_focused.dart';

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
    super.initState();
    if (!ref.exists(eventsListProvider)) {
      return;
    } else {
      ref.refresh(eventsListProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.appSwatch.shade500,
      body: SafeArea(
        child: Column(
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
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(
                            height: 40,
                            child: BackButton(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
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
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                backgroundColor: Colors.transparent,
                color: Colors.white,
                onRefresh: () async {
                  return ref.invalidate(eventsListProvider);
                },
                child: ref.watch(eventsListProvider).when(
                  data: (data) => ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    itemBuilder: (context, index) => EventTile(
                        event: data[index],
                        index: index),
                    itemCount: data.length,
                  ),
                  error: (error, stackTrace) {
                    return const Text('error');
                  },
                  loading: () {
                    return const Center(
                        child: CircularProgressIndicator());
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
  int joinedFriends = 8;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          tileColor: Palette.appSwatch.shade700,
          title: Column(
            children: [
              const Text('Event: [Event Name]',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${widget.event.acanKisi} tarafından açıldı', // - ${widget.event.arkadasGrubu} ile paylaştı,
                      style: const TextStyle(fontSize: 14, color: Colors.white)),
                  Text('Maç Tarihi',
                      style: TextStyle(
                          fontSize: 14, color: Colors.white.withOpacity(0.6))),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.event.lokasyon,
                      style: const TextStyle(fontSize: 14, color: Colors.white)),
                  Text('Maç saati',
                      style: TextStyle(
                          fontSize: 14, color: Colors.white.withOpacity(0.6))),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(widget.event.arkadasGetirmekSerbestMi ? 'Arkadaş getirebilirsin' : 'Arkadaş getirme',
                        style: const TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                  SizedBox(
                    height: 32,
                    width: 120,
                    child: Stack(
                      children: [
                        for (var i = 0 ; i < joinedFriends && i < 4 ; i++)
                          Positioned(
                            right: (i * (1 - .4) * 35).toDouble(),
                            top: 0,
                            bottom: 0,
                            child: CircleAvatar(
                              backgroundColor: Palette.neonGreenShades,
                              radius: 14,
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Palette.appSwatch.shade700, width: 4, strokeAlign: StrokeAlign.outside)),
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  loadingBuilder:(context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                      return CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                              : null
                                      );
                                  },
                                  "https://picsum.photos/200",
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  joinedFriends > 4
                  ? Text(' +${joinedFriends - 4}', style: const TextStyle(color: Colors.grey), textAlign: TextAlign.end,)
                  : const SizedBox(),
                ],
              ),
            ],
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          onTap: () {
            buildShowGeneralDialog(context);
          },
        ),
        const SizedBox(
          height: 6,
        ),
      ],
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
                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(24)), color: Palette.appSwatch.shade600),
                        padding: const EdgeInsets.all(12),
                        child: Material(
                          type: MaterialType.transparency,
                          textStyle: Theme.of(context).textTheme.bodyMedium,
                          child: OpenEventFocused(event: widget.event),
                        ),),
                    ),
                  ),
                ],
              );
            },
            barrierDismissible: true,
            barrierLabel: MaterialLocalizations.of(context)
                .modalBarrierDismissLabel,
            transitionDuration: const Duration(milliseconds: 200),
          );
  }
}

final selectedTileProvider = StateProvider<int?>((ref) => null);