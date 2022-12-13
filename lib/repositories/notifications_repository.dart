import 'package:agalarla_mac/basic_classes/event_class.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agalarla_mac/basic_classes/notification_class.dart';
import 'package:agalarla_mac/repositories/events_repository.dart';

class NotificationsRepository extends StateNotifier<List>{
  NotificationsRepository(List state) : super(state);

  void deleteNotifs() {
    state = [];
  }
}

final notificationsProvider = StateNotifierProvider<NotificationsRepository, List>((ref) {
  return NotificationsRepository(ref.watch(eventsRepositoryProvider).events);
});

class UncheckedNotificationCount extends StateNotifier<int>{
  UncheckedNotificationCount(int state) : super(state);

  void userCheckedNotifs () {
    state = 0;
  }
}

final uncheckedNotificationCountProvider = StateNotifierProvider<UncheckedNotificationCount, int>((ref) {
  return UncheckedNotificationCount(ref.watch(notificationsProvider).length);
});

final notificationProvider2 = StateProvider<bool>((ref) => true);