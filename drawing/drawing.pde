import themidibus.*;

import pitaru.sonia_v2_9.*;

ArrayList<ArrayList<PVector>> lines;
ArrayList<PVector> points;
IntList playHeads;

HashMap<Integer, Boolean> move_playHead;
HashMap<Integer, IntList> move_playHead_divisions;
IntList no_of_divisions;

ArrayList<FloatList> lines_thickness;
FloatList points_thickness;


//moving points 
moving_points[] mymoving_points;
int pNum = 350;
int distance = 20;
int pDistance=75;
float strokeB=250;
float strokeBs=1;

int pitch = 0;
int velocity=0;

// Create a MidiBus object
MidiBus mb;
MidiBus bb;

boolean play = false;

// Last mouse coordinates
int lastX = 0;
int lastY = 0;


Sample[] mySample = new Sample[5]; 

Sample mySample1;
Sample mySample2;
Sample mySample3;
Sample mySample4;

void setup() {
  size(1440, 900);
  
  Sonia.start(this);
 
 for(int i=1;i<5;i++){
   
   println(Integer.toString(i)+".wav");
   mySample[i] = new Sample(Integer.toString(i)+".wav");
   mySample[i].play();
   mySample[i].setVolume(0.0);
   mySample[i].repeat();
 }
  
//  mySample1 = new Sample("1.wav");
//  mySample1.play();
//  mySample1.setVolume(0.0);
//  mySample1.repeat(); 
  
  points = new ArrayList<PVector>();
  lines  = new ArrayList<ArrayList<PVector>>();
  playHeads = new IntList();
  points_thickness = new FloatList();
  lines_thickness = new ArrayList<FloatList>();
  move_playHead = new HashMap<Integer, Boolean>();
  move_playHead_divisions = new HashMap<Integer, IntList>(); 
  no_of_divisions = new IntList();
  smooth();
  mymoving_points = new moving_points[pNum];
  for (int i = 0; i < pNum; i++) {
    mymoving_points[i] = new moving_points(random(width), random(height), random(-.7, .7));
  }

  mb = new MidiBus(this, -1, 3);
  bb = new MidiBus(this, -1, 3);
}

