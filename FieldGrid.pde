
public class FieldGrid {
  int x, y, w, h, field_count_x, field_count_y, field_margin, field_width, field_height;
  String type;
  color colour;
  public ArrayList<Field> fieldArray;

  public FieldGrid (int x, int y, int w, int h, int field_count_x, int field_count_y, int field_margin) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.field_count_x = field_count_x;
    this.field_count_y = field_count_y;
    this.field_margin = field_margin;
    this.fieldArray = new ArrayList<Field>();
    this.field_width = ((this.w - ((this.field_count_x - 1) * this.field_margin))/this.field_count_x);
    // this.field_height = ((this.h - ((this.field_count_y - 1) * this.field_margin))/this.field_count_y);
    this.field_height = (int)((vhu*69*9)/hcount);
  }

  public void create() {
    this.field_height = (int)((this.h)/field_count_y);
    int ly = 0;
    int lx;
    for (int iy = 0; iy < field_count_y; iy++) {
      lx = 0;
      for (int ix = 0; ix < field_count_x; ix++) {
        int randomNum = (int)random(0, 100);
        if (randomNum <= 7) {
          type = "power";
        } else if (randomNum <= 14) {
          type = "speed";
        } else if (randomNum <= 21) {
          type = "newpoint";
        } else {
          type = "normal";
        }
        if (ix == field_count_x/2 && iy == 0) {
        //if (ix == field_count_x/2) {
          type = "crown";
        }
        int fieldVal;
        if (((int)(random(1, 20)) == 1) && player.level >= 3) {
          fieldVal = (int)random(20, 25);
        } else if (((int)(random(1, 12)) == 1) && player.level >= 2) {
          fieldVal = (int)random(15, 20);
        } else if ((int)random(1, 6) == 1) {
          fieldVal = (int)random(10, 25);
        } else if ((int)random(1, 4) == 1) {
          fieldVal = (int)random(5, 10);
        } else {
          fieldVal = (int)random(1, 5);
        }
        fieldArray.add(new Field(
          this.x + lx + (this.field_width/2),
          this.y + ly + (this.field_height/2),
          this.field_width, this.field_height,
          fieldVal,
          type
        ));
        lx += this.field_width + this.field_margin;
      }
      ly += this.field_height + this.field_margin;
    }
  }

  public void draw() {
    textFont(kufam_bold);
    for (int i = 0; i < fieldArray.size(); i++) {
      fieldArray.get(i).draw();
    }
  }
}
