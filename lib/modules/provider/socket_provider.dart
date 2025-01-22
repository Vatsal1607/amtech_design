import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../services/network/api/api_constants.dart';

class SocketProvider with ChangeNotifier {
  late IO.Socket _socket;

  IO.Socket get socket => _socket;

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  SocketProvider() {
    connectToSocket();
  }

  void connectToSocket() {
    _socket = IO.io(
      BaseUrl.socketBaseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket']) // Enable WebSocket transport
          .enableAutoConnect() // Auto connect
          .setReconnectionAttempts(5) // Retry 5 times
          .build(),
    );

    _socket.onConnect((_) {
      log('Connected to the Socket server');
      _isConnected = true;
      notifyListeners(); // Notify listeners about connection status
    });

    _socket.onDisconnect((_) {
      log('Disconnected from the server');
      _isConnected = false;
      notifyListeners();
    });

    _socket.onError((data) {
      log('Socket error: $data');
    });
  }

  void emitEvent(String event, dynamic data) {
    if (_socket.connected) {
      _socket.emit(event, data);
    } else {
      throw Exception("Socket is not connected!");
    }
  }

  void listenToEvent(String event, Function(dynamic) callback) {
    _socket.on(event, callback);
  }

  void disconnect() {
    _socket.dispose();
    _isConnected = false;
    notifyListeners();
    log('Socket disconnected');
  }
}
