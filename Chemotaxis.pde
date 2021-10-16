float x, y;
float newx, newy;
float oldx, oldy;
float easing = 0.1; // determines movement speed
PVector v;

float cakeX, cakeY;
float Cx, Cy;
float oldCakeX, oldCakeY;

boolean open = false;
boolean rectOver = false;

int rectX, rectY, rectSizeX, rectSizeY;


Cake yum;

Walker bob;
Walker[]walkers = new Walker[100];


void setup() {
  size(500, 500);
  frameRate (20);
  noStroke();
  fill(0);

  v = new PVector (0.0, 0.0);
}

void draw() {
  background(255);

  update(mouseX, mouseY);

  v.lerp(cakeX, cakeY, 0.0, 0.1);
  yum = new Cake (Cx, Cy, oldCakeX, oldCakeY);

  Cx = (1-easing) * oldx + easing * cakeX;
  Cy = (1-easing) * oldy + easing * cakeY;


  x = (1-easing) * oldCakeX + easing * newx;
  y = (1-easing) * oldCakeY + easing * newy;

  noFill();
  stroke (255);
  strokeWeight (0);
  rect (70, 120, 360, 200);

  stroke (143, 88, 0);
  strokeWeight (5); //window
  fill (168, 228, 255);
  rect (65, 115, 370, 210);

  strokeWeight(2); //window middle
  line (250, 115, 250, 325);





  for (int i = 0; i < walkers.length; i++) {
    walkers[i] = new Walker(x, y);
  }

  for (int i = 0; i < walkers.length; i++) {
    walkers[i].walk();
    walkers[i].show();
  }

  strokeWeight(5); //moving window
  stroke (143, 88, 0);
  noFill();
  rectX = 250;
  rectY = 115;
  rectSizeX = 185;
  rectSizeY = 210;
  rect (rectX, rectY, rectSizeX, rectSizeY);

  oldx = x;
  oldy = y;

  oldCakeX = Cx;
  oldCakeY = Cy;

 
if (open == false){
  yum.show();
   stroke (237, 67, 55); //arrow line
  strokeWeight(2);
   line (Cx+10, Cy+10, mouseX, mouseY);
   
}
  if (rectOver){
  if (mousePressed == true) {
    if (mouseButton == LEFT) {
        open = true;
    
    }
  }
  }
  
  if (open == true){
    fill (255, 0, 0);
      textSize (50);
      textAlign (CENTER);
      text ("Oh no,", 250, 40);
      text (" the bugs ate the cake", 250, 90);
      text (";-;", 250, 400);
  } else {
     fill (0, 0, 0);
      textSize (50);
      textAlign (CENTER);
      text ("Click the", 250, 40);
      text (" right window to open", 250, 90);
      text (":)", 250, 400);
  }
}



void mousePressed () {
  if (mouseButton == RIGHT) {
    newx = mouseX;
    newy = mouseY;

    cakeX = mouseX;
    cakeY = mouseY;
  }
  
}

class Walker {
  float myX, myY;
  Walker (float x, float y) {
    myX = x;
    myY = y;
  }
  void walk() {
    myX = myX + (int)(Math.random()*100)-50;
    myY = myY + (int)(Math.random()*100)-50;
  }
  void show() {
    fill (255, 224, 84);
    noStroke();
    if (open == false) {
      if (myX > 430 ) {
        myX = 430;
      } else if (myX < 70) {
        myX = 70;
      }
      if (myY > 320 ) {
        myY = 320;
      } else if (myY < 120) {
        myY = 120;
      }
    } else {
    }

    noStroke();
    ellipse (myX, myY, 5, 5);
    stroke (0);
    strokeWeight(1);
    ellipse (myX+1, myY+1, .5, .5);
  }
}

class Cake {
  float myX, myY, myOldX, myOldY;
  Cake (float x, float y, float oldx, float oldy) {
    myX = x;
    myY = y;
    myOldX = oldx;
    myOldY = oldy;
  }
  void show() {
    noStroke();
    fill (255, 215, 150); //cake
    rect (myX, myY, 20, 20);
    fill (255, 171, 230); //top cream
    rect (myX, myY, 20, 5);
    fill (255, 171, 230); //bttm cream
    rect (myX, myY+10, 20, 5);
    fill (255, 0, 0); //cherry
    rect (myX+5, myY-5, 10, 5, 5);
    stroke (0, 255, 0); //cherry stem
    strokeWeight(2);
    line (myX+10, myY-10, myX+10, myY-5);
  }
}

void update(int x, int y) {
  if (overRect(rectX, rectY, rectSizeX, rectSizeY) ) {
    rectOver = true;
  } else {
    rectOver = false;
  }
}

boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
