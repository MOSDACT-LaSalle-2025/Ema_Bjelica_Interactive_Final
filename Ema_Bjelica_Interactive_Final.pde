//Ema Bjelica - Rainfall -  Interactive 

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer player;

// lines

float[] lineY = new float[300]; // lines
float[] lineSpeed = new float[300]; // speed
int[] lineColorIndex = new int[300]; // color

int activeLines = 0; // Tracks the total number of active lines

float sectionWidth;
float currentLineLength;

// primary colors 
int[][] primaryColors = {
  {255, 0, 0},   // Red
  {0, 0, 255},   // Blue
  {255, 255, 0}  // Yellow
};

boolean isRandomColor = false;

void setup() {
  size(1920, 1080);
  background(0);
  sectionWidth = width / 9;
  currentLineLength = sectionWidth * 3;
  
  minim = new Minim(this);
  
  // music
  player = minim.loadFile("RIMBAUD-Ja to ktoś inny.mp3");
  player.play();
}

void draw() {
  fill(0, 30);
  noStroke();
  rect(0, 0, width, height);

  // random lines
  if (random(100) < 5 && activeLines < 300) {
    lineY[activeLines] = -10;
    lineSpeed[activeLines] = random(1, 3);
    lineColorIndex[activeLines] = int(random(3));
    activeLines++;
  }

  // Loops
  for (int i = 0; i < activeLines; i++) {
    lineY[i] += lineSpeed[i];
    
    // New colors
    if (isRandomColor) {
      // primary colors
      stroke(primaryColors[lineColorIndex[i]][0], primaryColors[lineColorIndex[i]][1], primaryColors[lineColorIndex[i]][2]);
    } else {
      stroke(255); // White
    }

    //3 sections
    int section = int(random(3)); // Randomlize 
    
    // draw lines
    if (section == 0) {
      line(0, lineY[i], currentLineLength, lineY[i]);
    } else if (section == 1) {
      line(sectionWidth * 3, lineY[i], sectionWidth * 3 + currentLineLength, lineY[i]);
    } else { // section == 2
      line(sectionWidth * 6, lineY[i], sectionWidth * 6 + currentLineLength, lineY[i]);
    }
  }
}

void keyPressed() {
  if (key == '7') {
    if (currentLineLength == sectionWidth * 3) {
      currentLineLength = sectionWidth;
    } else {
      currentLineLength = sectionWidth * 3;
    }
  } else if (key == '6') {
    isRandomColor = !isRandomColor;
  }
}
