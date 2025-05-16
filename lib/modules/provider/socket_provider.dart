import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../core/utils/constants/keys.dart';
import '../../services/local/shared_preferences_service.dart';
import '../../services/network/api/api_constants.dart';

class SocketProvider with ChangeNotifier {
  IO.Socket? _socket;

  IO.Socket get socket {
    assert(_socket != null,
        'Socket has not been initialized. Call connectToSocket() first.');
    return _socket!;
  }

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  // SocketProvider() {
  //   connectToSocket();
  //   log('Constructor of socket provider is called');
  // }
  void offEvent(String eventName) {
    socket.off(eventName);
  }

  void ensureConnected() {
    log('ensureConnected called');

    if (_socket == null) {
      log('Socket is null, initializing...');
      connectToSocket();
      return;
    }

    if (!_socket!.connected) {
      log('Socket not connected. Attempting reconnection...');
      _socket!.connect();

      _socket!.once('connect', (_) {
        log('Socket reconnected successfully.');
        _isConnected = true;
        notifyListeners();
      });

      _socket!.once('connect_error', (error) {
        log('Failed to reconnect: $error');
      });
    } else {
      log('Socket is already connected.');
    }
  }

  void connectToSocket() {
    if (_socket != null && _socket!.connected) {
      log('Socket already connected. Skipping reinitialization.');
      return;
    }

    log('Connecting to socket...');
    _socket = IO.io(
      BaseUrl.socketBaseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setReconnectionAttempts(5)
          .build(),
    );

    _socket!.onConnect((_) {
      log('Connected to the Socket server');
      _isConnected = true;

      final userConnectData = {
        "userId": sharedPrefsService.getString(SharedPrefsKeys.userId),
        "deviceId": sharedPrefsService.getString(SharedPrefsKeys.deviceId),
        "role": sharedPrefsService.getString(SharedPrefsKeys.accountType) ==
                'business'
            ? '0'
            : '1',
        "socketId": _socket!.id,
      };

      emitEvent(SocketEvents.userConnected, userConnectData);
      notifyListeners();
    });

    _socket!.onDisconnect((_) {
      log('Disconnected from the server');
      _isConnected = false;
      notifyListeners();
    });

    _socket!.onError((data) {
      log('Socket error: $data');
    });
  }

  void emitEvent(String event, dynamic data) {
    if (_socket?.connected == true) {
      _socket!.emit(event, data);
    } else {
      log("Socket not connected, trying to reconnect...");
      _socket?.connect(); // Initiates reconnection manually
      _socket?.once('connect', (_) {
        log("Reconnected. Emitting event: $event");
        _socket?.emit(event, data);
      });
    }
  }
  // void emitEvent(String event, dynamic data) {
  //   if (_socket.connected) {
  //     _socket.emit(event, data);
  //   } else {
  //     log("Socket not connected, trying to reconnect...");
  //     _socket
  //         .connect(); // Initiates reconnection manually (even if autoConnect is true)
  //// Once connected, emit the event
  //     _socket.once('connect', (_) {
  //       log("Reconnected. Emitting event: $event");
  //       _socket.emit(event, data);
  //     });
  //   }
  // }

  void listenToEvent(String event, Function(dynamic) callback) {
    _socket?.on(event, callback);
  }
  // void listenToEvent(String event, Function(dynamic) callback) {
  //   _socket.on(event, callback);
  // }

  // @override
  // void dispose() {
  //   disconnect();
  //   log('SocketProvider Dispose called');
  //   super.dispose();
  // }

  void disconnect() {
    _socket?.dispose();
    _isConnected = false;
    notifyListeners();
    log('Socket disconnected');
  }
}
