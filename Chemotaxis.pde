float x, y;
float newx, newy;
float oldx, oldy;
float easing = 0.1; // determines movement speed


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


}

void draw() {

  background (255); 

  yum = new Cake ((int)Cx, (int)Cy);

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
    walkers[i] = new Walker((int)x, (int)y);
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

  update(mouseX, mouseY);

  if (open == false) {
    yum.show();
    stroke (237, 67, 55); //arrow line
    strokeWeight(2);
    line (Cx+10, Cy+10, mouseX, mouseY);
  }
  if (rectOver) {
    if (mousePressed == true) {
      if (mouseButton == LEFT) {
        open = true;
      }
    }
  }
  if (open == true) {
    fill (255, 0, 0);
    textSize (50);
    textAlign (CENTER);
    text ("Oh no,", 250, 40);
    text (" the bugs ate the cake", 250, 90);
    text (";-;", 250, 400);
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
  int myXwalk, myYwalk;
  Walker (int xWalk, int yWalk) {
    myXwalk =xWalk;
    myYwalk = yWalk;
  }
  void walk() {
    myXwalk = myXwalk + (int)(Math.random()*100)-50;
    myYwalk = myYwalk + (int)(Math.random()*100)-50;
  }
  void show() {
    fill (255, 224, 84);
    noStroke();
    if (open == false) {
      if (myXwalk > 430 ) {
        myXwalk = 430;
      } else if (myXwalk < 70) {
        myXwalk = 70;
      }
      if (myYwalk > 320 ) {
        myYwalk = 320;
      } else if (myYwalk < 120) {
        myYwalk = 120;
      }
    } else {
    }

    noStroke();
    ellipse (myXwalk, myYwalk, 5, 5);
    stroke (0);
    strokeWeight(1);
    ellipse (myXwalk+1, myYwalk+1, .5, .5);
  }
}

class Cake {
  int myX, myY, myOldX, myOldY;
  Cake (int xCake, int yCake) {
    myX = xCake;
    myY = yCake;
   
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

