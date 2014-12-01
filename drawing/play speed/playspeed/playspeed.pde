import pitaru.sonia_v2_9.*;

  
// Play a sample once. 
// Notes: Make sure to include the specified audio file in your project's 'data' folder. 
 
 
 
Sample mySample; 
 
void setup() { 
  size(100,100); 
  Sonia.start(this); 
  mySample = new Sample("test_song.aiff"); 
  mySample.play(); 
} 
 
public void stop(){ 
  Sonia.stop(); 
  super.stop(); 
} 
