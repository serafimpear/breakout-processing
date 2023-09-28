
public class PlayerPoint {
  float x;
  float y;
  int d;
  int speed;
  int maxSpeedF = (int)(vwu*13);
  int minSpeedF = (int)(vwu*5);
  int speedF = minSpeedF;
  int power;
  float angle; // between 0 and 360 deg
  color colour;
  int max_speed = 1;
  float angle_field_point;
  float debugggg;
  Field currentField;

  public PlayerPoint (int x, int y, int d, int minSpeedF, int power, float angle) {
    this.x = x;
    this.y = y;
    this.d = d;
    this.speed = 1;
    this.minSpeedF = minSpeedF;
    this.speedF = minSpeedF;
    this.power = power;
    this.angle = angle;
    this.colour = #5B4E4E;
    //this.colour = #ff0000;
  }

  public void draw() {
    textFont(kufam_regular);

    // Point
    noStroke();
    fill(this.colour);
    circle(this.x, this.y, this.d);

    /*
    // Score
     fill(#5B4E4E);
     textAlign(LEFT, TOP);
     text("Score", (int)(vwu*58), (int)(vhu*57));
     fill(#355085);
     text(this.score, (int)(vwu*212), (int)(vhu*57));
     
     // Min speed
     fill(#5B4E4E);
     text("Min speed", (int)(vwu*(58+250)), (int)(vhu*1235));
     fill(#355085);
     text(this.minSpeedF, (int)(vwu*(229+356)), (int)(vhu*1235));
     
     // Max speed
     fill(#5B4E4E);
     text("Max speed", (int)(vwu*(58+250)), (int)(vhu*1300));
     fill(#355085);
     text(this.maxSpeedF+this.minSpeedF, (int)(vwu*(229+356)), (int)(vhu*1300));
     
     // Speed
     fill(#5B4E4E);
     text("Speed", (int)(vwu*58), (int)(vhu*1235));
     fill(#355085);
     text(this.speedF, (int)(vwu*229), (int)(vhu*1235));
     
     // Power
     fill(#5B4E4E);
     text("Power", (int)(vwu*58), (int)(vhu*1300));
     fill(#355085);
     text(this.power, (int)(vwu*229), (int)(vhu*1300));
     */
  }

  public void move() {
    this.x += this.speed*cos(radians(this.angle));
    this.y += (this.speed*sin(radians(this.angle)));
  }

  public void checkCollisions() {
    println("checkcollisions start");
    for (int i = 0; i < my_game_scene.my_field_grid.fieldArray.size(); i++) {

      println("checkcollisions start field " + i);
      currentField = my_game_scene.my_field_grid.fieldArray.get(i);
      checkIfCollidesAndAct((int)this.x, (int)this.y, currentField, i);
      if (my_game_scene.gameOver == true || (my_game_scene.running == false)) break;
    }
    println("checkcollisions start bar ");
    checkIfCollidesWithBar((int)this.x, (int)this.y);
    println("checkcollisions start ramen ");
    checkIfCollidesWithRamen((int)this.x, (int)this.y);
  }

