class Lines 
{
  int x1; // single bar width
  int x2; // rect xposition
  int y1; // rect height
  int y2 ; // rect yposition
  boolean symbolPresent =false;

  Lines(int X1, int Y1, int X2, int Y2) {
    x1 = X1;
    x2 = X2;
    y1 = Y1;
    y2 = Y2;
    symbolPresent = false;
  }

  void display(int strokeValue) {
    stroke(strokeValue);
        strokeWeight(5);
    line(x1, y1, x2, y2);
  }
  
  void display(int rValue, int bValue, int gValue) {
    stroke(rValue, bValue, gValue);
    line(x1, y1, x2, y2);
  }
  
  boolean checkForObject(TuioObject tobj) {
    if(tobj.getScreenX(width) > this.x1 && tobj.getScreenX(width) < this.x2 && tobj.getScreenY(height)>(this.y2 -(y_step)) && tobj.getScreenY(height)<this.y2)
    {
     // shape(symbols[0], 610, 200);
     println("true!");
     this.symbolPresent = true;
     return true;
    }
      this.symbolPresent = false;
      println("false!");
      return false;
    
    
       
  }
}

