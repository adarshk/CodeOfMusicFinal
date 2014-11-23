

ArrayList<ArrayList<PVector>> lines;
ArrayList<PVector> points;
IntList playHeads;

HashMap<Integer,Boolean> move_playHead;
HashMap<Integer,IntList> move_playHead_divisions;
IntList no_of_divisions;

ArrayList<FloatList> lines_thickness;
FloatList points_thickness;


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
}

void draw(){
  
  
  //background(100,100,150);
  background(0,0,0);
  
  
  
      stroke(255,255,255);
  
  
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
      
      stroke(255,0,0);
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
      stroke(255,255,255);
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



