import 'package:flutter/material.dart';
import 'package:product_app/views/home/chat_detail_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chatList = [
      {
        "name": "Alex Linderson",
        "message": "How are you today?",
        "time": "2 min ago",
        "color": Colors.green[100],
        "unread": false,
        "avatar": "lib/assets/9318a2556f09aa6ed839fa7b57767edf7998c27a.png",
      },
      {
        "name": "John Ahraham",
        "message": "Hey! Can you join the meeting?",
        "time": "2 min ago",
        "color": Colors.yellow[100],
        "unread": true,
        "count": 3,
        "avatar": "lib/assets/9318a2556f09aa6ed839fa7b57767edf7998c27a.png",
      },
      {
        "name": "Sabila Sayma",
        "message": "How are you today?",
        "time": "2 min ago",
        "color": Colors.pink[100],
        "unread": false,
        "avatar": "lib/assets/acc555fcae8944d537bb4f687e174da6c6cb4b25.png",
      },
      {
        "name": "John Borino",
        "message": "Have a good day 🌸",
        "time": "2 min ago",
        "color": Colors.blue[100],
        "unread": false,
        "avatar": "lib/assets/dbde5058d24a732b30128c0e1fea4e97b9530bf0.png",
      },
      {
        "name": "Angel Dayna",
        "message": "How are you today?",
        "time": "2 min ago",
        "color": Colors.green[100],
        "unread": false,
        "avatar": "lib/assets/acc555fcae8944d537bb4f687e174da6c6cb4b25.png",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chats',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.separated(
        itemCount: chatList.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final chat = chatList[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChatDetailScreen()));
                  },
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: chat['color'],
                    backgroundImage: AssetImage(chat['avatar']),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                )
              ],
            ),
            title: Text(chat['name'], style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(chat['message']),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(chat['time'], style: const TextStyle(fontSize: 12)),
                if (chat['unread'] == true)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      chat['count'].toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      
    );
  }
}
