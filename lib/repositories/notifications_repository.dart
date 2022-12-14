import 'package:agalarla_mac/basic_classes/event_class.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agalarla_mac/basic_classes/notification_class.dart';
import 'package:agalarla_mac/repositories/events_repository.dart';

class NotificationsRepository extends StateNotifier<AsyncValue<List>>{
  NotificationsRepository(state) : super(state);
}

final notificationsProvider = StateNotifierProvider<NotificationsRepository, AsyncValue<List>>((ref) {
  final eventsList = ref.watch(eventsListProvider).whenData((value) => value);
  return NotificationsRepository(eventsList);
});

class UncheckedNotificationCount extends StateNotifier<int>{
  UncheckedNotificationCount(int state) : super(state);

  void userCheckedNotifs () {
    state = 0;
  }
}

final uncheckedNotificationCountProvider = StateNotifierProvider<UncheckedNotificationCount, int>((ref) {
  return UncheckedNotificationCount(0);
});

final notificationProvider2 = StateProvider<bool>((ref) => true);