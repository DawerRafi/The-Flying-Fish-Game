//import gifAnimation.*
int fishsNo = 150;
int p=0;
int f=0;
int m=4;
int d=0;
basket basket = new basket();
Fish[] fishs = new Fish[(fishsNo*3)];
int fishsGot = 0;
int fishsDone = 0;
int fishsDoneresume = 0;
boolean menudone = false;
boolean instructiondone = false;
boolean gamedone = false;
boolean saveandexit = false;
boolean resume = false;
float rotf = random(1, 20);
int rottenFish = int(rotf);
float goldf =2;
int pinkFish = int (goldf);
int blackFish = 5;
PImage startpage;
PImage pausepage;
PImage clouds;
PImage deadfish;
PImage instructions;
int j=0;
String [] a={"0"};
String [] b= new String [6];
String highscore1="";
int highscore;
import ddf.minim.*;

Minim minim;
AudioPlayer song;
AudioSnippet effect;

void setup() {
  size(900, 600);
  minim = new Minim(this);
  
  // this loads sounds from the data folder
  song = minim.loadFile("Good Time.mp3");
  effect = minim.loadSnippet("WaterDrop.mp3");
  
  //these are the images used in the game
  startpage = loadImage("theflyingfish.gif");
  pausepage = loadImage("gameresumed.jpg");
  deadfish = loadImage("dead-fish-hi.png");
  clouds = loadImage("clouds.jpg");
  instructions = loadImage("instructions.jpg");
  //this sets up the font to be used within the game
  PFont font;
 font = loadFont("Rockwell-Bold-48.vlw");
  textFont(font, 40);
  //this isto read the previous highscore from file
  // and storing its int value 
    String temp ="";
  String lines[]=loadStrings("score.txt");
    int num=lines.length;
        temp=lines[0];
        highscore1 =temp;
        highscore = Integer.parseInt(highscore1);
   //This is to read if there is any previous saved game
   String lines2[]=loadStrings("save and exit.txt");
    temp=lines2[0];
    //if there is'nt any previous saved game we put the value
    //of d to 1
   if(temp.equals("0")){
     d=1;
   }
          
        
  //this fills the fishs[] array with given instances of class Fish
  for (int i = 0; i <450;i++) {
    fishs[i] = new Fish(400);
  }
}

void draw() {
  
  //this displays start screen if not already done
  if (menudone == false) {
    //basicSetup();
    menuSetup();
  }
  //if start screen has been passed, this carries out the rest of the game
  else {
    noCursor();
    song.play();
    // this if statement is for the pause and resume function
    // workings() here represent the normal workings of the game
    if(p==0){
      basicSetup();
    workings();
  }
  }
  // This is the pause function
    if(keyPressed ==true && (key=='p' || key=='P')){
    p = 1;
    image(pausepage,0,0);
    song.mute();
  }
   //This is to save the game and quit
    if(keyPressed ==true && (key=='s' || key=='S')){
    p = 2;
    saveandexit=true;
    saveandexit();
    song.mute();
    Delay(3000);
    exit();
    
  }
  //This is to resume the paused game . Notice how
  //we added the variable 'P' to check if the game is
  //already paused or not
  if(p == 1 && (keyPressed ==true && (key=='r' || key=='R'))){
    p= 0;
    basicSetup();
    song.unmute();
  }
}


void workings(){
  printScore();
    //this sets the rotten and pink fishs
    fishs[rottenFish].rotten = true;
    fishs[blackFish].black=true;
    fishs[pinkFish].pink = true;
    //this generates a new pink or black fish
    if(pinkFish<fishsNo-3){
      pinkFish+=3;
    }
    if(blackFish<fishsNo-3) {
      blackFish+=4;
    }
    //if the rotten fish is not caught, this runs the main game
    if (fishs[rottenFish].fishCaught == false) {
      basket.display();
      //this loop runs through once for each falling fish
      if(resume==false){
      for (int i = 0; i<fishsNo;i++) {
        fishs[i].check();
        fishs[i].display();
        fishs[i].drop(m);
      }
      }
      //if the game is being loaded from a previous saved game
      //this will decrease the number of fishes from the original 
      //value
      if(resume==true){
      for (int i = 0; i<fishsNo-fishsDoneresume;i++) {
        fishs[i].check();
        fishs[i].display();
        fishs[i].drop(m);
      }
    }
    }
    //this calculates the fishes and checks if it has to display any
    //message
    resetCalcFishs();
    messageSelection();
    // if the user catches the rotten fish, the following is run
    if (fishs[rottenFish].fishCaught == true) {
      //this refreshes the saved game i.e delete the saved game
      b[0]=str(0);
      b[1]=str((int)random(1,20));
      b[2]=str(4);
      b[3]=str(0);
      b[4]=str(0);
      b[5]=str(150);
      saveStrings("data/save and exit.txt", b);
      //this shows the cursor
      cursor();
      image(deadfish,(width/2)-150,height/3*2,225,225);
      //this sets the colour of exit button to red
      fill(200, 1, 1);
      stroke(0);
      strokeWeight(2);
      //this draws the exit button
      rect((width/2)-150, (height/2)-50, 300, 100);
      fill(0);
      textSize(42);
      text("EXIT", (width/2)-50, (height/2)+10);
      //this prints the 'exit message'
      text("You caught the rotten fish! Game Over!", 70, 200);
      //the following provides a 'mouseover' effect for the button
      if (mouseX >=((width/2)-150) && mouseX <=((width/2)+150)) {
        if (mouseY >=((height/2)-50) && mouseY <=((height/2)+50)) {
          stroke(255);
          strokeWeight(6);
          fill(200, 1, 1);
          rect((width/2)-150, (height/2)-50, 300, 100);
          fill(255);
          text("EXIT", (width/2)-50, (height/2)+10);
        }
      }
    }
  }



