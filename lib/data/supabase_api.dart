import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseApi {
  Future<String?> uploadImage(File imageFile, String fileName) async {
    final supabase = Supabase.instance.client;
    final storage = supabase.storage.from('toptrails');

    try {
      await storage.upload(
        fileName,
        imageFile,
        fileOptions: const FileOptions(upsert: true),
      );
      final publicUrl = storage.getPublicUrl(fileName);
      return publicUrl;
    } catch (e) {
      debugPrint('$e');
      return null;
    }
  }
}