  private void checkIfCollidesWithBar(int px, int py) {
    // check collisions with bar
    if (((py >= pointBar.y - this.d/2 - pointBar.h/2) && ((py <= pointBar.y - pointBar.h/2))) && ((px > pointBar.x - (pointBar.w / 2) - 2) && (px < pointBar.x + (pointBar.w / 2) + 2))) {
      this.angle = 0.5*((270 + (int)((((float)(this.x-pointBar.x))/((float)(pointBar.w/2)))*90))+(360 - this.angle));
      this.angle = constrain(this.angle, 190, 350);
      text(this.speedF, 40, 200);

      //this.angle = 360 - this.angle;
      pop_effect.play();
    }
    /* else if (dist(px, py, pointBar.x - pointBar.w/2 + pointBar.barr, pointBar.y -  pointBar.h/2 + pointBar.barr) <= (pointBar.barr + (this.d/2))) {
     println("left top bar");
     PVector cspeedv = new PVector(this.speed*cos(radians(this.angle)), this.speed*sin(radians(this.angle)));
     PVector normalVspeed = new PVector(this.x - pointBar.x - pointBar.w/2 + pointBar.barr, this.y - pointBar.y - pointBar.h/2 + pointBar.barr);
     normalVspeed.normalize();
     PVector reflected = PVector.sub(cspeedv, PVector.mult(normalVspeed, 2*PVector.dot(cspeedv, normalVspeed)));
     this.angle = degrees(PVector.angleBetween(reflected, new PVector(1, 0)));
     pop_effect.play();
     } else if (dist(px, py, pointBar.x + pointBar.w/2 - pointBar.barr, pointBar.y -  pointBar.h/2 + pointBar.barr) <= (pointBar.barr + (this.d/2))) {
     println("right top bar");
     PVector cspeedv = new PVector(this.speed*cos(radians(this.angle)), this.speed*sin(radians(this.angle)));
     PVector normalVspeed = new PVector(this.x - pointBar.x - pointBar.w/2 + pointBar.barr, this.y - pointBar.y - pointBar.h/2 + pointBar.barr);
     normalVspeed.normalize();
     PVector reflected = PVector.sub(cspeedv, PVector.mult(normalVspeed, 2*PVector.dot(cspeedv, normalVspeed)));
     this.angle = degrees(PVector.angleBetween(reflected, new PVector(1, 0)));
     pop_effect.play();
     } */
  }

  private void checkIfCollidesWithRamen(int px, int py) {

    if (my_game_scene.gameOver == false && (my_game_scene.running == true)) {
      // check collisions with Ramen
      if (px == my_game_scene.my_field_grid.x + this.d/2) {
        this.angle = 540 - this.angle;
        pop_effect.play();
      } else if (px == my_game_scene.my_field_grid.x + my_game_scene.my_field_grid.w - this.d/2) {
        this.angle = 540 - this.angle;
        pop_effect.play();
      } else if (py == my_game_scene.my_field_grid.y + this.d/2) {
        this.angle = 360 - this.angle;
        pop_effect.play();
      } else if (py > height) {
        player.points.remove(this);
        println(player.points.size());
        if (player.points.size() <= 0) {
          if (my_game_scene.playedGameOver == false) {
            my_game_scene.playedGameOver = true;
            game_over_sound.play();
          }
          my_game_scene.gameOver();
        }
      }
    }
  }