//this prints the current score and message for the player
void printScore() {
  if (gamedone == false) {
    fill(0);
    textSize(14);
    text("Score = " + fishsGot, 10, 580);
    textSize(14);
    text("Press P to Pause or S to Save & Quit",600,580);
  }
}

//this selects a message to give to the player depending on their
//final score
void messageSelection() {
  //this checks the level and if it is the first level i.e f=0
  //then it increases the fishsNo and the speed
  if (fishsDone >fishsNo-fishsDoneresume-1 && f==0) {
    textSize(50);
    for(int a=0;a<100;a++){
    text("LEVEL 2",width/2-50,height/2);
    }
    fishsNo +=150;
    m += 3;
    f=1;
  }
  //this checks if the level is second i.e f=1 then it again
  //increases the speed and increases the fishes
    if (fishsDone >fishsNo-fishsDoneresume-1 && f==1) {
    textSize(50);
    for(int a=0;a<100;a++){
    text("LEVEL 3",width/2-50,height/2);
    }
    fishsNo +=150;
    m += 2;
    f=2;
  }
  //If the number of fishes end then this runs
  if(fishsDone >449){
    //this agains restarts the saved game file
      b[0]=str(0);
      b[1]=str((int)random(1,20));
      b[2]=str(4);
      b[3]=str(0);
      b[4]=str(0);
      b[5]=str(150);
      saveStrings("data/save and exit.txt", b);
      //if the new score is the highscore then it saved it 
      //in the score file
    fill(0);
    if(fishsGot>highscore && j==0){
      highscore1= str(fishsGot);
      a[0] =highscore1;
      saveStrings("data/score.txt", a);
     j++; 
    }
    textSize(42);
    //On a new highscore it displays this text
    if(fishsGot>highscore) {
      text("New High Score !!!!!",random(250,255),random(450,455));
    }
    //if the highscore is greater than the current score
    //it displays the highscore
    if(fishsGot<highscore) {
      text("High Score is : " + highscore1,250,450);
    }
    text("Your final score was: " + fishsGot, 180, 300);
    gamedone = true;
    //On different scores the game displays different messages
    if (fishsGot < 1000) {
      text("That's pretty rubbish! Get better!", random(118, 122), random(348, 352));
    }
    if (fishsGot >= 1000 && fishsGot < 1500) {
      text("That's a fairly good score, well done.", random(108, 112), random(348, 352));
    }
    if (fishsGot >=1500) {
      fill(random(256), random(256), random(256));
      text("Excellent score! You are now a legend!", random(100, 105), random(348, 352));
    }
  }
}


//this sets the number of fishs that have been 'done' to 0 and
//then recalculates the cuurent number of fishs that have
//been 'done'
void resetCalcFishs() {
    fishsDone=fishsDoneresume;
  for (int i = 0; i<fishsNo-fishsDoneresume;i++) {
    fishsDone = fishsDone + fishs[i+fishsDoneresume].fishValue;
  }
}

