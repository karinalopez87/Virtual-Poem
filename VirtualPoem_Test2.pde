import ddf.minim.*;
import org.openkinect.processing.*;
import processing.video.*;


Movie vid;
Movie vid2;
Movie vid3;
Movie vid4;
AudioPlayer sound1;
AudioPlayer sound2;
AudioPlayer sound3;
AudioPlayer sound4;
Minim minim;

boolean fading = false;

Kinect2 kinect2;

//PImage depthImg;
//PImage img1;

//pixel
int minDepth=0;
int maxDepth=4500; //4.5m

void setup() {
  size(1024, 768);
  //fullScreen();
  //Optoma : 1024x768
  
  minim = new Minim(this);
  vid = new Movie(this, "Part1-1.mov");
  vid2 = new Movie(this, "Part2-1.mov");
  vid3 = new Movie(this, "Part3-1.mov");
  vid4 = new Movie(this, "Part4-1.mov");
  sound1 = minim.loadFile("Part1.mp3");
  sound2 = minim.loadFile("Part2.mp3");
  sound3 = minim.loadFile("Part3.mp3");
  sound4 = minim.loadFile("Part4.mp3");

  //MOVIE FILES
      //Part1-1.mov
      //Part2-1.mov
      //Part3-1.mov
      //Part4-1.mov
  //SOUND FILES      
      //Part1.mp3
      //Part2.mp3
      //Part3.mp3
      //Part4.mp3
            
  vid.loop();
  vid2.loop();
  vid3.loop();
  vid4.loop();
  
  sound1.loop();
  sound2.loop();
  sound3.loop();
  sound4.loop();
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
//depthImg = new PImage(kinect2.depthWidth, kinect2.depthHeight);
//img1 = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);
}

void movieEvent(Movie vid){
  vid.read();
  vid2.read();
  vid3.read();
  vid4.read();
}


void draw() { 
  vid.loadPixels();
  vid2.loadPixels();
  vid3.loadPixels();
  vid4.loadPixels();
  
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
vid2.updatePixels();
vid3.updatePixels();
vid4.updatePixels();

float avgX = sumX/totalPixels;
float avgY=sumY/totalPixels;

float currentVolume1 = sound1.getGain();
float currentVolume2 = sound2.getGain();
float currentVolume3 = sound3.getGain();
float currentVolume4 = sound4.getGain();

        //VID 01
if (avgX>300 && avgX<500){
tint(255, (avgX)/2);
image(vid, 0, 0);
sound1.shiftGain(currentVolume1,10,10);
fading = true;
}else{
tint(0, (avgX)/2);
image(vid, 0, 0);
sound1.shiftGain(currentVolume1,-80,10);
fading=false;
 }
         //VID 02
 if (avgX>50 && avgX<200){
tint(255, (avgX)/3);
image(vid2, 0, 0);
sound2.shiftGain(currentVolume2,13,1000);
fading = true;
}else{
   tint(0, (avgX)/3);
   image(vid2, 0, 0);
   sound2.shiftGain(currentVolume2,-80,1000);
  fading=false;
 }
          //VID 03
 if (avgX>600 && avgX<800){
tint(255, (avgX)/3);
image(vid3, 0, 0);
sound3.shiftGain(currentVolume3,13,1000);
fading = true;
}else{
   tint(0, (avgX)/3);
   image(vid3, 0, 0);
   sound3.shiftGain(currentVolume3,-80,1000);
  fading=false;
 }
          //VID 04
 if (avgX>1000 && avgX<1200){
tint(255, (avgX)/3);
image(vid4, 0, 0);
sound4.shiftGain(currentVolume4,13,1000);
fading = true;
}else{
   tint(0, (avgX)/3);
   image(vid4, 0, 0);
   sound4.shiftGain(currentVolume4,-80,1000);
  fading=false;
 }
}

 
   //Draw the thresholded image
  //depthImg.updatePixels();
  //image(depthImg, kinect2.depthWidth, 0);