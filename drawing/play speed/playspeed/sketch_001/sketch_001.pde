import pitaru.sonia_v2_9.*;
 
Sample mySample; 
 
void setup() { 
  size(100,100); 
  Sonia.start(this); 
  mySample = new Sample("test_song.aiff"); 


  
  mySample.play(); 

} 

void draw(){
    float x= map(mouseX,0,width,1,5)); 
  mySample.setSpeed(x);
    println(x);
  



}
 
public void stop(){ 
  Sonia.stop(); 
  super.stop(); 
} 
