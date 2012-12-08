/**** Software for the random story generator.***/
/**** Use the calibration grid to calibrate the sketch with reactivision**/

// we need to import the TUIO library
// and declare a TuioProcessing client variable
import TUIO.*;
TuioProcessing tuioClient;
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;


// these are some helper variables which are used
// to create scalable graphical feedback
float cursor_size = 15;
float object_size = 100;
float table_size = 760;
float scale_factor = 1;
//The following variables are used to draw the grid of circles on the display
int x_step = 160;
int y_step = 200;
int numberOfRows = 3;
int numberOfColumns = 4;
int lineLength = 90;
int radius = 120;
int index=0;
int submitX = 600;
int submitY = 125;
int submitYStep = 150;
int submitR = 110;

// Circles in which the pucks are detected
int submitPuckId = 28;
int resetPuckId = 27;
ArrayList <Circles> symbolCircles = new ArrayList<Circles>();
Map<Integer, Circles> hashCircles = new HashMap<Integer, Circles>();
ArrayList <Circles> submitCircles = new ArrayList<Circles>();
Map<Integer, Circles> hashSubmit = new HashMap<Integer, Circles>();
Circles resetCircle = new Circles(850, 550, 110, 110);

//Some booleans
boolean submit=false;
boolean drawBool =false;
boolean row1 =false;
boolean row2 =false;
boolean row3 =false;
boolean row4 =false;

//Canvas stuff
PImage img;
int sketchWidth = 940;
int sketchHeight = 660;
PFont font;

//Story symbols library
PShape[] symbols = new PShape[27];
//Stort text
char[] myStory = new char[1000];
int myStoryIndex = 0;

void setup()
{
  size(sketchWidth, sketchHeight);
  img = loadImage("Book_Background2.jpg");
  img.resize(sketchWidth, sketchHeight);
  noStroke();
  fill(0);
  loop();
  frameRate(30);
  int l =100;
  for (int j =0; j<numberOfColumns; j++) {
    int f = 90;
    for (int k= 0; k<numberOfRows; k++) {
      line(f, l, f+lineLength, l);

      Circles thisCircle = new Circles(f, l, radius, index++);
      symbolCircles.add(thisCircle);

      f = f+ x_step;
      println(l);
    }
    l = l+y_step;
  }
  //Symbol Circles hashmap
  for ( Circles circle : symbolCircles ) {
    hashCircles.put( circle.getId(), circle );
  }
  int indexSubmit=0;
  /***/
  //change b value for number of submit buttons.
  for (int b=0; b<numberOfColumns;b++) {
    Circles thisSubmit = new Circles(submitX, submitY, submitR, indexSubmit++);
    submitCircles.add(thisSubmit);
    submitY = submitY+ submitYStep;
  }
  //Submit Circles hashmap
  for ( Circles circle : submitCircles ) {
    hashSubmit.put( circle.getId(), circle );
  }
  /***/
  hint(ENABLE_NATIVE_FONTS);
  font = createFont("Courier New", 15);
  scale_factor = height/table_size;
  for (int i =0; i<symbols.length;i++) {
    symbols[i] = loadShape(i+".svg");
    println("loaded shape: " + i+" copy.svg"); 
  }

  //Osc sttuff to talk to turk computer. 
  //The IP will need to be updated for every new computer that is used.
  oscP5 = new OscP5(this, 8000);
  myRemoteLocation = new NetAddress("169.254.65.73", 12000);
  // we create an instance of the TuioProcessing client
  // since we add "this" class as an argument the TuioProcessing class expects
  // an implementation of the TUIO callback methods (see below)
  tuioClient  = new TuioProcessing(this);
  
}

