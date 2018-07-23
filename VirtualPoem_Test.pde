import processing.sound.*;
import org.openkinect.processing.*;
import processing.video.*;


Movie vid;
Movie vid1;
SoundFile sound1;
SoundFile sound2;
Kinect2 kinect2;

//PImage depthImg;
//PImage img1;

//pixel
int minDepth=0;
int maxDepth=4500; //4.5m

boolean off = false;

void setup() {
  size(1920,1080);
  //fullScreen();
  vid = new Movie(this, "test_1.1.mp4");
  vid1 = new Movie(this, "test_1.1.mp4");
  sound1 = new SoundFile(this, "cosmos.mp3");
  sound2 = new SoundFile(this, "NosajThing_Distance.mp3");
  
  //MOVIE FILES
      //01.MOV
      //03.MOV
      //02.mov (File's too big)
      //Urban Streams.mp4
      //HiddenNumbers_KarinaLopez.mov
      //test_w-sound.mp4
      //test_1.1.mp4
      //test005.mov
  //SOUND FILES      
      //cosmos.mp3
      //NosajThing_Distance.mp3
            
  vid.loop();
  vid1.loop();
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
//depthImg = new PImage(kinect2.depthWidth, kinect2.depthHeight);
//img1 = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);
}

void movieEvent(Movie vid){
  vid.read();
  vid1.read();
}


void draw() { 
  vid.loadPixels();
  vid1.loadPixels();
  
  //image(kinect2.getDepthImage(), 0, 0);
  
    int[] depth = kinect2.getRawDepth();
  
  float sumX=0;
  float sumY=0;
  float totalPixels=0;

    for (int x = 0; x < kinect2.depthWidth; x++){
      for (int y = 0; y < kinect2.depthHeight; y++){
        int offset = x + y * kinect2.depthWidth;
        int d = depth[offset];
        
        if ( d > 0 && d < 1000){
      //    //video.pixels[offset] = color(255, 100, 15);
      sumX +=x;
      sumY+=y;
      totalPixels++;
         brightness(0);
        } else {
      //    //video.pixels[offset] = color(150, 250, 180);
          brightness(255);
        }      }
    }
vid.updatePixels();
vid1.updatePixels();

float avgX = sumX/totalPixels;
float avgY=sumY/totalPixels;


        //VID 01 - Screen 01
if (avgX>300 && avgX<500){
tint(255, (avgX)/2);
image(vid1, 1920/2, 0);
if(sound2.isPlaying()==0){
sound2.play(0.5);
sound2.amp(0.5);
}
}else{
tint(0, (avgX)/2);
image(vid1, 1920/2, 0);
if(sound2.isPlaying()==1){
 delay(1);
 sound2.amp(0);
 }
}
         //VID 02 - Screen 01
 if (avgX>50 && avgX<200){
tint(255, (avgX)/3);
image(vid, 0-(1920/2), 0);
}else{
   tint(0, (avgX)/3);
   image(vid, 0-(1920/2), 0);
 }
}

 
           // SCR 02
 
 ////VID 01 - Screen 02
 // if (avgX>50 && avgX<200){
//tint(255, (avgX+avgY)/2);
 //image(vid, 0-(1920/2), 0);
 //}else{
 //  tint(0, (avgX+avgY)/2);
 //  image(vid, 0-(1920/2), 0);
 //}
 
 ////VID 02 - Screen 02
 // if (avgX>50 && avgX<200){
//tint(255, (avgX+avgY)/2);
 //image(vid, 0-(1920/2), 0);
 //}else{
 //  tint(0, (avgX+avgY)/2);
 //  image(vid, 0-(1920/2), 0);
 //}


  
   //Draw the thresholded image
  //depthImg.updatePixels();
  //image(depthImg, kinect2.depthWidth, 0);