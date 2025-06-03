import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Not kaydetme
  Future<void> saveNote(String userId, Map<String, dynamic> noteData) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('notes')
          .add(noteData);
    } catch (e) {
      throw Exception('Not kaydedilemedi: $e');
    }
  }

  // Kullanıcının tüm notlarını getirme
  Future<List<Map<String, dynamic>>> getUserNotes(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('notes')
          .orderBy('timestamp', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      throw Exception('Notlar getirilemedi: $e');
    }
  }

  // Not güncelleme
  Future<void> updateNote(String userId, String noteId, Map<String, dynamic> noteData) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('notes')
          .doc(noteId)
          .update(noteData);
    } catch (e) {
      throw Exception('Not güncellenemedi: $e');
    }
  }

  // Not silme
  Future<void> deleteNote(String userId, String noteId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('notes')
          .doc(noteId)
          .delete();
    } catch (e) {
      throw Exception('Not silinemedi: $e');
    }
  }

  // Favori notları getirme
  Future<List<Map<String, dynamic>>> getFavoriteNotes(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('notes')
          .where('isStarred', isEqualTo: true)
          .orderBy('timestamp', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      throw Exception('Favori notlar getirilemedi: $e');
    }
  }
}