// within the draw method we retrieve a Vector (List) of TuioObject and TuioCursor (polling)
// from the TuioProcessing client and then loop over both lists to draw the graphical feedback.
void draw()
{
  background(img);
  //Draw the circles
  for (Circles thisCircle : symbolCircles) {
    thisCircle.display(128);
  }
  textFont(font, 18*scale_factor);
  float obj_size = object_size*scale_factor; 
  float cur_size = cursor_size*scale_factor; 
 
  Vector tuioObjectList = tuioClient.getTuioObjects();
  
  //Check to see if the pucks are within the circles.
  for (Circles thisCircle : symbolCircles) {

    thisCircle.checkForObjectList(tuioObjectList);
  }

  if (symbolCircles.get(0).symbolPresent&& symbolCircles.get(1).symbolPresent&&symbolCircles.get(2).symbolPresent) {
    submitCircles.get(0).displaySubmit("Submit 1st \n\r  Row");
    if (submitCircles.get(0).checkForPuck(tuioObjectList, submitPuckId)) {
      symbolCircles.get(0).setDisplaySymbol(true);
      symbolCircles.get(1).setDisplaySymbol(true);
      symbolCircles.get(2).setDisplaySymbol(true);
      row1 =true;

      OscMessage myMessage = new OscMessage("row1");
      myMessage.add(1);
      myMessage.add(symbolCircles.get(0).SymbolID);
      myMessage.add(symbolCircles.get(1).SymbolID);
      myMessage.add(symbolCircles.get(2).SymbolID);
      oscP5.send(myMessage, myRemoteLocation);
    }
  }
  else if (symbolCircles.get(3).symbolPresent&& symbolCircles.get(4).symbolPresent&&symbolCircles.get(5).symbolPresent) {
    // showSubmitButton(true);
    submitCircles.get(1).displaySubmit("Submit 2nd \n\r  Row");
    if (submitCircles.get(1).checkForPuck(tuioObjectList, submitPuckId)) {
      symbolCircles.get(3).setDisplaySymbol(true);
      symbolCircles.get(4).setDisplaySymbol(true);
      symbolCircles.get(5).setDisplaySymbol(true);
      row2=true;

      OscMessage myMessage = new OscMessage("row2");
      myMessage.add(2);
      myMessage.add(symbolCircles.get(3).SymbolID);
      myMessage.add(symbolCircles.get(4).SymbolID);
      myMessage.add(symbolCircles.get(5).SymbolID);
      oscP5.send(myMessage, myRemoteLocation);
    }
  }
  else if (symbolCircles.get(6).symbolPresent&& symbolCircles.get(7).symbolPresent&&symbolCircles.get(8).symbolPresent) {
    submitCircles.get(2).displaySubmit("Submit 3rd \n\r  Row");
    if (submitCircles.get(2).checkForPuck(tuioObjectList, submitPuckId)) {
      symbolCircles.get(6).setDisplaySymbol(true);
      symbolCircles.get(7).setDisplaySymbol(true);
      symbolCircles.get(8).setDisplaySymbol(true);
      row3 = true;

      OscMessage myMessage = new OscMessage("row4");
      myMessage.add(3);
      myMessage.add(symbolCircles.get(6).SymbolID);
      myMessage.add(symbolCircles.get(7).SymbolID);
      myMessage.add(symbolCircles.get(8).SymbolID);
      oscP5.send(myMessage, myRemoteLocation);
    }
  }
  else if (symbolCircles.get(9).symbolPresent&& symbolCircles.get(10).symbolPresent&&symbolCircles.get(11).symbolPresent) {
    submitCircles.get(3).displaySubmit("Submit 4th \n\r  Row");
    if (submitCircles.get(3).checkForPuck(tuioObjectList, submitPuckId)) {
      symbolCircles.get(9).setDisplaySymbol(true);
      symbolCircles.get(10).setDisplaySymbol(true);
      symbolCircles.get(11).setDisplaySymbol(true);
      row4 = true;

      OscMessage myMessage = new OscMessage("row4");
      myMessage.add(4);
      myMessage.add(symbolCircles.get(9).SymbolID);
      myMessage.add(symbolCircles.get(10).SymbolID);
      myMessage.add(symbolCircles.get(11).SymbolID);
      oscP5.send(myMessage, myRemoteLocation);
    }
  }
  
  //If any of the rows have symbols display the reset button
  if (row1||row2||row3||row4) {
    resetCircle.displayReset("Reset");
    if (resetCircle.checkForPuck(tuioObjectList, resetPuckId)) {
      for (Circles thisCircle : symbolCircles) {
        thisCircle.resetCircle();
      }
      println("here"); 
      for(int i = 0; i<myStory.length;i++){      
      myStory[i] = ' ';
      }
      myStoryIndex = 0;
      row1=false;
      row2=false;
      row3 =false;
      row4 = false;
      OscMessage myMessage = new OscMessage("reset");
      myMessage.add(5);
      oscP5.send(myMessage, myRemoteLocation);
      //      myStory = "";
    }
  }

  text(myStory, 0, 1000, 500, 80);
}

void keyPressed() {  
  
  if (keyCode == 16||keyCode == 157||keyCode == 18 ||keyCode == 17||keyCode ==37 ||keyCode == 38|| keyCode == 39 || keyCode==40) {
  }
  else if (keyCode == 8) {
    myStory[--myStoryIndex] = ' ';
  }
  else {
    myStory[myStoryIndex++] = key;
    println(myStoryIndex);
  }

  if (myStoryIndex%42 == 0 && keyCode != 8) {
    myStory[myStoryIndex++]='\n';
    myStory[myStoryIndex++]='\r';
  }
}
void mouseClicked()
{
  println(mouseX+ " "+ mouseY);
}

void mousePressed() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/test");

  myMessage.add(123); /* add an int to the osc message */

  /* send the message */
  oscP5.send(myMessage, myRemoteLocation);
}

// these callback methods are called whenever a TUIO event occurs
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### my sketch.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
  println(" message: "+theOscMessage.get(0).charValue());
  char local = theOscMessage.get(0).charValue();
 //int localInt = theOscMessage.get(0).intValue();
  println(local);
  
  //ignore keys like shift, caps lock, tab etc. 
  if (local ==16 ||local ==157||local == 18 ||local == 17||local ==37 ||local == 38|| local == 39 || local==40) {
  }
  //if delete is pressed move back on place in the char array
  else if (local == 8) {
    myStory[--myStoryIndex] = ' ';
  }
  // if ' is pressed clear the entire story
  else if(local == '`'){
      for(int i = 0; i<myStory.length;i++){      
      myStory[i] = ' ';
      }  
  myStoryIndex = 0;
  }
  else {
    myStory[myStoryIndex++] = local;
    println(myStoryIndex);
  }

  // Used for the carriage return.
  // The value 42 was chosen based on trial and error.
  if (myStoryIndex%42 == 0 && local != 8) {
    myStory[myStoryIndex++]='\n';
    myStory[myStoryIndex++]='\r';
  }
}
// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  println("add object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  println("remove object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  //  println("update object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getScreenX(width)+" "+tobj.getScreenY(height)+" "+tobj.getAngle()
  //    +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  println("update cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
    +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  println("remove cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}

// called after each message bundle
// representing the end of an image frame
void refresh(TuioTime bundleTime) { 
  redraw();
}

