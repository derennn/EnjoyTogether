import 'package:agalarla_mac/basic_classes/event_class.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agalarla_mac/repositories/events_repository.dart';
import 'package:agalarla_mac/services/data_services.dart';

class NotificationsRepository extends StateNotifier<AsyncValue<List<Event>>>{
  final DataService dataService;

  NotificationsRepository(this.dataService) : super(const AsyncValue.loading()) {
    getEvents();
  }

  final AsyncValue<List<Event>> asyncEmptyList = const AsyncValue.data([]);

  Future<void> getEvents() async {
    try {
      state = const AsyncValue.loading();
      final List<Event> events = await dataService.getAllEvents();
      if (state == asyncEmptyList) {
        return;
      } else {
        state = AsyncValue.data(events);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> userOpenedNotifScreen() async {
    state = asyncEmptyList;
  }
}

final notificationsProvider = StateNotifierProvider<NotificationsRepository, AsyncValue<List<Event>>>((ref) {
  return NotificationsRepository(ref.watch(dataServiceProvider));
});

final notificationProvider2 = StateProvider<bool>((ref) => true);

/*
class NotificationsRepository extends StateNotifier<AsyncValue<List>>{
  NotificationsRepository(state) : super(state);
}

final notificationsProvider = StateNotifierProvider<NotificationsRepository, AsyncValue<List>>((ref) {
  final eventsList = ref.watch(eventsListProvider).whenData((value) => value);
  return NotificationsRepository(eventsList);
});

final uncheckedNotificationCountProvider = StateNotifierProvider<UncheckedNotificationCount, int>((ref) {
return UncheckedNotificationCount(0);
*/