class TextField {
  int x, y, width, height;
  String text = "";
  int caretIndex = 0;
  boolean active = true;
  boolean showCaret = true;
  boolean backspacePressed = false;
  boolean enterPressed = false;
  PFont font;

  TextField(int x, int y, int width, int height, PFont font) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.font = font;
  }

  void display() {
    stroke(185, 185, 185);
    strokeWeight(2);
    fill(255);
    rectMode(CENTER); // Set rectangle mode to center
    rect(x, y, width, height, (int)(width * 0.05)); // Apply corner radius
    fill(0);
    textAlign(LEFT, CENTER);
    textFont(font); // Set the font

    // Center the text vertically
    int textY = y;
    textLeading(height); // Set the leading to match the text field height

    // Calculate the total width of the displayed text
    float totalWidth = textWidth(text);

    // Calculate the starting x-coordinate for rendering the text
    float startX = x - width / 2 + 5;

    // Calculate the offset for text scrolling
    float offset = max(0, totalWidth - width + 10);

    // Adjust the starting x-coordinate based on the offset
    startX -= offset;

    // Render the text only within the visible area
    if (totalWidth > width - 10) {
      int startIndex = max(0, caretIndex - int(offset / textWidth("a")));
      int endIndex = min(text.length(), startIndex + int(width / textWidth("a")) + 1);
      String visibleText = text.substring(startIndex, endIndex);
      float visibleTextWidth = textWidth(visibleText);
      startX = x - visibleTextWidth / 2 + 5;
      text(visibleText, startX, textY);
    } else {
      text(text, startX, textY);
    }

    // Calculate the caret x-coordinate based on the caret index
    float caretX = startX + textWidth(text.substring(0, caretIndex));

    // Blink the caret
    if (active && showCaret) {
      line(caretX, y - height / 2 + 5, caretX, y + height / 2 - 5);
    }
  }

  void update() {
    if (backspacePressed) {
      if (!text.isEmpty() && caretIndex > 0) {
        text = text.substring(0, caretIndex - 1) + text.substring(caretIndex);
        caretIndex--;
      }
      backspacePressed = false;
    }

    if (enterPressed) {
      active = false;
      enterPressed = false;
    }

    if (active) {
      if (millis() % 1000 < 500) {
        showCaret = true;
      } else {
        showCaret = false;
      }
    } else {
      showCaret = false;
    }
  }

  void handleKey(char key) {
    if (active) {
      // Check for control keys
      if (key == CODED && (keyCode == CONTROL || keyCode == ALT || keyCode == SHIFT || keyCode == WINDOWS)) {
        return; // Ignore control keys
      }

      if (key == BACKSPACE) {
        backspacePressed = true;
      } else if (key == ENTER || key == RETURN) {
        enterPressed = true;
      } else if (key == LEFT) {
        caretIndex = max(0, caretIndex - 1); // Move caret to the left
      } else if (key == RIGHT) {
        caretIndex = min(text.length(), caretIndex + 1); // Move caret to the right
      } else if (key == UP || key == DOWN || key == ESC || (key >= 'A' && key <= 'Z')) {
        // Clear the text field for special keys
        text = "";
        caretIndex = 0;
      } else {
        text = text.substring(0, caretIndex) + key + text.substring(caretIndex);
        caretIndex++;
      }

      // Adjust the caret position to ensure it stays within the visible area
      float totalWidth = textWidth(text);
      if (totalWidth > width - 10) {
        float textWidthSum = textWidth(text.substring(caretIndex));
        while (textWidthSum > width - 10) {
          caretIndex--;
          textWidthSum = textWidth(text.substring(caretIndex));
        }
      }
    }
  }
}
