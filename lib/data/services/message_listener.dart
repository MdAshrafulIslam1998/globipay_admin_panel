import 'dart:async';

import 'package:globipay_admin_panel/core/widgets/app_print.dart';
import 'package:globipay_admin_panel/entity/response/message/message.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/**
 * Created by Abdullah on 11/1/25.
 */


class MessagesListener {
  // Singleton instance
  static final MessagesListener _instance = MessagesListener._internal();

  factory MessagesListener() {
    return _instance;
  }

  MessagesListener._internal();

  SupabaseClient? _supabaseClient;
  RealtimeChannel? _channel;


  /// Initialize the listener
  void initialize(SupabaseClient client) {
    if (_supabaseClient == null) {
      _supabaseClient = client;
    }
  }

  /// Start listening for messages
  Stream<Message> listenForMessages() {
    if (_supabaseClient == null) {
      throw Exception('Supabase client is not initialized');
    }

    // Create a StreamController to manage the stream of messages
    final StreamController<Message> messageStreamController = StreamController<Message>();

    // Unsubscribe from the previous channel if any
    _channel?.unsubscribe();

    // Subscribe to the messages channel
    _channel = _supabaseClient!.channel('public:messages')..on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(
        event: 'INSERT',
        schema: 'public',
        table: 'messages',
      ),
          (payload, [ref]) async {
        if (payload['new'] != null) {
          final newMessage = Message.fromJson(payload['new']);
          messageStreamController.add(newMessage); // Add the message to the stream
          previewMessageContent(newMessage); // Perform additional logic if needed
        } else {
          appPrint('No new message found in payload: $payload');
        }
      },
    ).on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(
        event: 'UPDATE',
        schema: 'public',
        table: 'messages',
      ),
          (payload, [ref]) {
        appPrint("UPDATE Payload: $payload");

        if (payload['new'] != null) {
          //final updatedMessage = Message.fromJson(payload['new']);
          //messageStreamController.add(updatedMessage); // Add the updated message to the stream
        }
      },
    ).subscribe();

    //appPrint('Listener for messages set up successfully.');

    // Ensure the StreamController is properly closed when no longer needed
    return messageStreamController.stream;
  }


  previewMessageContent(Message message){
    appPrint("************************************************");
    appPrint("*****************   Message   ******************");
    appPrint("****       ${message.message}         *******");
    appPrint("************************************************");

  }

  /// Dispose the listener
  void dispose() {
    _channel?.unsubscribe();
    _channel = null;
  }
}