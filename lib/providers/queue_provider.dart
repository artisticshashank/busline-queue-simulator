import 'package:flutter/material.dart';
import 'dart:math';
import '../models/queue_item.dart';
import '../services/supabase_service.dart';

class QueueProvider extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();

  List<QueueItem> _queue = [];
  List<QueueItem> get queue => _queue;

  // Logs for "Learning Mode"
  final List<String> _logs = [];
  List<String> get logs => _logs;

  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  QueueProvider() {
    _initSubscription();
  }

  void _initSubscription() {
    try {
      _supabaseService.getQueueStream().listen(
        (data) {
          _queue = data;
          notifyListeners();
        },
        onError: (error) {
          _addLog("Error syncing data: $error");
        },
      );
    } catch (e) {
      _addLog("Supabase not initialized or error: $e");
    }
  }

  Future<void> addPerson() async {
    final names = [
      'Alice',
      'Bob',
      'Charlie',
      'Diana',
      'Evan',
      'Fiona',
      'George',
      'Hannah',
      'Ian',
      'Julia',
    ];
    final random = Random();
    final name = names[random.nextInt(names.length)];
    // Random avatar index 0-4
    final avatarIndex = random.nextInt(5);

    final newItem = QueueItem.create(name: name, avatarIndex: avatarIndex);

    _addLog("Enqueue: Adding ${newItem.name} to the line...");

    try {
      await _supabaseService.enqueue(newItem);
      // Success log is optional as the stream will update the UI
    } catch (e) {
      _addLog("Enqueue Failed: $e");
    }
  }

  Future<void> removePerson() async {
    if (_queue.isEmpty) {
      _addLog("Dequeue: Queue is empty, no one to board.");
      return;
    }

    _addLog("Dequeue: Calculating who boards next...");

    try {
      final removed = await _supabaseService.dequeue();
      if (removed != null) {
        _addLog("Dequeue: ${removed.name} boarded the bus!");
      } else {
        _addLog("Dequeue: Operation missed (race condition?).");
      }
    } catch (e) {
      _addLog("Dequeue Failed: $e");
    }
  }

  Future<void> updatePersonName(String id, String newName) async {
    try {
      final itemIndex = _queue.indexWhere((item) => item.id == id);
      if (itemIndex != -1) {
        final oldName = _queue[itemIndex].name;
        _addLog("Update: Renaming $oldName to $newName...");
        await _supabaseService.updateName(id, newName);
        // Optimistic update or wait for stream?
        // Stream should handle it, but we can log success
      }
    } catch (e) {
      _addLog("Update Failed: $e");
    }
  }

  void _addLog(String message) {
    // Add new log at the top
    _logs.insert(0, message);
    if (_logs.length > 50) _logs.removeLast();
    notifyListeners();
  }
}
