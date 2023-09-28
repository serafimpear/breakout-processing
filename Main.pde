//#####################// //<>//

int wcount = 3;
int hcount = 3;

String playerName = "";
boolean online = false;
boolean local = false;
String ver = "v1.3-beta";
String adress = "serafim.link:3400";

//#####################//
/*

 SOFTWARE LICENSE AGREEMENT
 
 This Agreement is a legally binding contract between you ("Licensee") and Serafim Thaler, the owner of the code ("Licensor"), dated 30.05.2023, Class 4AN. By using the code and playing the game, you agree to the following terms.
 
 License Grant: Licensor grants Licensee a non-exclusive, non-transferable license to use the code and play the game for personal or educational purposes only.
 
 Restrictions: Licensee may not copy the code entirely or publish it under a different name. The code remains the property of Serafim Thaler and is protected by applicable laws.
 
 Ownership: The code was written and belongs to Serafim Thaler, dated 30.05.2023, Class 4AN.
 
 Use of Open Source Libraries: The code may incorporate open-source libraries, which are subject to their respective licenses. The ownership of these libraries belongs to their creators, as specified in their respective licenses.
 
 Prohibited Activities: Licensee must not use the code or game for illegal purposes or engage in unauthorized distribution or modification.
 
 Disclaimer of Warranty: The code and game are provided "as is" without any warranty. Licensor is not responsible for any damages or issues arising from their use.
 
 Termination: Violation of the agreement may result in immediate termination and legal action.
 
 By using the code and playing the game, you acknowledge and accept the terms and conditions of this Agreement.
 
 */

import controlP5.*;
import java.*;
import processing.sound.*;
import websockets.*;

WebsocketClient wsc;

SoundFile pop_effect;
SoundFile game_over_sound;
SoundFile game_win_sound;

boolean nameSet = false;

ControlP5 cp5;
Textfield playerNameField;
Textlabel titleLabel;
Textlabel playerNameText;
Textlabel playerNameEnter;

float vwu, vhu;
// (int)(vwu*
// (int)(vhu*
int design_wu = 2240;
int design_hu = 1400;

GameScene my_game_scene;
PlayerPoint playerPoint;
PlayerPoint playerPoint2;
PointBar pointBar;
Player player;
PShape crown;

int time;
int fps;
int cc = 0;

String yourVariable;

PFont kufam_bold, kufam_regular, kufam_bold_big, kufam_regular_small;

int timeC = millis();

PImage crown_r;

