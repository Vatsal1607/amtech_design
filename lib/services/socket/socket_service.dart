import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../network/api/api_constants.dart';

//* Note: User connected socket instance from OrderProvider
class SocketService {
  late IO.Socket _socket;

  IO.Socket get socket => _socket;

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
      log('Connected to the server');
    });

    _socket.onDisconnect((_) {
      log('Disconnected from the server');
    });

    _socket.onError((data) {
      log('Socket error: $data');
    });
  }

  void emitEvent(String event, dynamic data) {
    // _socket.emit(event, data);
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
    log('Socket disconnected');
  }
}
