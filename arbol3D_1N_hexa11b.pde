// 'a' o click en la ventana: para REGENERAR árbol
//'1', '3', '4', '6' o '9': para CAMBIAR el ANGULO del ramaje (15º, 30º, 45º, 60º o 90º)
//'i': guardar una captura de la ventana en PNG


import processing.opengl.*;
import processing.pdf.*;
import processing.dxf.*;
import nervoussystem.obj.*;

PShape hexa2, box2;
String sketchName;
PImage catura;

boolean record, hexaMode;

float largoRama, largoHexa;
float angulo, anguloAzimuth;
int anguloPolar;
int cantidad;
float esbeltez, factor;

float x1, y1, x2, y2, z1, z2;

int recurrenciaMax, apertura;

int contadorImgs, contadorVueltas;


void setup() {
  //size(1280, 720, P3D);
  size(1920, 1080, P3D);
  //size(3840, 2160, P3D); // 4k
  // size(5568, 3132, P3D); // 6k
  //size(7680, 4320, P3D); // 8k - NO

  ortho();
  // camera(width/4.0, height/8.0, (height/1.25) / tan(PI*30.0 / 180.0), width/2.0, height/1.75, 0, 0, 1, 0);

  sketchName = getClass().getSimpleName();

  hexa2 = loadShape("hexa2.obj");
  box2 = loadShape("box2.obj");

  //strokeWeight(width / 500);
  stroke(0);

  largoRama = width / 3.5;
  largoHexa = largoRama/106;
  println("largoRama: "+largoRama);
  anguloPolar = 60;
  //anguloPolar = 90;
  anguloAzimuth = anguloPolar;

  esbeltez = 3.5;

}

void draw() {
  // recurrenciaMax = int(random(13, 15));
  recurrenciaMax = int(random(9, 12));

  hint(ENABLE_STROKE_PERSPECTIVE);

  camera(width/4.0, height/8.0, (height/1.25) / tan(PI*30.0 / 180.0), width/2.0, height/1.75, 0, 0, 1, 0);
  ortho();
  
  if (anguloPolar == 45 || anguloPolar == 90) {
    hexaMode = false;
  } else {
    hexaMode = true;
  }

    // strokeWeight(width / 2700);
    strokeWeight(1.05);

  anguloAzimuth = anguloPolar;
  if (anguloPolar == 90) {
    apertura = 8;
  } else if (anguloPolar == 60 || anguloPolar == 45) {
    apertura = 10;
  } else if (anguloPolar == 30) {
    apertura = 12;
  } else if (anguloPolar == 15) {
    apertura = 14;
  }

  background(255);

  translate(width/2, height, 0);
  translate(0, -largoRama/2, 0);
  
  ubicarSeg();
  factor = 0.4 + (0.2 * int(random(4)));
  scale(factor);

  cantidad = int(recurrenciaMax - random(random(recurrenciaMax)));
  //cantidad = 9;
  rama(cantidad);

  catura = get();
  noLoop();
}

void rama(int cantidad) {

  if (cantidad != 0) {
    for (int i = 0; i < int (random(recurrenciaMax)); i++) {
      //      println("factor: "+factor);
      pushMatrix();
      pushStyle();
      translate(0, -largoRama/2, 0);

      rotateZ(radians(anguloPolar * (int(random(apertura) - int(apertura/2)))));
      rotateY(radians(anguloAzimuth * (int(random(apertura) - int(apertura/2)))));

      translate(0, -largoRama/2, 0);
      
      ubicarSeg();

      factor = 0.4 + (0.2 * int(random(4)));
      scale(factor);
      rama(cantidad - 1);
      popStyle();
      popMatrix();
    }
  }
}

void mousePressed() { // redibuja el árbol (lo mismo apretando "a")
  redraw();
}

void keyPressed() {
  if (key == 'a') { // redibuja el árbol (lo mismo que con un click)
    //      background(255);
    redraw();
  }

  if (key == 'i') { // graba una imagen
    println("Test1");
    catura.save("arbol3D_1N_hexa11"+"-mod"+anguloPolar+"-"+int(random(100000))+".png");
  }
  
  if (key == '6') { // ramas en módulos de 60º )
    anguloPolar = 60;
  }
  if (key == '4') { // ramas en módulos de 45º
    anguloPolar = 45;
  }
  if (key == '3') { // ramas en módulos de 30º
    anguloPolar = 30;
  }
  if (key == '9') { // ramas en módulos de 30º
    anguloPolar = 90;
  }
  if (key == '1') { // ramas en módulos de 30º
    anguloPolar = 15;
  }
}

void ubicarSeg() {
  
  pushMatrix();
  scale(largoHexa*0.7, largoHexa*3.0, largoHexa*0.7);

  if (hexaMode) {
    hexa2.disableStyle();
    shape(hexa2);
  } else {
    box2.disableStyle();
    shape(box2);
  }
    popMatrix();
  
}
