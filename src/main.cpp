#include <Arduino.h>
#include <SPI.h>
#include <SD.h>

const int CS_PIN = 10;
File archivo;

void setup() {
  Serial.begin(9600);
  Serial.println("Iniciando protocolo SPI...");
  
  // Inicializar SD
  if (!SD.begin(CS_PIN)) {
    Serial.println("SPI:ERROR:No se puede inicializar SD");
    while (true);
  }
  
  Serial.println("SPI:OK:MicroSD detectada");
  
  // Crear/escribir archivo
  archivo = SD.open("/test.txt", FILE_WRITE);
  if (archivo) {
    archivo.println("Hola desde ESP32 + microSD!");
    archivo.close();
    Serial.println("SPI:WRITE:Escritura OK");
  }
}

void loop() {
  // Leer archivo
  archivo = SD.open("/test.txt");
  if (archivo) {
    Serial.print("SPI:READ:");
    while (archivo.available()) {
      Serial.write(archivo.read());
    }
    archivo.close();
  }
  
  delay(2000);
}