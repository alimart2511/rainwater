import 'dart:convert';
import 'dart:io';

void main() async {
  // Connect to the Arduino sensor via Bluetooth
  BluetoothSocket socket = await BluetoothSocket.connect('your_arduino_device_address');

  // Listen for data from the Arduino sensor
  socket.listen((List<int> data) {
    String sensorData = utf8.decode(data);
    print('Received data from Arduino sensor: $sensorData');
  });

  // Send a command to the Arduino sensor
  String command = 'your_command';
  socket.write(utf8.encode(command));

  // Close the connection
  socket.close();
}