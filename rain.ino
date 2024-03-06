# Arduino-USE
#include <SoftwareSerial.h>

const int trigPin = 9;  // Trig pin of the ultrasonic sensor
const int echoPin = 10; // Echo pin of the ultrasonic sensor
long duration;
int distance;

SoftwareSerial BTserial(2, 3); // RX, TX pins for HC-05 Bluetooth module

void setup() {
  Serial.begin(9600); // Initialize serial communication for debugging
  BTserial.begin(9600); // Initialize software serial communication for Bluetooth
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
}

void loop() {
  // Trigger ultrasonic sensor to send out pulse
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  // Measure the duration of pulse
  duration = pulseIn(echoPin, HIGH);

  // Calculate distance in centimeters
  distance = duration * 0.034 / 2;

  // Print distance to serial monitor
  Serial.print("Distance: ");
  Serial.print(distance);
  Serial.println(" cm");

  // Send data if bluetooth is available
  if (BTSerial.available()) {
    BTSerial.print("Distance: ");
    BTSerial.print(distance);
    BTSerial.println(" cm");
  }

  delay(1000); // Adjust delay as needed for the application
}