  private void checkIfCollidesAndAct(int px, int py, Field field, int i) {

    // check collisions with fields, old versiondist(px, py, field.x, field.y) < field.w + this.max_speed
    if (true) {
      if (px == field.x - this.d/2 - field.w/2) {
        if ((py > field.y - field.h/2) && (py < field.y + field.h/2)) {
          this.angle = 540 - this.angle;
          handleField(my_game_scene.my_field_grid.fieldArray, i);
        }
      } else if (px == field.x + field.w/2 + this.d/2) {
        if ((py > field.y - field.h/2) && (py < field.y + field.h/2)) {
          this.angle = 540 - this.angle;
          handleField(my_game_scene.my_field_grid.fieldArray, i);
        }
      } else {
        if (py == field.y - field.h/2 - this.d/2) {
          if ((px > field.x - field.w/2) && (px < field.x + field.w/2)) {
            this.angle = 360 - this.angle;
            handleField(my_game_scene.my_field_grid.fieldArray, i);
          }
        }
        if (py == field.y + field.h/2 + this.d/2) {
          if ((px > field.x - field.w/2) && (px < field.x + field.w/2)) {
            this.angle = 360 - this.angle;
            handleField(my_game_scene.my_field_grid.fieldArray, i);
          }
        }
      }

      // Corners

      // left top
      if (dist(px, py, field.x - field.w/2 + field.cr, field.y - field.h/2 + field.cr) <= (field.cr + (this.d/2))) {
        println("left top");
        PVector cspeedv = new PVector(this.speed*cos(radians(this.angle)), this.speed*sin(radians(this.angle)));
        PVector normalVspeed = new PVector(this.x - field.x - field.w/2 + field.cr, this.y - field.y - field.h/2 + field.cr);
        normalVspeed.normalize();
        PVector reflected = PVector.sub(cspeedv, PVector.mult(normalVspeed, 2*PVector.dot(cspeedv, normalVspeed)));
        this.angle = degrees(PVector.angleBetween(reflected, new PVector(1, 0)));
      } else if (dist(px, py, field.x + field.w/2 - field.cr, field.y - field.h/2 + field.cr) <= (field.cr + (this.d/2))) {
        println("right top");
        PVector cspeedv = new PVector(this.speed*cos(radians(this.angle)), this.speed*sin(radians(this.angle)));
        PVector normalVspeed = new PVector(this.x - field.x - field.w/2 + field.cr, this.y - field.y - field.h/2 + field.cr);
        normalVspeed.normalize();
        PVector reflected = PVector.sub(cspeedv, PVector.mult(normalVspeed, 2*PVector.dot(cspeedv, normalVspeed)));
        this.angle = degrees(PVector.angleBetween(reflected, new PVector(1, 0)));
      } else if (dist(px, py, field.x - field.w/2 + field.cr, field.y + field.h/2 - field.cr) <= (field.cr + (this.d/2))) {
        println("left bottom");
        PVector cspeedv = new PVector(this.speed*cos(radians(this.angle)), this.speed*sin(radians(this.angle)));
        PVector normalVspeed = new PVector(this.x - field.x - field.w/2 + field.cr, this.y - field.y - field.h/2 + field.cr);
        normalVspeed.normalize();
        PVector reflected = PVector.sub(cspeedv, PVector.mult(normalVspeed, 2*PVector.dot(cspeedv, normalVspeed)));
        this.angle = degrees(PVector.angleBetween(reflected, new PVector(1, 0)));
      } else if (dist(px, py, field.x + field.w/2 - field.cr, field.y + field.h/2 - field.cr) <= (field.cr + (this.d/2))) {
        println("right bottom");
        PVector cspeedv = new PVector(this.speed*cos(radians(this.angle)), this.speed*sin(radians(this.angle)));
        PVector normalVspeed = new PVector(this.x - field.x - field.w/2 + field.cr, this.y - field.y - field.h/2 + field.cr);
        normalVspeed.normalize();
        PVector reflected = PVector.sub(cspeedv, PVector.mult(normalVspeed, 2*PVector.dot(cspeedv, normalVspeed)));
        this.angle = degrees(PVector.angleBetween(reflected, new PVector(1, 0)));
      }
    }
  }

  private void handleField(ArrayList<Field> fieldArray, int i) {

    if (my_game_scene.gameOver == false && (my_game_scene.running == true)) {
      fieldArray.get(i).score -= this.power;
      pop_effect.play();
      if (fieldArray.get(i).type == "normal") {
        if (fieldArray.get(i).score < 3) {
          fieldArray.get(i).backColour = #5B4E4E;
        } else if (fieldArray.get(i).score < 6) {
          fieldArray.get(i).backColour = #344981;
        } else if (fieldArray.get(i).score < 11) {
          fieldArray.get(i).backColour = #3F8134;
        } else if (fieldArray.get(i).score < 21) {
          fieldArray.get(i).backColour = #813434;
        }
      }
        player.score += 1;
      //player.score += min(this.power, fieldArray.get(i).score);
      if (fieldArray.get(i).score < 1) {
        if (fieldArray.get(i).type == "power") {
          this.power += fieldArray.get(i).value;
          if (player.maxpower < this.power) {
            player.maxpower = this.power;
          }
        } else if (fieldArray.get(i).type == "speed") {
          this.speedF += fieldArray.get(i).value;
        } else if (fieldArray.get(i).type == "crown") {
          my_game_scene.newGame(true);
        } else if (fieldArray.get(i).type == "newpoint") {
          // new point
          player.points.add(new PlayerPoint((int)this.x, (int)this.y, (int)(vwu*40), (int)(vwu*3), this.power, this.angle + 180));
        }
        fieldArray.remove(i);
      }
    }
  }
}
