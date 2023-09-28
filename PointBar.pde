
public class PointBar {
  int x;
  int y;
  int w;
  int h;
  int barr;
  color colour;
  float barSpeed = 1;
  int prevPosX;
  String navmode;
  int prev_mx, prev_my;

  public PointBar (int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.barr = (int)(this.h/2);
  }

  public void draw() {
    // Stripe
    noStroke();
    fill(#5B4E4E);
    rectMode(CENTER);
    rect(this.x, this.y, this.w, this.h, this.barr);
  }

  public void move() {
    if ((mouseX != prev_mx) || (mouseY != prev_my)) navmode = "mouse";
    if (keyPressed == true) {
      navmode = "keyboard";
      if (keyCode == LEFT) {
        this.x = constrain(this.x - (int)(12), my_game_scene.mxl + (this.w/2), width - my_game_scene.mxr - (this.w/2));
      } else if (keyCode == RIGHT) {
        this.x = constrain(this.x + (int)(12), my_game_scene.mxl + (this.w/2), width - my_game_scene.mxr - (this.w/2));
      }
    }
    if (navmode == "mouse") this.x = constrain(mouseX, my_game_scene.mxl + (this.w/2), width - my_game_scene.mxr - (this.w/2));
    //this.barSpeed = pow(abs((float)((this.prevPosX - this.x - my_game_scene.mxl)*100)/(float)(width-(my_game_scene.mxl+my_game_scene.mxr))), 2);
    this.prevPosX = this.x;
    
    prev_mx = mouseX;
    prev_my = mouseY;
  }
}
