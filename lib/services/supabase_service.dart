import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/queue_item.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  SupabaseClient get client => Supabase.instance.client;

  Future<void> enqueue(QueueItem item) async {
    try {
      await client.from('queue').insert(item.toJson());
    } catch (e) {
      // Handle error or rethrow
      rethrow;
    }
  }

  Future<void> updateName(String id, String newName) async {
    try {
      await client.from('queue').update({'name': newName}).eq('id', id);
    } catch (e) {
      rethrow;
    }
  }

  Future<QueueItem?> dequeue() async {
    try {
      // 1. Get the first person in line
      final List<dynamic> response = await client
          .from('queue')
          .select()
          .order('joined_at', ascending: true)
          .limit(1);
      
      if (response.isEmpty) return null;

      final itemData = response.first;
      final item = QueueItem.fromJson(itemData);

      // 2. Remove them
      await client.from('queue').delete().eq('id', item.id);
      
      return item;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<QueueItem>> getQueueStream() {
    return client
        .from('queue')
        .stream(primaryKey: ['id'])
        .order('joined_at', ascending: true)
        .map((data) => data.map((json) => QueueItem.fromJson(json)).toList());
  }
}
