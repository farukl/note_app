import 'package:supabase/supabase.dart';

class SupabaseService {
  final SupabaseClient _client = SupabaseClient('your_supabase_url', 'your_supabase_key');

  Future<void> saveProfileData(Map<String, dynamic> data) {
    return _client.from('profiles').insert(data);
  }
}