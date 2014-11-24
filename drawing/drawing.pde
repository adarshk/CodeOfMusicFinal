

ArrayList<ArrayList<PVector>> lines;
ArrayList<PVector> points;
IntList playHeads;

HashMap<Integer,Boolean> move_playHead;
HashMap<Integer,IntList> move_playHead_divisions;
IntList no_of_divisions;

ArrayList<FloatList> lines_thickness;
FloatList points_thickness;


//moving points 
moving_points[] mymoving_points;
int pNum = 350;
int distance = 50;
int pDistance=75;
float strokeB=250;
float strokeBs=1;


void setup(){
  size(700,700);
  points = new ArrayList<PVector>();
  lines  = new ArrayList<ArrayList<PVector>>();
  playHeads = new IntList();
  points_thickness = new FloatList();
  lines_thickness = new ArrayList<FloatList>();
  move_playHead = new HashMap<Integer,Boolean>();
  move_playHead_divisions = new HashMap<Integer,IntList>(); 
  no_of_divisions = new IntList();
  smooth();
  mymoving_points = new moving_points[pNum];
  for (int i = 0; i < pNum; i++) {
    mymoving_points[i] = new moving_points(random(width), random(height), random(-.7, .7));
  }
}

void draw(){
  
  
  background(0);
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


  
      stroke(255,255,255,80);
  
  
  // Drawing on screen as mouse is being dragged using points array    
  for(int i =0; i < points.size()-1;i++){
      if(i==0){strokeWeight(2);}
      else{strokeWeight(points_thickness.get(i));}
      line(points.get(i).x,points.get(i).y,points.get(i+1).x,points.get(i+1).y);
    }
  
  
  noStroke();
  
  // Draw all lines on screen
  for(int j=0;j<lines.size();j++){
    
    // Draw play head as points(dots)
    ArrayList<PVector> dots = lines.get(j);
    FloatList p_thickness = lines_thickness.get(j);
    
    for(int i =0; i < dots.size()-1;i++){
      
                float strokeR=map(mymoving_points[i].x, 0, width, 0, 255);
          float strokeG=map(mymoving_points[i].y, 0, width, 0, 255);
          stroke(strokeR, strokeG, strokeB);
      
      //stroke(255,0,0);
      strokeWeight(10);
      if(i==playHeads.get(j)){
        
        
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
        point(dots.get(i).x,dots.get(i).y);
        //popMatrix();
        
      }
      noStroke();
      stroke(255,255,255,80);
      if(i==0){strokeWeight(2);}
      else{strokeWeight(p_thickness.get(i));}
      //strokeWeight(2);
      
      // Draw lines between points
      line(dots.get(i).x,dots.get(i).y,dots.get(i+1).x,dots.get(i+1).y);
    }
  }
  
  // Every 25th frame, move play head to next point for every line 
  if(frameCount%25 == 0){
    
    for(int i=0;i<playHeads.size();i++){
      
      ArrayList<PVector> dots = lines.get(i);
      
      int temp = playHeads.get(i);
      
      if(temp > dots.size() - 2){
        playHeads.set(i,0);
      }
      else{
      playHeads.set(i,++temp);
      }
    }
  }
  
//  for(PVector p : points){
//    point(p.x,p.y);
//  }

//moving lines
  strokeB=strokeB+strokeBs;
  if (strokeB>=255) {
    strokeBs=-strokeBs;
  }
  else if (strokeB<=0) {
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
          stroke(strokeR, strokeG, strokeB,90);
          strokeWeight(0.4);
          line(mymoving_points[i].x, mymoving_points[i].y, mymoving_points[j].x, mymoving_points[j].y);
        }
      }
    }
   
   //playhead and lines
  for (int l=0; l<lines.size();l++){
    
    ArrayList<PVector> dots = lines.get(l);
    
    for (int k=0; k<dots.size()-1;k++){
      
      float dist_playhead = 0;
        if(k == playHeads.get(l)){      
          dist_playhead= dist(mymoving_points[i].x, mymoving_points[i].y, dots.get(k).x, dots.get(k).y);
        
        if (dist_playhead < pDistance) {
          float strokeR=map(mymoving_points[i].x, 0, width, 0, 255);
          float strokeG=map(mymoving_points[i].y, 0, width, 0, 255);
          stroke(strokeR, strokeG, strokeB);
          strokeWeight(0.4);
          line(mymoving_points[i].x, mymoving_points[i].y, dots.get(k).x, dots.get(k).y);
        }
        }
    }
    
  }
  }
}


void mouseDragged(){
  
  PVector previous;
  
  
  PVector p = new PVector(mouseX,mouseY);
  if(points.size() > 0){
     previous = new PVector(pmouseX,pmouseY);
     float distance = p.dist(previous);
      //println(distance);
      if(distance > 25) {distance = 25;}
      float mapped_distance = map(distance,0,25,11,1);
     points_thickness.append(mapped_distance);
    
    int div = (int)mapped_distance/2;
    //println(div);
    no_of_divisions.append(div);
    
     
  }
  
  
  
  points.add(p);

}


void mouseReleased(){
  
  lines.add(points);
  lines_thickness.add(points_thickness);
  
//  for(PVector p : points){
//  
//      points.remove(p);
//  }
  points = new ArrayList<PVector>();
  points_thickness = new FloatList();
  move_playHead_divisions.put(playHeads.size(),no_of_divisions);
  no_of_divisions = new IntList();
  move_playHead.put(playHeads.size(),true);
  playHeads.append(0);
  
}

void mouseClicked(){
  
}



