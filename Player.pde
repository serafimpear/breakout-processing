
public class Player {
  int score;
  int level = 1;
  String name;
  int maxpower = 1;
  boolean online;
  public ArrayList<PlayerPoint> points;
  int pointsPrevSize;

  public Player (int score, String name, boolean online) {
    this.score = score;
    this.name = name;
    this.online = online;
    points = new ArrayList<PlayerPoint>();
  }

  public void drawStats() {
    textFont(kufam_regular);

    // Score
    fill(#5B4E4E);
    textAlign(LEFT, TOP);
    text("Score", (int)(vwu*58), (int)(vhu*57));
    fill(#355085);
    text(this.score, (int)(vwu*212), (int)(vhu*57));
    
    // Power
    fill(#5B4E4E);
    textAlign(LEFT, TOP);
    text("Max power", (int)(vwu*65), (int)(vhu*1280));
    fill(#355085);
    text(this.maxpower, (int)(vwu*345), (int)(vhu*1280));
  }

  public void reset() {
    this.level = 1;
    wcount = 3;
    hcount = 3;
    this.score = 0;
    this.points.clear();
    this.points.add(new PlayerPoint(width/2, (int)(vhu*(1027+25)), (int)(vwu*40), playerPoint.speedF, 1, 250));
  }
}