//this stipulates what happens when  the 'START', "INSTRUCTIONS" ,
// "RESUME GAME" and 'EXIT' buttons are pressed
void mouseClicked() {
  if (menudone == false && instructiondone == false) {
    if (mouseX >=((width/2)-150) && mouseX <=((width/2)+150)) {
      if (mouseY >=((height/2)-25) && mouseY <=((height/2)+75)) {
        menudone = true;
      }
    }
    if (mouseX >=(width/2)-150 && mouseX <=((width/2)+150)) {
    if (mouseY >=((height/2)+100) && mouseY <=((height/2)+175)) {
      instructiondone = true;

    }
    }
    if (mouseX >=(width/2)-150 && mouseX <=((width/2)+150) && d!=1) {
    if (mouseY >=((height/2)+200) && mouseY <=((height/2)+275)) {
        resume();
        menudone = true;
    }
    }
  }
  if (fishs[rottenFish].fishCaught == true) {
    if (mouseX >=((width/2)-150) && mouseX <=((width/2)+150)) {
      if (mouseY >=((height/2)-50) && mouseY <=((height/2)+50)) {
        exit();
      }
    }
  }
}


//this displays the start screen before the game commences
//and also the instructions page
void menuSetup() {
  if(instructiondone == true){
    image(instructions,0,0);
  }
  else {
  background(clouds);
  image(startpage,0,0,width*2/3,height*2/3);
  fill(200, 1, 1);
  stroke(0);
  strokeWeight(2);
  rect((width/2)-150, (height/2)-25, 300, 100);
  rect((width/2)-150, (height/2)+100, 300, 75);
  //if there is no saved gave the RESUME GAME button 
  //gets grey
  if(d==1){
    fill(149,148,148);
  }
  rect((width/2)-150, (height/2)+200,300,75);
  fill(0);
  textSize(35);
  text("RESUME GAME",(width/2)-135,(height/2)+250);
  text("INSTRUCTIONS", (width/2)-135, (height/2)+150);
  text("START", (width/2)-70, (height/2)+35);
  //These are the simple effects of mouse hover on any of these buttons
  if (mouseX >=((width/2)-150) && mouseX <=((width/2)+150)) {
    if (mouseY >=((height/2)-25) && mouseY <=((height/2)+75)) {
      stroke(255);
      strokeWeight(6);
      fill(200, 1, 1);
      rect((width/2)-150, (height/2)-25, 300, 100);
      fill(255);
      text("START", (width/2)-70, (height/2)+35);
    }
  }
  if (mouseX >=(width/2)-150 && mouseX <=((width/2)+150)) {
    if (mouseY >=((height/2)+100) && mouseY <=((height/2)+175)) {
       stroke(255);
      strokeWeight(6);
      fill(200, 1, 1);
      rect((width/2)-150, (height/2)+100, 300, 75);
      fill(255);
      text("INSTRUCTIONS", (width/2)-135, (height/2)+150);
    }
  }
    if (mouseX >=(width/2)-150 && mouseX <=((width/2)+150)) {
    if (mouseY >=((height/2)+200) && mouseY <=((height/2)+275)) {
      if(d!=1){
       stroke(255);
      strokeWeight(6);
      fill(200, 1, 1);
      rect((width/2)-150, (height/2)+200,300,75);
      fill(255);
      text("RESUME GAME", (width/2)-135,(height/2)+250);
    }
  }
}
  }
}


//this sets out the background for the game,
void basicSetup() {
  background(clouds);
  noStroke();
  fill(95, 211, 94);
  rect(0, 500, width, 100);
}
//this gets us back to the start page when instructions page is 
//loaded
void keyPressed() {
  if(key=='b' || key=='B'){
    instructiondone=false;
  }
}

//This is a simple delay function that delays the runnings of the
//game
void Delay(int ms){
  int time = millis();
  while(millis()-time < ms);
}

//this is after the game is done and closed
void stop(){
  effect.close();
  song.close();
  minim.stop();
}

//this function is used when the player presses the S button
//during the game to save and exit. It saves all the important data
//which flags the current state of the game i.e speed,level,the number
//of fishes already dropped, the rotten fish value and the score
void saveandexit(){
  if(saveandexit==true){
      b[0]=str(fishsDone);
      b[1]=str(rottenFish);
      b[2]=str(m);
      b[3]=str(f);
      b[4]=str(fishsGot);
      b[5]=str(fishsNo);
      saveStrings("data/save and exit.txt", b);
  }
}

//this is the resume function which loads the values
//from the saved text file and replaces it to the variables
void resume(){
  String lines2[]=loadStrings("save and exit.txt");
  int num2=lines2.length;
  for(int j=0;j<num2;j++){
   String temp2=lines2[j];
   if(j==0){
     fishsDoneresume = int(temp2);
   }
   if(j==1){
     rottenFish=int(temp2);
   }
   if(j==2){
     m=int(temp2);
   }
   if(j==3){
     f=int(temp2);
   }
   if(j==4){
     fishsGot=int(temp2);
   }
   if(j==5){
     fishsNo=int(temp2);
   }
  }
    }
