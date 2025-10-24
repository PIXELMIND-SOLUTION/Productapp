import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 330,
              height: 50,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png',
                          width: 40,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
                        },
                        child: const Text(
                          'New Villa added',
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    '6 min ago',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 330,
              height: 50,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png',
                          width: 40,
                          height: 52,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
                        },
                        child: const Text(
                          'New Villa added',
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    '6 min ago',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
