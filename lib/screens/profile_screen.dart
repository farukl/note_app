import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:note_app/providers/auth_provider.dart';
import 'package:note_app/services/firestore_services.dart';
import 'package:note_app/widgets/base_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _birthPlaceController = TextEditingController();
  final _cityController = TextEditingController();

  final FirestoreService _firestoreService = FirestoreService();
  bool _isLoading = false;
  bool _isEditing = false;

  Map<String, dynamic> _profileData = {};

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;

    if (user == null) return;

    setState(() => _isLoading = true);

    try {
      final profileData = await _firestoreService.getUserProfile(user.uid);
      setState(() {
        _profileData = profileData;
        _nameController.text = profileData['name'] ?? '';
        _birthDateController.text = profileData['birthDate'] ?? '';
        _birthPlaceController.text = profileData['birthPlace'] ?? '';
        _cityController.text = profileData['city'] ?? '';
      });
    } catch (e) {
      print('Profil yüklenirken hata: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;

    if (user == null) return;

    setState(() => _isLoading = true);

    try {
      final profileData = {
        'name': _nameController.text.trim(),
        'email': user.email,
        'birthDate': _birthDateController.text.trim(),
        'birthPlace': _birthPlaceController.text.trim(),
        'city': _cityController.text.trim(),
        'updatedAt': DateTime.now().toIso8601String(),
      };

      await _firestoreService.saveUserProfile(user.uid, profileData);

      setState(() {
        _profileData = profileData;
        _isEditing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil başarıyla güncellendi')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profil güncellenemedi: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthDateController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  Widget _buildProfileView() {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Profil Avatar
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 20),

          // Profil Bilgileri
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildInfoRow('Ad Soyad', _profileData['name'] ?? 'Belirtilmemiş'),
                  const Divider(),
                  _buildInfoRow('E-posta', user?.email ?? ''),
                  const Divider(),
                  _buildInfoRow('Doğum Tarihi', _profileData['birthDate'] ?? 'Belirtilmemiş'),
                  const Divider(),
                  _buildInfoRow('Doğum Yeri', _profileData['birthPlace'] ?? 'Belirtilmemiş'),
                  const Divider(),
                  _buildInfoRow('Şehir', _profileData['city'] ?? 'Belirtilmemiş'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: () => setState(() => _isEditing = true),
            icon: const Icon(Icons.edit),
            label: const Text('Profili Düzenle'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const Text(': '),
        Expanded(child: Text(value)),
      ],
    );
  }

  Widget _buildEditForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Avatar
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Form Alanları
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Ad Soyad',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ad soyad gerekli';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _birthDateController,
              decoration: const InputDecoration(
                labelText: 'Doğum Tarihi',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
                suffixIcon: Icon(Icons.date_range),
              ),
              readOnly: true,
              onTap: _selectDate,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _birthPlaceController,
              decoration: const InputDecoration(
                labelText: 'Doğum Yeri',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_city),
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Şehir',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 20),

            // Butonlar
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() => _isEditing = false);
                      _loadProfile(); // Değişiklikleri geri al
                    },
                    child: const Text('İptal'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    child: const Text('Kaydet'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    if (user == null) {
      return const BasePage(
        title: 'Profil',
        content: Center(child: Text('Lütfen giriş yapın.')),
      );
    }

    return BasePage(
      title: 'Profil',
      content: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: _isEditing ? _buildEditForm() : _buildProfileView(),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _birthPlaceController.dispose();
    _cityController.dispose();
    super.dispose();
  }
}