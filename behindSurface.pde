import org.openkinect.processing.*;
import processing.video.*;

Kinect2 kinect2;
Movie bgMovie;

//Kinect Depth Sensor threshold setting
int minDepth =  700;
int maxDepth =  4500; //4.5m

//Set depth step's sensitivity
int depthStep = 10;

//Set Dummy Image for pixel array
PImage blankImage;
//Photo of the Fish
PImage fishImage;
// CT Images 
int numCT = 8;
PImage[] ctImages = new PImage[numCT];

void setup() {
  size(1024, 848);
  //fullScreen(2);

  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initRegistered();
  kinect2.initDevice();
  
  bgMovie = new Movie(this, "bgmovie.mov");
  bgMovie.loop();
  
  //Set dummy image to kinect depth camera resoulution times two for higher image resolution of Fishes
  blankImage = new PImage(kinect2.depthWidth*2, kinect2.depthHeight*2);//1024 x 848
  
  fishImage = loadImage("bluefinTuna.png");
  
  //CT images array
  for(int i = 0; i < ctImages.length; i++){
    String ctNameOrder = "ctImage" + i + ".png";
    ctImages[i] = loadImage(ctNameOrder);
  }
}

void draw() {
  loadPixels();
  blankImage.loadPixels();
  fishImage.loadPixels();
  for(int i = 0; i < ctImages.length; i++){
    ctImages[i].loadPixels();
  }
  
  //get Kinect2 rawdepth array -> 512 x 484
  int[] rawDepth = kinect2.getRawDepth();

  //Make it double
  for(int y = 0; y < kinect2.depthHeight; y++){
    for(int x = 0; x < kinect2.depthWidth; x++){
      int i = x + y * kinect2.depthWidth;
      
      if (rawDepth[i] < minDepth){
        blankImage.pixels[x*2 + y*2*(2*kinect2.depthWidth)] = color(255,1);
        blankImage.pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)] = color(255,1);
        blankImage.pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)] = color(255,1);
        blankImage.pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)] = color(255,1);
      } 
      else if (rawDepth[i] >= minDepth && rawDepth[i] < minDepth + depthStep) {
        blankImage.pixels[x*2 + y*2*(2*kinect2.depthWidth)] = ctImages[7].pixels[x*2 + y*2*(2*kinect2.depthWidth)];
        blankImage.pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)] = ctImages[7].pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)];
        blankImage.pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)] = ctImages[7].pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)];
        blankImage.pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)] = ctImages[7].pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)];
      }
      else if (rawDepth[i] >= minDepth && rawDepth[i] < minDepth + 2*depthStep) {
        blankImage.pixels[x*2 + y*2*(2*kinect2.depthWidth)] = ctImages[6].pixels[x*2 + y*2*(2*kinect2.depthWidth)];
        blankImage.pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)] = ctImages[6].pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)];
        blankImage.pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)] = ctImages[6].pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)];
        blankImage.pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)] = ctImages[6].pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)];
      }
      else if (rawDepth[i] >= minDepth && rawDepth[i] < minDepth + 3*depthStep) {
        blankImage.pixels[x*2 + y*2*(2*kinect2.depthWidth)] = ctImages[5].pixels[x*2 + y*2*(2*kinect2.depthWidth)];
        blankImage.pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)] = ctImages[5].pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)];
        blankImage.pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)] = ctImages[5].pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)];
        blankImage.pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)] = ctImages[5].pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)];
      }
      else if (rawDepth[i] >= minDepth && rawDepth[i] < minDepth + 4*depthStep) {
        blankImage.pixels[x*2 + y*2*(2*kinect2.depthWidth)] = ctImages[4].pixels[x*2 + y*2*(2*kinect2.depthWidth)];
        blankImage.pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)] = ctImages[4].pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)];
        blankImage.pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)] = ctImages[4].pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)];
        blankImage.pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)] = ctImages[4].pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)];
      }
      else if (rawDepth[i] >= minDepth && rawDepth[i] < minDepth + 5*depthStep) {
        blankImage.pixels[x*2 + y*2*(2*kinect2.depthWidth)] = ctImages[3].pixels[x*2 + y*2*(2*kinect2.depthWidth)];
        blankImage.pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)] = ctImages[3].pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)];
        blankImage.pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)] = ctImages[3].pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)];
        blankImage.pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)] = ctImages[3].pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)];
      }
      else if (rawDepth[i] >= minDepth && rawDepth[i] < minDepth + 6*depthStep) {
        blankImage.pixels[x*2 + y*2*(2*kinect2.depthWidth)] = ctImages[2].pixels[x*2 + y*2*(2*kinect2.depthWidth)];
        blankImage.pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)] = ctImages[2].pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)];
        blankImage.pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)] = ctImages[2].pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)];
        blankImage.pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)] = ctImages[2].pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)];
      }
      else if (rawDepth[i] >= minDepth && rawDepth[i] < minDepth + 7*depthStep) {
        blankImage.pixels[x*2 + y*2*(2*kinect2.depthWidth)] = ctImages[1].pixels[x*2 + y*2*(2*kinect2.depthWidth)];
        blankImage.pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)] = ctImages[1].pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)];
        blankImage.pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)] = ctImages[1].pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)];
        blankImage.pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)] = ctImages[1].pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)];
      }
      else if (rawDepth[i] >= minDepth && rawDepth[i] < minDepth + 8*depthStep) {
        blankImage.pixels[x*2 + y*2*(2*kinect2.depthWidth)] = ctImages[0].pixels[x*2 + y*2*(2*kinect2.depthWidth)];
        blankImage.pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)] = ctImages[0].pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)];
        blankImage.pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)] = ctImages[0].pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)];
        blankImage.pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)] = ctImages[0].pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)];
      }
      else {
        blankImage.pixels[x*2 + y*2*(2*kinect2.depthWidth)] = fishImage.pixels[x*2 + y*2*(2*kinect2.depthWidth)];
        blankImage.pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)] = fishImage.pixels[(x*2+1) + y*2*(2*kinect2.depthWidth)];
        blankImage.pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)] = fishImage.pixels[x*2 + (y*2+1)*(2*kinect2.depthWidth)];
        blankImage.pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)] = fishImage.pixels[(x*2+1) + (y*2+1) *(2*kinect2.depthWidth)];
        //blankImage.pixels[i] = fishImage.pixels[i];
      }
      
    }
  }
 
  image(bgMovie,0,0,width,height);
  image(blankImage,0,0,width,height);
  //updatePixels();
  blankImage.updatePixels();
  
  
  //////////////////////////////////////////////////////////////////////////////////////////
  
  //// Draw the raw image
  //image(kinect2.getDepthImage(), 0, 0);

  //// Threshold the depth image
  //int[] rawDepth = kinect2.getRawDepth();
  
  
  //for (int i=0; i < rawDepth.length; i++) {
  //  if (rawDepth[i] >= minDepth && rawDepth[i] <= maxDepth) {
  //    depthImg.pixels[i] = color(255);
  //  } else {
  //    depthImg.pixels[i] = color(0);
  //  }
  //}
  

  //// Draw the thresholded image
  //depthImg.updatePixels();
  //image(depthImg, kinect2.depthWidth, 0);
  /////////////////////////////////////////////////////////////////////////////////////////


  fill(255);
  text("THRESHOLD: [" + minDepth + ", " + maxDepth + "]", 10, 36);
}

//Called every time a new frame is available to read
void movieEvent(Movie m){
  m.read();
}

// Adjust the angle and the depth threshold min and max
void keyPressed() {
  if (key == 'a') {
    minDepth = constrain(minDepth+10, 0, maxDepth);
  } else if (key == 's') {
    minDepth = constrain(minDepth-10, 0, maxDepth);
  } else if (key == 'z') {
    maxDepth = constrain(maxDepth+100, minDepth, 1165952918);
  } else if (key =='x') {
    maxDepth = constrain(maxDepth-100, minDepth, 1165952918);
  }
}