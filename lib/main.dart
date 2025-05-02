import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // For timeDilation

void main() {
  timeDilation = 2.0;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero Animation List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ItemListScreen(),
    );
  }
}

class Item {
  final String id;
  final String title;
  final String imageUrl;

  Item({required this.id, required this.title, required this.imageUrl});
}

// Sample dynamic list
final List<Item> items = List.generate(
  10,
  (index) => Item(
    id: 'item$index',
    title: 'Item $index',
    imageUrl: 'https://picsum.photos/seed/item$index/200/200',
  ),
);

class ItemListScreen extends StatelessWidget {
  void _navigateToDetail(BuildContext context, Item item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dynamic List')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          VoidCallback? onTapCallback = () => _navigateToDetail(context, item);

          return InkWell(
            onTap: onTapCallback,
            child: ListTile(
              leading: Hero(
                tag: item.id,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(item.imageUrl),
                ),
              ),
              title: Text(item.title),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Item item;

  const DetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Center(
        child: Hero(
          tag: item.id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              item.imageUrl,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
