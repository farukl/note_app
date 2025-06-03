import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:note_app/providers/auth_provider.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  void _navigate(BuildContext context, String route) {
    Navigator.pop(context); // Drawer'ı kapat
    if (ModalRoute.of(context)?.settings.name != route) {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Çıkış'),
          content: const Text('Çıkmak istediğinize emin misiniz?'),
          actions: [
            TextButton(
              child: const Text('İptal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Evet'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Çıkış yapıldı')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            accountName: Text(user?.displayName ?? 'Kullanıcı Adı'),
            accountEmail: Text(user?.email ?? 'E-posta'),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.looks_one),
            title: const Text('Sayfa 1'),
            onTap: () => _navigate(context, '/home'),
          ),
          ListTile(
            leading: const Icon(Icons.looks_two),
            title: const Text('Notlarım'),
            onTap: () => _navigate(context, '/notes'),
          ),
          ListTile(
            leading: const Icon(Icons.looks_3),
            title: const Text('Yeni Not'),
            onTap: () => _navigate(context, '/add_note'),
          ),
          ListTile(
            leading: const Icon(Icons.looks_4),
            title: const Text('Favoriler'),
            onTap: () => _navigate(context, '/favorites'),
          ),
          ListTile(
            leading: const Icon(Icons.looks_5),
            title: const Text('Ayarlar'),
            onTap: () => _navigate(context, '/settings'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Çıkış'),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}