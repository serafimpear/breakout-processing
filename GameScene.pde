
public class GameScene {
  int mxl;
  int mxr;
  int myt;
  int myb;
  int wcount;
  int hcount;
  boolean gameOver = false;
  boolean playedGameOver = false;
  boolean playedGameWin = false;
  public FieldGrid my_field_grid;
  String state = null;
  int timer;
  boolean running = true;
  boolean leveloperation = false;

  public GameScene (int mxl, int mxr, int myt, int myb, int wcount, int hcount) {
    this.mxl = mxl;
    this.mxr = mxr;
    this.myt = myt;
    this.myb = myb;
    this.wcount = wcount;
    this.hcount = hcount;
  }

  public void create() {
    this.my_field_grid = new FieldGrid(this.mxl, this.myt, width - (this.mxl + this.mxr), height - (this.myt + this.myb), this.wcount, this.hcount, (int)(vwu*12));
    this.my_field_grid.create();
    background(#5B4E4E);
    fill(0xB9);
    rect((int)(vwu*20), (int)(vwu*20), width - (int)(vwu*40), height - (int)(vwu*40), (int)(vwu*32));
  }

  public void newLevel() {
    if (this.state == "first" && leveloperation == true) {
      this.state = "second";
      this.timer = millis();
      this.my_field_grid.fieldArray = null;
      this.my_field_grid = null;
      player.points = new ArrayList<PlayerPoint>();
      player.level += 1;
      player.score += 10*player.level;
      println("b");
      leveloperation = false;
    } else {
      if (millis() - this.timer > 2000) {
        this.state = "third";
        player.points.add(new PlayerPoint(width/2, (int)(vhu*(1027+25)), (int)(vwu*40), playerPoint.speedF, player.maxpower, 250));
        this.create();
        running = true;
        println("c");
      }
    }
  }

  public void newGame(boolean newlevel) {
    if (newlevel) {
      leveloperation = true;
      this.state = "first";
      this.running = false;
      println("a");
      this.wcount += 1;
      this.hcount += 1;
      newLevel();
    } else {
      player.reset();
      this.wcount = 3;
      this.hcount = 3;
      playedGameOver = false;
      this.gameOver = false;
      this.my_field_grid.fieldArray = null;
      this.my_field_grid = null;
      this.create();
    }
  }

  public void draw() {
    background(#5B4E4E);
    rectMode(CORNER);
    fill(0xB9);
    rect((int)(vwu*20), (int)(vwu*20), width - (int)(vwu*40), height - (int)(vwu*40), (int)(vwu*32));

    if (this.gameOver == false) {
      if (my_field_grid.fieldArray.size() == 0) {
        if (playedGameWin == false) {
          playedGameWin = true;
          game_win_sound.play();
        }
        gameOver();
      }
      this.my_field_grid.draw();
    } else {
      fill(#5B4E4E);
      textAlign(CENTER, CENTER);
      text("Game over!\n Your score: " + player.score + "\nClick to start a new game", width/2, height/2);
    }
  }

  public void gameOver() {
    this.gameOver = true;
    //playerPoint = null;
  }
}
