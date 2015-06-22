class VanishingPoint {
  PVector position;

  float rotation = 0; // degrees

  int spacing = 10;

  public final static int LEFT = 0;
  public final static int RIGHT = 1;
  public final static int TOP = 2;
  public final static int BOTTOM = 3;

  public final static int ONE_POINT = 4;


  boolean drawPoint = true;
  boolean drawLines = true;
  boolean selected = false;
  int orientation = RIGHT;
  boolean printMode = false;

  VanishingPoint() {
  }

  VanishingPoint(float x, float y, int spacing, int orientation) {
    position = new PVector(x, y);
    this.spacing = spacing;
    this.orientation = orientation;
  }
  
  void togglePrintMode(){
    printMode = !printMode;
  }
  
  void setX(float x){
    position.x = x;
  }
  
  void setY(float y){
    position.y = y;
  }

  int getOrientation() {
    return orientation;
  }
  
  void swapOrientation(){
    if(orientation == TOP){
      orientation = BOTTOM;
    }
    
    else if(orientation == BOTTOM){
      orientation = TOP;
    }
    
  }

  int getSpacing() {
    return spacing;
  }

  void setSpacing(int spacing) {
    this.spacing = spacing;
  }

  void setDrawPoint(boolean drawPoint) {
    this.drawPoint = drawPoint;
  }
  
  boolean getDrawPoint() {
    return this.drawPoint;
  }

  void setDrawLines(boolean drawLines) {
    this.drawLines = drawLines;
  }

  boolean getDrawLines() {
    return drawLines;
  }

  void unselect() {
    selected = false;
  }

  void select() {
    selected = true;
  }

  void toggleSelected() {
    selected = !selected;
  }

  void draw() {
    if (drawPoint) {
      drawPoint();
    }

    if (drawLines) {
      drawLines();
    }
  }

  void drawPoint() {
    pushStyle();
    if (selected) {
      fill(255, 0, 0);
    } 
    else {
      fill(255);
    }
    noStroke();
    if(!printMode){
      ellipse(position.x, position.y, 10, 10);
    }
    popStyle();
  }

  void drawLines() {
    pushMatrix();


    if(printMode){
     stroke(80);
    } else {
     if(selected) {
      stroke(255, 0, 0);
     } else {
      stroke(255);  
      }
    }
    
  
    

    int currY, currX, destX, destY;

    switch(orientation) {
    case LEFT:
      currY = 0;
      destX = width;
      pushMatrix();
      translate(position.x, position.y);
      rotateY(radians(rotation));
      translate(-position.x, -position.y);

      while (currY <= height) {
        line(position.x, position.y, destX, currY);
        currY += spacing;
      }
      popMatrix();
      break;
    case RIGHT:
      currY = 0;
      destX = 0;
      pushMatrix();
      translate(position.x, position.y);
      rotateY(radians(rotation));
      translate(-position.x, -position.y);
      while (currY <= height) {
        line(position.x, position.y, destX, currY);
        currY += spacing;
      }
      popMatrix();
      break;
    case TOP:
      currX = 0;
      destY = 0;

      pushMatrix();
      translate(position.x, position.y);
      rotateX(radians(rotation));
      translate(-position.x, -position.y);
      while (currX <= width) {
        line(position.x, position.y, currX, destY);
        currX += spacing;
      }
      popMatrix();
      break;
    case BOTTOM:
      currX = 0;
      destY = height;
      pushMatrix();
      translate(position.x, position.y);
      rotateX(radians(rotation));
      translate(-position.x, -position.y);
      while (currX <= width) {
        line(position.x, position.y, currX, destY);
        currX += spacing;
      }
      popMatrix();
      break;
    case ONE_POINT:
      break;
    }



    popMatrix();
  }
}

