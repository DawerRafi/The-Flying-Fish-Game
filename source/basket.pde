
//class made for basket..
class basket {
  int basketEdge = 570;
  //this displays the basket in the position the player's mouse
  //is pointing to
  void display() { 
   
    strokeWeight(10);
    stroke(185, 162, 96);
    fill(185, 162, 96);
    quad(mouseX-20, 600, mouseX+20, 600, mouseX+40, basketEdge, mouseX-40, basketEdge);
  }
}

