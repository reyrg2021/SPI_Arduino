import processing.serial.*;

Serial puerto;
String estadoSD = "";
String contenido = "";

void setup() {
  size(700, 500);
  
  String portName = "COM2";
  puerto = new Serial(this, portName, 9600);
  puerto.bufferUntil('\n');
  
  textSize(24);
}

void draw() {
  background(25, 25, 50);
  
  // Título
  fill(255, 200, 0);
  textSize(32);
  textAlign(CENTER);
  text("Protocolo SPI", width/2, 50);
  
  // Estado SD
  fill(255);
  textSize(20);
  text("Tarjeta microSD", width/2, 100);
  
  // Caja SD
  fill(200, 50, 50);
  rect(250, 140, 200, 140, 10);
  
  fill(255);
  textSize(16);
  text("microSD", 350, 180);
  text(estadoSD, 350, 210);
  
  // Contenido del archivo
  fill(100, 255, 100);
  textSize(14);
  textAlign(LEFT);
  text("Contenido del archivo:", 50, 320);
  
  fill(255);
  textSize(12);
  text(contenido, 50, 350, 600, 100);
  
  // Info protocolo
  fill(200);
  textSize(12);
  textAlign(CENTER);
  text("SPI: 4 cables (MISO, MOSI, SCK, CS)", width/2, 450);
  text("Full-duplex, alta velocidad", width/2, 470);
}

void serialEvent(Serial puerto) {
  String datos = puerto.readStringUntil('\n');
  if (datos != null) {
    datos = trim(datos);
    
    if (datos.startsWith("SPI:OK:")) {
      estadoSD = "✓ " + datos.substring(7);
    } else if (datos.startsWith("SPI:ERROR:")) {
      estadoSD = "✗ " + datos.substring(10);
    } else if (datos.startsWith("SPI:READ:")) {
      contenido = datos.substring(9);
    } else if (datos.startsWith("SPI:WRITE:")) {
      estadoSD += " | " + datos.substring(10);
    }
    
    println(datos);
  }
}
