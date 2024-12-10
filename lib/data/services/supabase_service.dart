/**
 * Created by Abdullah on 19/10/24.
 */

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  late SupabaseClient client;

  factory SupabaseService() {
    return _instance;
  }

  SupabaseService._internal(){
    // Replace with your Supabase URL and Anon Key
  client = SupabaseClient(
      'https://evjrnxcgmdwjqfwevjnq.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV2anJueGNnbWR3anFmd2V2am5xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkzNDE5NzksImV4cCI6MjA0NDkxNzk3OX0.zKBTcnmigBsGPWN2_xVapDiABRYfEGDSvYMJqwvS5c0',
    );
  }
}

