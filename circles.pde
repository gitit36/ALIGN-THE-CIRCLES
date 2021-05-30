PFont easyfont;
int now_time = 0;
import processing.serial.*;
Serial myPort;
int radius=10;
float initial_rad = 30;
float time = 0;
boolean game_start = false;
int c = 0;
int count = 0;
float[] scoreboard = new float[10];
String[] timestamp = new String[10];

void setup(){
  size(600,400);
  easyfont = createFont("arial", 50);
  now_time = millis();
  smooth();
  //printArray(Serial.list());
  String portname=Serial.list()[4];
  //println(portname);
  myPort = new Serial(this,portname,9600);
  myPort.clear();
  myPort.bufferUntil('\n');
}

void draw(){
  background(255);
  fill(#00cc33);
  textSize(24);
  text("Overlap 3 circles as fast as you can...", width/2, height-20);
  textAlign(CENTER,CENTER);
  textFont(easyfont);
  textSize(24);
  text(nf(time,0,2)+" sec", width/2, 25);
  noFill();
  strokeWeight(10);
  circle(width/2,height/2,radius);
  
  textSize(10);
  fill(0);
  text("Number of circles so far: " + c, width-70, 25);
  
  if(abs(initial_rad - radius) < 3){
    fill(#FFC300);
    textSize(48);

    game_start = false;
    initial_rad = random(1,height);
    c += 1;
    if(c == 3){
      c = 0;
      println(nf(time,0,2));
      now_time = millis();
      scoreboard[count] = time;
      timestamp[count] = str(hour())+":"+str(minute())+":"+str(second());
      printArray(timestamp);
      count += 1;
    }
  }
  else{
    time = (millis()-now_time)/1000f;
  }
  game_start = true;
  noFill();
  circle(width/2, height/2, initial_rad);
  
  for(int i=0; i<10; i++){
    textSize(20);
    text("SCOREBOARD", 80, 25);
    textSize(18);
    text(timestamp[i] + "  " + scoreboard[i], 70, 60+i*20);
  }
}

void serialEvent(Serial myPort){
  String s=myPort.readStringUntil('\n');
  s=trim(s);
  if (s!=null){
    radius=(int)map(int(s),0,1023,0, height);
  }
  myPort.write('0');
}