void setup() {
  frameRate(600);

  println("Breakout Processing by Serafim Thaler\n");

  //fullScreen();
  //println("Running fullscreen mode, width", width, "px, height", height, "px");
  size(1120, 700);
  println("Running not-fullscreen mode, width", width, "px, height", height, "px");


  surface.setTitle("Breakout Processing " + ver + " by Serafim Thaler");
  //noCursor();

  println("Calculating virtual width unit (vwu) and  virtual height unit (vhu)");
  vwu = (float)width/design_wu;
  vhu = (float)height/design_hu;
  println("    vwu =", vwu, "of", design_wu, "px\n    vhu =", vhu, "of", design_hu, "px");
  if (vwu != vhu) println("[WARNING!] Other aspect ratio detected\n");

  crown_r = loadImage("crown.png");
  player = new Player(0, playerName, online);
  player.points.add(new PlayerPoint(width/2, (int)(vhu*(1027+25)), (int)(vwu*40), (int)(vwu*3), 1, 225+90));

  my_game_scene = new GameScene((int)(vwu*58), (int)(vwu*58), (int)(vhu*180), (int)(vhu*503), wcount, hcount);
  my_game_scene.create();
  println("Scene successfully created");

  playerPoint = new PlayerPoint(width/2, (int)(vhu*(1027+25)), (int)(vwu*40), 3, 1, 225+90+180);
  println("Player successfully created");

  pointBar = new PointBar(width/2, (int)(vhu*1182), (int)(vhu*470), (int)(vhu*23));
  println("PointBar successfully created");

  kufam_bold = createFont("Kufam-Bold.ttf", (int)(vwu*40));
  kufam_regular = createFont("Kufam-Regular.ttf", (int)(vwu*50));
  kufam_bold_big = createFont("Kufam-Bold.ttf", (int)(vwu*60));
  kufam_regular_small = createFont("Kufam-Regular.ttf", (int)(vwu*34));

  pop_effect = new SoundFile(this, "pop.mp3");
  game_win_sound = new SoundFile(this, "level-completed.mp3");
  game_over_sound = new SoundFile(this, "game-over.mp3");

  if (online == true) {
    if (local == true) {
      wsc = new WebsocketClient(this, "ws://localhost:3400");
    } else {
      wsc = new WebsocketClient(this, "ws://"+adress);
    }
  }


  PImage titlebaricon = loadImage("icon.png");
  surface.setIcon(titlebaricon);



  // Create a new instance of ControlP5
  cp5 = new ControlP5(this);

  // Define the dimensions and position of the text field
  int textFieldWidth = (int)(vwu * 470);
  int textFieldHeight = (int)(vhu * 90);
  int textFieldX = width/2 - textFieldWidth/2;
  int textFieldY = height/2 - textFieldHeight/2;

  titleLabel = cp5.addTextlabel("titleLabel").setText("Breakout Protscheßing " + ver + " by Serafim").setPosition((int)(vwu*410), (int)(vhu*220)).setFont(kufam_bold_big).setColorValue(#355085);
  playerNameText = cp5.addTextlabel("playerNameText").setText("Enter Player Name").setPosition(textFieldX+(int)(vwu * 3), textFieldY - (int)(vhu * 90)).setFont(kufam_regular).setColorValue(#5B4E4E);
  playerNameField = cp5.addTextfield("playerName").setPosition(textFieldX, textFieldY).setSize(textFieldWidth, textFieldHeight).setFont(kufam_regular).setColorBackground(color(185, 185, 185)).setColorForeground(color(91, 78, 78)).setColorActive(color(91, 78, 78)).setColor(color(0)).setAutoClear(false) .setCaptionLabel("").setText("");
  playerNameEnter = cp5.addTextlabel("playerNameEnter").setText("press Enter to start").setPosition(textFieldX+(int)(vwu * 77), textFieldY + (int)(vhu * 300)).setFont(kufam_regular_small).setColorValue(#5B4E4E);
}

void draw() {
  if (nameSet != true) {
  } else {
    if (my_game_scene.running) {
      time = millis();
      my_game_scene.draw();
      pointBar.move();

      player.pointsPrevSize = player.points.size();
      for (int o = 0; o < player.points.size(); o++) {
        println("Here start o " + o);
        for (int i = 0; i < player.points.get(o).speedF; i++) {
          println("Here start i " + i);
          player.points.get(o).checkCollisions();
          if (my_game_scene.gameOver || (my_game_scene.running == false)) break;

          if (player.points.size() != player.pointsPrevSize) break;
          player.points.get(o).move();
          println("Here end i " + i);
        }
        if (my_game_scene.gameOver || (my_game_scene.running == false)) break;
        if (player.points.size() != player.pointsPrevSize) break;

        player.points.get(o).draw();
        println("Here end o " + o);
      }
      if (my_game_scene.gameOver == false && (my_game_scene.running == true)) {

        pointBar.draw();

        player.drawStats();

        // Name
        fill(#5B4E4E);
        text("Name: ", (int)(vwu*(360)), (int)(vhu*57));
        fill(#355085);
        text(playerName, (int)(vwu*(530)), (int)(vhu*57));

        // Online
        fill(#5B4E4E);
        text("Online:", (int)(vwu*(800)), (int)(vhu*57));
        fill(#355085);
        text(""+online, (int)(vwu*(1000)), (int)(vhu*57));


        // Frame execution speed
        fill(#5B4E4E);
        textAlign(LEFT, TOP);
        text("Frame Execution Speed", (int)(vwu*1240), (int)(vhu*1280));
        fill(#355085);
        text(fps, (int)(vwu*1833), (int)(vhu*1280));



        if (cc % 15 == 0) {
          fps = (int)(1000/(millis()-time+0.00000001));
        }
      }
      cc++;

      if ((millis() - timeC > 5000) && (online == true && nameSet == true)) {
        wsc.sendMessage(playerName+","+player.score);
        timeC = millis();
      }
    } else {
      println("checking if more than 2s timer");
      if (millis() - my_game_scene.timer > 2000) {
        println("checking if more than 2s timer - YES");
        my_game_scene.state = "third";
        player.points.add(new PlayerPoint(width/2, (int)(vhu*(1027+25)), (int)(vwu*40), playerPoint.speedF, player.maxpower, 250));
        my_game_scene.create();
        my_game_scene.running = true;
        println("c");
      }
      println("checking if more than 2s timer - CONTINUE");

      //my_game_scene.newLevel();// Level
      background(#5B4E4E);
      rectMode(CORNER);
      fill(0xB9);
      rect((int)(vwu*20), (int)(vwu*20), width - (int)(vwu*40), height - (int)(vwu*40), (int)(vwu*32));
      fill(#5B4E4E);
      text("Level", (int)(vwu*(1020)), (int)(vhu*580));
      fill(#355085);
      text(player.level, (int)(vwu*(1170)), (int)(vhu*580));

      fill(#5B4E4E);
      text("You've got", (int)(vwu*(950)), (int)(vhu*680));
      fill(#355085);
      text("+" + 10*player.level, (int)(vwu*(1120)), (int)(vhu*680));
      fill(#5B4E4E);
      text("xp!", (int)(vwu*(1220)), (int)(vhu*680));
      //noLoop();
    }
  }
}

void mousePressed() {
  if (my_game_scene.gameOver) my_game_scene.newGame(false);
  //textField.handleClick(mouseX, mouseY);
}

void webSocketEvent(String msg) {
  println("New message ", msg);
}

void keyPressed() {
  if (key == ENTER || key == RETURN) {
    playerName = playerNameField.getText();
    playerNameField.hide();
    playerNameText.hide();
    playerNameEnter.hide();
    titleLabel.hide();
    nameSet = true;
    println("Player Name: " + playerName);
  }
}
