class Circles 
{
  int xpos; // single bar width
  int ypos; // rect xposition
  int radius; // rect height
  // rect yposition
  boolean symbolPresent;
  int id;
  int SymbolID;
  boolean displaySymbol;


  Circles(int X, int Y, int Radius, int Id) {
    xpos = X;
    ypos = Y;
    radius = Radius;
    id = Id;
    symbolPresent = false;
    displaySymbol = false;
    SymbolID=999;
  }

  //Used for hashmaps
  int getId()    
  {
    return this.id;
  }

  //Made this so that i dont have to keep resetting the sketch
  void resetCircle() {
    this.symbolPresent = false;
    this.displaySymbol = false;
    this.SymbolID = 999;
  }
  //this bool is used to print the symbols rather than circles after a successful submit
  void setDisplaySymbol(boolean displayValue) {
    this.displaySymbol = displayValue;
  }
  //displays the submit button
  void displaySubmit(String texts) {
    stroke(0);
    noFill();
    text(texts, this.xpos-40, this.ypos-10);
    ellipse(this.xpos, this.ypos, this.radius, this.radius);
  }
  
  //displays the reset button
  void displayReset(String texts) {
    stroke(0);
    noFill();
    text(texts, this.xpos-30, this.ypos+10);
    ellipse(this.xpos, this.ypos, this.radius, this.radius);
  }

  //checks to see if a particular puck is in a specific circle. used mostly for the submit and reset pucks.
  boolean checkForPuck(Vector tuioObjectList, int puckID) {
    for (int i=0;i<tuioObjectList.size();i++) {
      TuioObject tobj = (TuioObject)tuioObjectList.elementAt(i);

      //TODO: calibrate getScreenX and getScreenY after tweaking with projection.
      if ((dist(this.xpos, this.ypos, tobj.getScreenX(sketchWidth), tobj.getScreenY(sketchHeight)) < this.radius)&&(tobj.getSymbolID()==puckID))
      {
        this.display(255, 0, 0);
        this.symbolPresent = true;
        this.SymbolID = tobj.getSymbolID();
        return true;
        //  println("true");
      }
      //if the symbol is not  within the circle only assume it has been removed if the symbol id of the current object
    }
    return false;
  }
  
  //if symbol is present draw the symbol otherwise draw a circle.
  void display(int strokeValue) {
    if (displaySymbol) {
      drawShape(this.SymbolID, this.xpos, this.ypos);
      this.symbolPresent = false;
    }
    else {
      noFill();
      stroke(strokeValue);
      strokeWeight(1);
      ellipse(this.xpos, this.ypos, this.radius, this.radius);
    }
  }

  //Overloaded to allow the user to change the color of circle border
  void display(int rValue, int bValue, int gValue) {
    if (displaySymbol) {
      drawShape(this.SymbolID, this.xpos, this.ypos);
      this.symbolPresent = false;
    }
    else {
      stroke(rValue, bValue, gValue);
      noFill();
      strokeWeight(2);
      ellipse(this.xpos, this.ypos, this.radius, this.radius);
    }
  }
  
