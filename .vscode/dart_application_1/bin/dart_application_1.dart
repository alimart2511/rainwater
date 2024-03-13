import 'package:dart_application_1/dart_application_1.dart' as dart_application_1;
import 'package:flutter_blue/flutter_blue.dart';

void main(List<String> arguments) {
  print('Hello world: ${dart_application_1.calculate()}!');

  // Start scanning for Bluetooth devices
  FlutterBlue flutterBlue = FlutterBlue.instance;
  flutterBlue.startScan(timeout: Duration(seconds: 4));

  // Listen for discovered devices
  flutterBlue.scanResults.listen((List<ScanResult> results) {
    for (ScanResult result in results) {
      // Check if the device is your Arduino
      if (result.device.name == 'Arduino') {
        // Connect to the Arduino
        result.device.connect().then((value) {
          print('Connected to Arduino');

          // Discover services and characteristics
          value.discoverServices().then((services) {
            for (BluetoothService service in services) {
              // Check if the service is the one you need
              if (service.uuid.toString() == '0000ffe0-0000-1000-8000-00805f9b34fb') {
                // Get the characteristic you want to read from
                BluetoothCharacteristic characteristic = service.characteristics.firstWhere(
                  (c) => c.uuid.toString() == '0000ffe1-0000-1000-8000-00805f9b34fb',
                  orElse: () => null,
                );

                if (characteristic != null) {
                  // Read data from the characteristic
                  characteristic.read().then((value) {
                    print('Received data: ${String.fromCharCodes(value)}');
                  });
                }
              }
            }
          });
        });
      }
    }
  });
}
