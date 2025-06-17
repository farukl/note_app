import 'package:flutter/material.dart';
import 'package:note_app/widgets/base_page.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Burada gerçek e-posta gönderme işlemi yapılacak
      // Örneğin: EmailJS, Firebase Functions, veya backend API çağrısı

      // Simüle edilmiş gönderme işlemi
      await Future.delayed(const Duration(seconds: 2));

      // Form verilerini konsola yazdır (test amaçlı)
      print('E-posta: ${_emailController.text}');
      print('Konu: ${_subjectController.text}');
      print('Mesaj: ${_messageController.text}');

      // Başarı mesajı göster
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mesajınız başarıyla gönderildi!'),
          backgroundColor: Colors.green,
        ),
      );

      // Formu temizle
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mesaj gönderilemedi: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Bize Ulaşın',
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Başlık ve açıklama
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'İletişim',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sorularınız, önerileriniz veya geri bildirimleriniz için bizimle iletişime geçin. Size en kısa sürede dönüş yapacağız.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // E-posta alanı
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'E-posta Adresiniz',
                  hintText: 'ornek@email.com',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'E-posta adresi gerekli';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Geçerli bir e-posta adresi girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Konu alanı
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Konu',
                  hintText: 'Mesajınızın konusu',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.subject),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Konu alanı gerekli';
                  }
                  if (value.length < 3) {
                    return 'Konu en az 3 karakter olmalı';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Mesaj alanı
              TextFormField(
                controller: _messageController,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Mesajınız',
                  hintText: 'Mesajınızı buraya yazın...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.message),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mesaj alanı gerekli';
                  }
                  if (value.length < 10) {
                    return 'Mesaj en az 10 karakter olmalı';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Gönder butonu
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _sendMessage,
                  icon: _isLoading
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                      : const Icon(Icons.send),
                  label: Text(_isLoading ? 'Gönderiliyor...' : 'Mesaj Gönder'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // İletişim bilgileri (opsiyonel)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Diğer İletişim Yolları',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.email, color: Colors.blue, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'destek@notcepte.com',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.phone, color: Colors.green, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            '+90 (212) 123 45 67',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.access_time, color: Colors.orange, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Pazartesi - Cuma: 09:00 - 18:00',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}