void draw() {


  
  background(0);
  
  
  if(play == false){
  background(255);  
  }
  
  //pink grid
  //  background(0,0,0);
  //  noStroke();
  //  for(int i=0; i<=7; i++){
  //   fill(255,20*i);
  //   rect(i*width/8,0,width/8,height);
  //   
  //   fill(255,10,20*i);
  //   rect(0,i*height/8,width,height/8);
  //  } 
  //  




  stroke(255, 255, 255, 80);
  
  if(play == false){
    stroke(0, 0, 0, 80);
  }


  // Drawing on screen as mouse is being dragged using points array    
  for (int i =0; i < points.size ()-1; i++) {
    if (i==0) {
      strokeWeight(2);
    } else {
      strokeWeight(points_thickness.get(i));
    }
    line(points.get(i).x, points.get(i).y, points.get(i+1).x, points.get(i+1).y);
  }


  noStroke();

  // Draw all lines on screen
  for (int j=0; j<lines.size (); j++) {

    // Draw play head as points(dots)
    ArrayList<PVector> dots = lines.get(j);
    FloatList p_thickness = lines_thickness.get(j);

    for (int i =0; i < dots.size ()-1; i++) {

      float strokeR=map(mymoving_points[i].x, 0, width, 0, 255);
      float strokeG=map(mymoving_points[i].y, 0, width, 0, 255);
      //      stroke(strokeR, strokeG, strokeB);
      noStroke();
      
      stroke(255, 80);
      
      if(play == false){
      stroke(0, 80);
      }
      strokeWeight(10);
      if (i==playHeads.get(j)) {


        /*
        //pushMatrix();
         float x_intercept = (dots.get(i+1).x - dots.get(i).x);
         float y_intercept = (dots.get(i+1).y - dots.get(i).y);
         
         if(x_intercept ==0 ){x_intercept = 0.1;}
         float val = y_intercept / x_intercept;
         //float val = 90 * sin((dots.get(i+1).y - dots.get(i).y) / (dots.get(i+1).x - dots.get(i).x));
         float val2 = map(val,-250,250,0,90);
         //println(val2);
         //rotate(90 * sin((dots.get(i+1).y - dots.get(i).y) / (dots.get(i+1).x - dots.get(i).x)));
         //line(dots.get(i).x,dots.get(i).y-10,dots.get(i+1).x,dots.get(i+1).y+10);
         
         
         float next_dist = dots.get(i).dist(dots.get(i+1));
         //println(next_dist);
         if(next_dist>5){move_playHead.get(j);}
         */

        //draw playhead 
        point(dots.get(i).x, dots.get(i).y);
        //midi
        float p = 60; 
        //float x = ((dots.get(i).x) / width) * 30;
        int x = int(map(dots.get(i).x,0,width,1,4));
        int y = int(map(dots.get(i).y,0,height,0,100));
//        println(x, y);
        pitch = int(p + x);
        velocity=int(map(p_thickness.get(i),0,11,0,127));
        if ((dots.get(i).x != lastX || dots.get(i).y != lastY) && play) {
          mb.sendNoteOn(j+1, pitch, velocity);
//          mb.sendNoteOn(1, 60, 127);
          int channel=j+1;
          int number=7;
          int value =90;
          //mb.sendControllerChange(1 , number, int(map(pitch,0,255,-60,6))); // Send a controllerChange
          mb.sendControllerChange(channel , number, y); // Send a controllerChange
          //mb.sendControllerChange(channel , 16, x); // Send a controllerChange
          //mb.sendNoteOff(j+1, pitch, velocity);
        }
        
        else if(play == false){
          float speed=map(p_thickness.get(i),0,11,5,1);
          
          int j_temp = j+1;
          
          if(j_temp > 4){j_temp =  j % 4; 
             
               if(j_temp ==0 || j_temp>4){
                 j_temp =1;
               }
     
            }
          //int j_temp = (j+1) % 6;
          
          mySample[j_temp].setVolume(1.0);
          mySample[j_temp].setSpeed(speed);
          
          //mySample1.setVolume(1.0);
          //mySample1.setSpeed(speed);
          //println("speed - "+speed);
        }
        
        float lastX = dots.get(i).x;
        float lastY = dots.get(i).y;
        // Delay .1 seconds to prevent madness
        //        delay(1);



        //

        //popMatrix();
      }
      
      
      
      noStroke();
      stroke(255, 255, 255, 80);
      
      if(play == false){
        stroke(0, 0, 0, 80);
      }
      
      if (i==0) {
        strokeWeight(2);
      } else {
        strokeWeight(p_thickness.get(i));
      }
      //strokeWeight(2);

      // Draw lines between points
      line(dots.get(i).x, dots.get(i).y, dots.get(i+1).x, dots.get(i+1).y);
      
    }
  }

  // Every 25th frame, move play head to next point for every line
 
 
 
   if(play){
     
     if (frameCount%25 == 0) {

    for (int i=0; i<playHeads.size (); i++) {

      ArrayList<PVector> dots = lines.get(i);
      
      //println("dots.size()-"+dots.size());
      
      

      int temp = playHeads.get(i);

      if (temp > dots.size() - 2) {
        playHeads.set(i, 0);
      } else {
        playHeads.set(i, ++temp);
      }
    }
  }
     
   }
 
 
   else if(play == false){
 
 
 
  
  //if (frameCount%25 == 0) {

    for (int i=0; i<playHeads.size (); i++) {

      ArrayList<PVector> dots = lines.get(i);
      
      //println("dots.size()-"+dots.size());
      
      int dots_size = dots.size();
      if(dots_size ==0){dots_size = 1;}
      
      //println("dots_size-"+dots_size);
      
      float increment = 60.0 / dots_size;
      //println("increment - "+increment);
      
      
      int i_temp = i+1;
          
          if(i_temp > 4){i_temp =  i % 4; 
             
               if(i_temp ==0 || i_temp>4){
                 i_temp =1;
               }
     
            }
      
      float current_second = mySample[i_temp].getCurrentFrame() / 44100;
      //float current_second = mySample[i+1%4].getCurrentFrame() / 44100;
      
      float move = current_second / increment;
      
      //int move_map = map(dots_size, 0,);
      
      //println("current_second - "+current_second);
      //println("move - "+move);
      
      //int where_playhead = playHeads.get(i)

      //int temp = playHeads.get(i);

      //if (temp > dots.size() - 2) {
        if (move > dots.size() - 1) {
        playHeads.set(i, 0);
      } else {
        //playHeads.set(i, ++temp);
        playHeads.set(i, (int)move);
      }
    }
  //}
  }

  //  for(PVector p : points){
  //    point(p.x,p.y);
  //  }

  //moving lines
  strokeB=strokeB+strokeBs;
  if (strokeB>=255) {
    strokeBs=-strokeBs;
  } else if (strokeB<=0) {
    strokeBs=-strokeBs;
  }

  for (int i = 0; i < pNum; i++) {
    mymoving_points[i].display();

    for (int j = 0; j < i; j++) {
      if (i != j) {
        float distmoving_points = dist(mymoving_points[i].x, mymoving_points[i].y, mymoving_points[j].x, mymoving_points[j].y);

        if (distmoving_points < distance) {
          float strokeR=map(mymoving_points[i].x, 0, width, 0, 255);
          float strokeG=map(mymoving_points[i].y, 0, width, 0, 255);
          //          stroke(strokeR, strokeG, strokeB,90);
          stroke(255);
          if(play == false){
        stroke(0);
      }
          strokeWeight(0.4);
          line(mymoving_points[i].x, mymoving_points[i].y, mymoving_points[j].x, mymoving_points[j].y);
          //midi
          float p = 40; 
          float x = ((mymoving_points[i].x) / width) * 20;
          float y = ((mymoving_points[i].y) / height) * 20;
          int pitch = int(p + x + y);
          
          if(play){
          mb.sendNoteOn(0, pitch, 127);
          }

          //          float lastX = dots.get(i).x;
          //          float lastY = dots.get(i).y;
          // Delay .1 seconds to prevent madness
          //        delay(1);
        }
      }
    }

    //playhead and lines
    for (int l=0; l<lines.size (); l++) {

      ArrayList<PVector> dots = lines.get(l);

      for (int k=0; k<dots.size ()-1; k++) {

        float dist_playhead = 0;
        if (k == playHeads.get(l)) {      
          dist_playhead= dist(mymoving_points[i].x, mymoving_points[i].y, dots.get(k).x, dots.get(k).y);

          if (dist_playhead < pDistance) {
            float strokeR=map(mymoving_points[i].x, 0, width, 0, 255);
            float strokeG=map(mymoving_points[i].y, 0, width, 0, 255);
            //          stroke(strokeR, strokeG, strokeB);
            stroke(255);
            if(play == false){
              stroke(0);
                }
            strokeWeight(0.4);
            line(mymoving_points[i].x, mymoving_points[i].y, dots.get(k).x, dots.get(k).y);
          }
        }
      }
    }
  }
}


