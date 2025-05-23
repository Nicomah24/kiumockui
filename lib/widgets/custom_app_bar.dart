import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLogout;
  const CustomAppBar({required this.onLogout, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      leading: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          'assets/KIU_logo.png',
          width: 200, // wider
          height: 90,
          fit: BoxFit.contain,
        ),// space from logo
         
      ),
      title: Row(
        children: [
          const SizedBox(width: 12), 
           CircleAvatar(
            radius: 22,
            backgroundImage: const AssetImage('myprofile.png'),
          ),
          const SizedBox(width: 14),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Watiti Nicholas",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              Text(
                "Reg No: 2024-08-27962",
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.green),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.red),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
