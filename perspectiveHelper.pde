// TODO:
// - serialize method for saving and reloading

VanishingPoint[] vanishingPoints;
int currentPoint = 0;

int L = 0;
int R = 1;
int B = 2;
int T = 3;
PImage img;
boolean backgroundLoaded = false;


void setup() {
  size(1200, 800, P3D);
  vanishingPoints = new VanishingPoint[4];

  vanishingPoints[L] = new VanishingPoint(width/4, height/2, 50, VanishingPoint.LEFT);
  vanishingPoints[R] = new VanishingPoint(3*width/4, height/2, 50, VanishingPoint.RIGHT);
  vanishingPoints[B] = new VanishingPoint(width/2, height/2, 50, VanishingPoint.BOTTOM);
  vanishingPoints[T] = new VanishingPoint(width/2, height/2, 50, VanishingPoint.TOP);

  vanishingPoints[0].toggleSelected();
}

void drawInstructions(){
  pushMatrix();
  pushStyle();
  translate(0,0);
  fill(125,255);
  stroke(255);
  rect(0,0,150,150);
  fill(0,255,0);
  text("space - select next\nh - hide\n+/- - num lines\n1/2 - rotate\ni - import image\np - print mode\ns - save\na - move all together", 15, 15);
  popStyle();
  popMatrix();
}

void draw() {

  if(vanishingPoints[0].printMode){
     background(255);

  } else {
    if(backgroundLoaded){
      image(img, 0,0);
    } else {
        background(0);

    }

    pushStyle();
    stroke(0, 0, 255);
    strokeWeight(2);
    line(0, vanishingPoints[0].position.y, width, vanishingPoints[0].position.y);
    popStyle();

  }

  for (int i = 0; i < vanishingPoints.length; i++) {
    vanishingPoints[i].draw();
  }

  if (mousePressed) {
    vanishingPoints[currentPoint].position.x += (mouseX- pmouseX);
  }
  
  if (mousePressed) {
    vanishingPoints[currentPoint].position.y += (mouseY- pmouseY);
  }

  if (keyPressed) {
    checkKeys();
  }
  
  if(currentPoint == L){
      vanishingPoints[R].position.y = vanishingPoints[L].position.y;
  }
  if(currentPoint == R){
      vanishingPoints[L].position.y = vanishingPoints[R].position.y;
  }  
  
  if(!vanishingPoints[L].printMode){
    drawInstructions();
  }
}

void moveAll(PVector p){
   for(int i = 0; i < vanishingPoints.length; i++){
     vanishingPoints[i].position.x = p.x;
     vanishingPoints[i].position.y = p.y;
    
   }
}

void checkKeys() {
  if (keyPressed) {
    if (key == 'a') {
      moveAll(vanishingPoints[currentPoint].position);
    }

   
    if (key == '1') {
      vanishingPoints[currentPoint].rotation -= 0.1;
    }

    if (key == '2') {
      vanishingPoints[currentPoint].rotation += 0.1;
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    currentPoint++;
    if (currentPoint > vanishingPoints.length - 1) {
      currentPoint = 0;
    }
    for (int i = 0; i < vanishingPoints.length; i++) {
      vanishingPoints[i].unselect();
    }
    vanishingPoints[currentPoint].select();
  }

  if (key == '-') {
    vanishingPoints[currentPoint].setSpacing(vanishingPoints[currentPoint].getSpacing() + 5);
  }

  if (key == '=') {
    vanishingPoints[currentPoint].setSpacing(vanishingPoints[currentPoint].getSpacing() - 5);
  }
  if (key == 'h') {
    vanishingPoints[currentPoint].setDrawLines(!vanishingPoints[currentPoint].getDrawLines());

  }
  
  if(key == 'o'){
    vanishingPoints[currentPoint].swapOrientation();
  }
  
  if(key == 'p'){
    togglePrintMode();
  }
  
  if(key == 's'){
    saveFrame("perspectiveHelper-####.png");
  }
  
  if(key == 'i'){
    selectInput("Select a background image", "fileSelected");
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {
    backgroundLoaded = true;
    img = loadImage(selection.getAbsolutePath());
    img.resize(width, 0);
  }
}

void togglePrintMode(){
  for(int i = 0; i < vanishingPoints.length; i++){
    vanishingPoints[i].togglePrintMode();
    println(i + ":" + vanishingPoints[i].printMode);
  }
}

void setHorizon(float y){
  for(int i = 0; i < vanishingPoints.length; i++){
    vanishingPoints[i].setY(y);
  }
}

