import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationsRepository extends StateNotifier<bool> {
  NotificationsRepository(bool state) : super(state);

  void sifirla() {
    state = false;
  }
}

final notificationsProvider = StateNotifierProvider<NotificationsRepository, bool>((ref) {
  return NotificationsRepository(true);
});