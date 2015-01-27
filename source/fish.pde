
//This class is for all the fishes that will fall and caught by the basket
class Fish {
  float fishX;
  float fishY;
  float speed;
  float d;
  float edge;
  boolean fishCaught;
  int fishValue;
  boolean rotten;
  boolean pink;
  boolean black;

 Fish(int t) {
   
    //this randomly sets the x-position of the fish
    fishX = random(width/8, width/1.2);
    //this randomly sets the y-position of the fish, i.e.
    //it randomly chooses when the fishs will fall
    fishY = random(-10000);
    //this sets the default speed of the falling fish
    speed = 4;
    //this sets the diameter of the fish
    d = 40;
    //this sets the edge which will need to be touched for the
    //fish to be caught
    edge = t;
    //this sets the fish's 'value' to 0
    fishValue = 0;
    //this presets the fish to be neither rotten nor pink
    rotten = false;
    pink = false;
    black= false;
  }


  //this displays the fish
  void display() {
    //if the fish has not been caught, make it maroon
   if (fishCaught == false) {
     if (rotten == false) {
      fill(191, 10, 16);
      }
      //if the fish is rotten make it brown
      if (rotten==true) {
        fill(31, 206, 38);
      }
      
     if(black == true) {
       ellipse(fishX, fishY, d, d);
         ellipse(fishX+25, fishY+8, d-20,d-20);
         ellipse(fishX+25, fishY-8, d-20,d-20);
         fill(0);
         ellipse(fishX-6, fishY, d-36,d-35);
           ellipse(fishX-15, fishY, d-36,d-35);
                  ellipse(fishX-10, fishY+10, d-25,d-38);
                  //inside eyes/eyeballs
           fill(0,0,0);
            ellipse(fishX-6, fishY, d-37.5,d-37.5);
               ellipse(fishX-15, fishY, d-37.5,d-37.5);
          
      
               
      
        noStroke();
     }
       
      if (pink == true) {
        fill(2,55,157);
          ellipse(fishX, fishY, d+10, d+10);
         ellipse(fishX+25, fishY+8, d-10,d-10);
         ellipse(fishX+25, fishY-8, d-10,d-10);
         fill(255,255,255);
         ellipse(fishX-6, fishY-10, d-26,d-25);
           ellipse(fishX-15, fishY-10, d-26,d-25);
                  ellipse(fishX-10, fishY+10, d-25,d-38);
                  //inside eyes/eyeballs
           fill(0,0,0);
            ellipse(fishX-6, fishY-10, d-37.5,d-37.5);
               ellipse(fishX-15, fishY-10, d-37.5,d-37.5);
               noStroke ();
      }
    else {
        ellipse(fishX, fishY, d, d);
         ellipse(fishX+25, fishY+8, d-20,d-20);
         ellipse(fishX+25, fishY-8, d-20,d-20);
         fill(255,255,255);
         ellipse(fishX-6, fishY, d-36,d-35);
           ellipse(fishX-15, fishY, d-36,d-35);
                  ellipse(fishX-10, fishY+10, d-25,d-38);
                  //inside eyes/eyeballs
           fill(0,0,0);
            ellipse(fishX-6, fishY, d-37.5,d-37.5);
               ellipse(fishX-15, fishY, d-37.5,d-37.5);
          
      
               
      
        noStroke();
    }
      
    }
  }

  //this drops the fish
  void drop(int j) {
    //this increments the fishs position by its 'speed'
    fishY += j;
  }




  //this checks the current status of the fish
  void check() {
    //this checks if the fish has been caught in the basket
    if ((fishY)+d/2 >580 && (fishY)+d/2 < 610) {
      if (fishX < mouseX+40 && fishX > mouseX-40) {
        fishCaught = true;
        effect.play();
        //Delay(50);
         effect.rewind();
        //this sets the score given for each caught fish,
        //depending on whether it is pink or not
        if (pink == false) {
          fishsGot ++;
        }
        if(black == true) {
          fishsGot -=5;
        }
          
        if (pink == true ) {
          fishsGot +=5;
        }
        //if the caught fish is rotten, then the game is finished
        if (rotten == true) {
          gamedone = true;
        }
        //this sets the fish's value to 1 when it is caught
        fishValue = 1;
      }
    }
    //this sets the fish value to 1 if it falls off the screen
    if (fishY > 600) {
      fishValue = 1;
    }
  }
  }

