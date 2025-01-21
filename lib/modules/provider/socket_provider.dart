import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../services/socket/socket_service.dart';

class SocketProvider extends ChangeNotifier {
  final SocketService socketService = SocketService();

  SocketProvider() {
    socketService.connectToSocket();
    socketService.socket.onConnect((_) {
      // onSocketConnected(); // ! EMIT & LISTEN OrderList
    });
  }

  // void emitEvent(String event, dynamic data) {
  //   // _socket.emit(event, data);
  //   if (_socket.connected) {
  //     _socket.emit(event, data);
  //   } else {
  //     throw Exception("Socket is not connected!");
  //   }
  // }
}
