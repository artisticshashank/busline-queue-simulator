import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/queue_provider.dart';
import '../widgets/person_avatar.dart';

class BusStopScreen extends StatelessWidget {
  const BusStopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BusLine – Queue Simulator'),
        elevation: 2,
      ),
      body: Column(
        children: [
          // 1. Queue Visualization Area
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[100],
              width: double.infinity,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  // Background hints (Bus Stop sign, road markings?)
                  Positioned(
                    left: 20,
                    top: 20,
                    child: Icon(Icons.directions_bus, size: 40, color: Colors.grey[400]),
                  ),
                  
                  // The Queue
                  Consumer<QueueProvider>(
                    builder: (context, provider, child) {
                      if (provider.queue.isEmpty) {
                        return Center(
                          child: Text(
                            "The bus stop is empty.\nTap + to add people!",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey[500], fontSize: 16),
                          ),
                        );
                      }
                      
                      return ListView.builder(
                        padding: const EdgeInsets.only(left: 60, right: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.queue.length,
                        itemBuilder: (context, index) {
                          final item = provider.queue[index];
                          // Simple animation wrapper? 
                          // unique key is important for ListView to track items
                          return PersonAvatar(
                            key: ValueKey(item.id),
                            item: item,
                            index: index,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          
          // 2. Info Panel / Logs
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.blueGrey[50],
                    child: const Text("Operations Log (Learning Mode)", 
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
                    ),
                  ),
                  Expanded(
                    child: Consumer<QueueProvider>(
                      builder: (context, provider, child) {
                        return ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: provider.logs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2.0),
                              child: Text(
                                provider.logs[index],
                                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: "enqueue",
            onPressed: () {
              context.read<QueueProvider>().addPerson();
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Person (Enqueue)"),
            backgroundColor: Colors.green,
          ),
          const SizedBox(height: 16),
          FloatingActionButton.extended(
            heroTag: "dequeue",
            onPressed: () {
              context.read<QueueProvider>().removePerson();
            },
            icon: const Icon(Icons.directions_bus),
            label: const Text("Board Bus (Dequeue)"),
            backgroundColor: Colors.redAccent,
          ),
        ],
      ),
    );
  }
}
