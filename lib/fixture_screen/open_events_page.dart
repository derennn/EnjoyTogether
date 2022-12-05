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
  with AutomaticKeepAliveClientMixin{

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
                  data: (data) => ListView.separated(
                    physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                      shrinkWrap: false,
                      itemBuilder: (context, index) =>
                          EventContainer(event : data[index]),
                      separatorBuilder: (context, index) => const Divider(),
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

class EventContainer extends ConsumerWidget {
  const EventContainer({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
          color: Palette.appSwatch.shade700,
          borderRadius: BorderRadius.all(Radius.circular(24))),
      child: Center(
        child: Text(event.lokasyon),
      ),
    );
  }
}