  //Shapes mapped to the puck Ids.
  void drawShape(int tobjID, int xpos, int ypos) {
    // float obj_size = object_size*scale_factor;
    if (tobjID == 0) {
      shapeMode(CENTER);
      shape(symbols[0], xpos, ypos);
    }
    else if (tobjID == 1) {
      shapeMode(CENTER);
      shape(symbols[1], xpos, ypos);
    }
    else if (tobjID == 2) {
      shapeMode(CENTER);
      shape(symbols[2], xpos, ypos);
    }
    else if (tobjID == 3) {
      shapeMode(CENTER);
      shape(symbols[3], xpos, ypos);
    }
    else if (tobjID == 4) {
      shapeMode(CENTER);
      shape(symbols[4], xpos, ypos);
    }
    else if (tobjID == 5) {
      shapeMode(CENTER);
      shape(symbols[5], xpos, ypos);
    }
    else if (tobjID == 6) {
      shapeMode(CENTER);
      shape(symbols[6], xpos, ypos);
    }
    else if (tobjID == 7) {
      shapeMode(CENTER);
      shape(symbols[7], xpos, ypos);
    }
    else if (tobjID == 8) {
      shapeMode(CENTER);
      shape(symbols[8], xpos, ypos);
    }
    else if (tobjID == 9) {
      shapeMode(CENTER);
      shape(symbols[9], xpos, ypos);
    }
    else if (tobjID == 10) {
      shapeMode(CENTER);
      shape(symbols[10], xpos, ypos);
    }
    else if (tobjID == 11) {
      shapeMode(CENTER);
      shape(symbols[11], xpos, ypos);
    }
    else if (tobjID == 12) {
      shapeMode(CENTER);
      shape(symbols[12], xpos, ypos);
    }
    else if (tobjID == 13) {
      shapeMode(CENTER);
      shape(symbols[13], xpos, ypos);
    }
    else if (tobjID == 14) {
      shapeMode(CENTER);
      shape(symbols[14], xpos, ypos);
    }
    else if (tobjID == 15) {
      shapeMode(CENTER);
      shape(symbols[15], xpos, ypos);
    }
    else if (tobjID == 16) {
      shapeMode(CENTER);
      shape(symbols[16], xpos, ypos);
    }
    else if (tobjID == 17) {
      shapeMode(CENTER);
      shape(symbols[17], xpos, ypos);
    }
    else if (tobjID == 18) {
      shapeMode(CENTER);
      shape(symbols[18], xpos, ypos);
    }
    else if (tobjID == 19) {
      shapeMode(CENTER);
      shape(symbols[19], xpos, ypos);
    }
    else if (tobjID == 20) {
      shapeMode(CENTER);
      shape(symbols[20], xpos, ypos);
    }
    else if (tobjID == 21) {
      shapeMode(CENTER);
      shape(symbols[21], xpos, ypos);
    }
    else if (tobjID == 22) {
      shapeMode(CENTER);
      shape(symbols[22], xpos, ypos);
    }
    else if (tobjID == 23) {
      shapeMode(CENTER);
      shape(symbols[23], xpos, ypos);
    }
    else if (tobjID == 24) {
      shapeMode(CENTER);
      shape(symbols[24], xpos, ypos);
    }
    else if (tobjID == 25) {
      shapeMode(CENTER);
      shape(symbols[25], xpos, ypos);
    }
    else if (tobjID == 26) {
      shapeMode(CENTER);
      shape(symbols[26], xpos, ypos);
    }
    

  }
  boolean checkForObject(TuioObject tobj) {

    //May need to calibrate getScreenX and getScreenY after tweaking with projection.
    if (dist(this.xpos, this.ypos, tobj.getScreenX(sketchWidth), tobj.getScreenY(sketchHeight)) < this.radius)
    {
      this.symbolPresent = true;
      return true;
    }
    this.symbolPresent = false;
    return false;
  }

  void checkForObjectList(Vector tuioObjectList) {

    for (int i=0;i<tuioObjectList.size();i++) {
      TuioObject tobj = (TuioObject)tuioObjectList.elementAt(i);

      //TODO: calibrate getScreenX and getScreenY after tweaking with projection.
      if (dist(this.xpos, this.ypos, tobj.getScreenX(sketchWidth), tobj.getScreenY(sketchHeight)) < this.radius)
      {
        this.display(255, 0, 0);
        //drawShape(tobj.getSymbolID(), this.xpos+100, this.ypos+100);
        this.symbolPresent = true;
        this.SymbolID = tobj.getSymbolID();
        //   println("true");
      }
      //if the symbol is not  within the circle only assume it has been removed if the symbol id of the current object 
      //and the one associated with that circle are the same
      else if (this.SymbolID ==tobj.getSymbolID()) {
        
        this.symbolPresent = false;
        this.display(128);
      }
    }
  }
}