void mouseDragged() {

  PVector previous;


  PVector p = new PVector(mouseX, mouseY);
  if (points.size() > 0) {
    previous = new PVector(pmouseX, pmouseY);
    float distance = p.dist(previous);
    //println(distance);
    if (distance > 25) {
      distance = 25;
    }
    float mapped_distance = map(distance, 0, 25, 11, 1);
    points_thickness.append(mapped_distance);

    int div = (int)mapped_distance/2;
    //println(div);
    no_of_divisions.append(div);
  }



  points.add(p);
}


void mouseReleased() {

  lines.add(points);
  lines_thickness.add(points_thickness);

  //  for(PVector p : points){
  //  
  //      points.remove(p);
  //  }
  points = new ArrayList<PVector>();
  points_thickness = new FloatList();
  move_playHead_divisions.put(playHeads.size(), no_of_divisions);
  no_of_divisions = new IntList();
  move_playHead.put(playHeads.size(), true);
  playHeads.append(0);
}

void mouseClicked() {
}

// Toggle playing
//void mousePressed() {
//  play = !play;
//}

void keyPressed(){
 
   if(key == 'X' || key == 'x'){
     
     for (int j=0; j<lines.size (); j++) {
     mb.sendNoteOff(1, 0, 0);
     
     }
     exit();
   }
   
   
   if(key == 'C' || key == 'c'){
   play = !play;
   
   if(play){
     
     for(int i=1;i<5;i++){
     mySample[i].stop();
   //mySample[i].setVolume(0.0);
   //mySample[i].repeat();
     }
   }
   else if(play ==false){
     
     for(int i=1;i<5;i++){
   mySample[i].play();
   mySample[i].setVolume(0.0);
   mySample[i].repeat();
     }
   }
   
   }
  
}


public void stop(){ 
  Sonia.stop(); 
  super.stop(); 
}
