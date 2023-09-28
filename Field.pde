
public class Field {
  int x;
  int y;
  int w;
  int h;
  int score;
  int origScore;
  color backColour;
  color textColour;
  String type;
  int cr = (int)(vwu*16);
  int value = 1;

  public Field (int x, int y, int w, int h, int score, String type) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.score = score;
    this.type = type;

    if (this.type == "normal") {
      this.textColour = 0xB9;
      if (this.score < 3) {
        this.backColour = #5B4E4E;
      } else if (this.score < 6) {
        this.backColour = #344981;
      } else if (this.score < 11) {
        this.backColour = #3F8134;
      } else if (this.score < 21) {
        this.backColour = #813434;
      }
    } else if (this.type == "power") {
      this.backColour = #ffffff;
      this.textColour = #292929;
    } else if (this.type == "speed") {
      this.backColour = #ffffff;
      this.textColour = #813470;
    } else if (this.type == "newpoint") {
      this.backColour = #ffffff;
      this.textColour = #000000;
    } else if (this.type == "crown") {
      this.backColour = #ffffff;
      this.textColour = 0xB9;
      this.score = 1;
    }
  }

  public void draw() {
    noStroke();
    rectMode(CENTER);
    fill(this.backColour);
    rect(this.x, this.y, this.w, this.h, this.cr);
    fill(this.textColour);
    textAlign(CENTER, CENTER);
    if (this.type == "normal") {
      text(this.score, this.x, this.y-(vhu*2));
    } else if (this.type == "power") {
      text("+1 Power", this.x, this.y-(vhu*4));
    } else if (this.type == "speed") {
      text("+1 Speed", this.x, this.y-(vhu*4));
    } else if (this.type == "newpoint") {
      text("+1 Ball", this.x, this.y-(vhu*4));
    } else if (this.type == "crown") {
      int crown_d = (int)(this.h * 0.6);
      //shape(crown, this.x - (crown_d*1.19694787)/2, this.y - crown_d/2, crown_d*1.19694787, crown_d);
      image(crown_r, this.x - (crown_d*1.19694787)/2, this.y - crown_d/2, crown_d*1.19694787, crown_d);
    }
  }
}
